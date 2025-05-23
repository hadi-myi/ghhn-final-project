import mysql.connector
from mysql.connector import errorcode
# The connection part of the code was used from the safe connection with helper functions shared connections file from class

def online_order(store_id: int, customer_id: int, order_items: dict, cnx: mysql.connector.connection):
    """ Function responsible for placing an online order. This function directly interacts with the 
    database to place an order for a customer at a specific store. It checks the availability of items,
    calculates the total price, and updates the inventory accordingly. If there are any issues with the order,
    it will print am error message and log the order as unfulfilled in the database.

    : param store_id: The ID of the store to order from.
    : param customer_id: The ID of the customer placing the order.
    : param order_items: A dictionary of items to order, where the key is the UPC and the value is the quantity.
    : param cnx: An open SQL connection.
    """

    # Since the connection is passed in as an argument, we might want to double-check that it's actually open
    if cnx is None or not cnx.is_connected():
        raise ValueError("The connection wasn't connected!")

    # Same, but now with a cursor for your SQL work
    try:
        # Open a cursor for SQL work
        with cnx.cursor() as cursor:
            # Checks to see if the store is valid, if not then print invalid
            cursor.execute("""SELECT store_id 
                           FROM STORE 
                           WHERE store_id = %s;""", 
                           (store_id,))
            store_res = cursor.fetchall()
            if not store_res:
                print(f"Invalid store {store_id}")
                return

            # Checks to see if the customer is valid, if not then print invalid
            cursor.execute("""SELECT customer_id 
                           FROM CUSTOMER 
                           WHERE customer_id = %s;""", 
                           (customer_id,))
            customer_res = cursor.fetchall()
            if not customer_res:
                print(f"Invalid customer {customer_id}")
                return
            
            # Variables to track nessecary information for order
            insufficient_inventory = [] # List of tuples
            total_price = 0
            items_to_add = [] # List of tuples

            # loop through the order items and check if they are in stock
            for upc, qty in order_items.items():
                cursor.execute("""SELECT s.current_inventory, s.overriden__price, p.product_name 
                               FROM SELL AS s 
                               JOIN PRODUCT AS p ON s.upc = p.upc 
                               WHERE s.store_id = %s AND s.upc = %s;""", 
                               (store_id, upc))
                result = cursor.fetchall()

                if not result:
                    print(f"Item {upc} not found in store {store_id}.")
                    continue

                # Access info from result
                row = result[0]
                current_inventory = row[0]
                overridden_price = row[1]
                product_name = row[2]

                # Check if the quantity ordered is available
                if current_inventory < qty:
                    print(f"Insufficient inventory for item {product_name}, requested:{qty}, in stock:{current_inventory}")
                    insufficient_inventory.append((upc, qty))

                    #Check the stores state
                    cursor.execute("""SELECT store_region 
                                   FROM STORE WHERE store_id = %s;""", 
                                   (store_id,))
                    region_result = cursor.fetchall()

                    # Grab the region from the result
                    region = region_result[0][0]
                    print(f"Store {store_id} is located in region: {region}")

                    # Find other stores in the same region with enough stock
                    cursor.execute("""SELECT s.store_id, s.current_inventory 
                                   FROM SELL AS s
                                   JOIN STORE AS st ON s.store_id = st.store_id
                                   WHERE s.upc = %s AND s.current_inventory >= %s AND st.store_region = %s AND s.store_id != %s """, 
                                   (upc, qty, region, store_id))
                    # Store the stores with enoguh stcok within the region in this variable
                    other_store_results = cursor.fetchall()

                    # Print out whihc stores are able to fufill the order
                    if other_store_results:
                        for other_store_id, inv in other_store_results:
                            print(f"Store {other_store_id} in region {region} has enough stock {inv} of item {upc}")
                    else:
                        print(f"No other stores in region {region} have enough stock for item {upc}")
                else:
                    # get the total price
                    total_price += overridden_price * qty
                    items_to_add.append((store_id, customer_id, upc, qty))

            # If the order is unfulfilled, print to the customer and track as an unfulfilled order in the ORDERS table
            if insufficient_inventory:
                print("Some items could not be ordered due to insufficient inventory:")
                for upc, qty in insufficient_inventory:
                    print(f"UPC: {upc}, Quantity: {qty}")
                 # Store as failed order in the ORDERS table by making the attribute order_status = 0
                cursor.execute("""
                    INSERT INTO ORDERS (order_type, order_status, order_date, total_order_price, store_id, customer_id)
                    VALUES (%s, %s, NOW(), %s, %s, %s);""", 
                    (1, 0, 0.00, store_id, customer_id))
                cnx.commit()  
                return
            
            # If all items are available, insert into the ORDERS table in the database
            cursor.execute(
                """INSERT INTO ORDERS (order_type, order_status, order_date, total_order_price, store_id, customer_id) 
                VALUES (%s, %s, NOW(), %s, %s, %s);""",
                (1, 1, total_price, store_id, customer_id))

            # Get the most recent order_id for this customer at this store
            cursor.execute(
                """SELECT order_id
                FROM ORDERS 
                WHERE customer_id = %s AND store_id = %s
                ORDER BY order_id DESC
                LIMIT 1;""",
                (customer_id, store_id))
            # grabs the order id from the most recent order
            order_id = cursor.fetchall()[0][0]

            # Add each item into ORDER_INCLUDES and update inventory
            for store_id, customer_id, upc, qty in items_to_add:
                cursor.execute(
                    """INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) 
                    VALUES (%s, %s, %s); """,
                    (order_id, upc, qty))
                cursor.execute(
                    """UPDATE SELL SET current_inventory = current_inventory - %s 
                    WHERE store_id = %s AND UPC = %s;""",
                    (qty, store_id, upc))
            # Commit changes
            cnx.commit()

            # Prints the order summary
            print(f"Order {order_id} placed successfully for customer {customer_id} at store {store_id}")
            print("Items Ordered:")
            # Print the upc and qty 
            for _, _, upc, qty in items_to_add:
                print(f"UPC: {upc}, Quantity: {qty}")
            print("Total price:", total_price)

    # This code should handle any issues DURING SQL work.
    except mysql.connector.Error as err:
        print('Error while executing', cursor.statement, '--', str(err))
        # If some part of our SQL queries errored, explicitly rollback all of them
        # to "reset" the database back to its original state. Only needed for SQL
        # queries that alter the database.
        cnx.rollback()

""" 
Test 1:

test_order = {
    '0000000000000001': 2,
    '0000000000000003': 5,
    '0000000000000005': 1,
}
online_order(store_id=1, customer_id=1, order_items=test_order, cnx=cnx)

Output:
Order 20 placed successfully for customer 1 at store 1
Items Ordered:
UPC: 0000000000000001, Quantity: 2
UPC: 0000000000000003, Quantity: 5
UPC: 0000000000000005, Quantity: 1
Total price: 579.31
True

Test 2:
test_order = {
                '0000000000000004': 20,
            }
            online_order(store_id=1, customer_id=1, order_items=test_order, cnx=cnx)

Output:
Insufficient inventory for item Energy Drink, requested:20, in stock:1
Store 1 is located in region: IL
Store 3 in region IL has enough stock 31 of item 0000000000000004
Some items could not be ordered due to insufficient inventory:
UPC: 0000000000000004, Quantity: 20
True
"""
