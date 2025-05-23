USE ghhn;

-- store vendor and brand
INSERT INTO STORE(
    store_country, store_region, store_street_address, store_city,
    store_zip, store_phone,
    Monday, M_open, M_close,
    Tuesday, T_open, T_close,
    Wednesday, W_open, W_close,
    Thursday, Th_open, Th_close,
    Friday, F_open, F_close,
    Saturday, Sa_open, Sa_close,
    Sunday, Su_open, Su_close) 
VALUES 
('USA', 'IL', 'North Main St', 'Illinois', '61077', '1234567890', 
 TRUE, '08:00:00', '22:00:00',
 TRUE, '08:00:00', '22:00:00',
 TRUE, '08:00:00', '22:00:00',
 TRUE, '08:00:00', '22:00:00',
 TRUE, '08:00:00', '22:00:00',
 TRUE, '09:00:00', '21:00:00',
 TRUE, '10:00:00', '20:00:00'),

('USA', 'NY', '456 Broadway Ave', 'Brooklyn', '11211', '9488376565', 
 TRUE, '08:00:00', '21:00:00',
 TRUE, '08:00:00', '21:00:00',
 TRUE, '08:00:00', '21:00:00',
 TRUE, '08:00:00', '21:00:00',
 TRUE, '08:00:00', '21:00:00',
 TRUE, '09:00:00', '20:00:00',
 FALSE, NULL, NULL),

('USA', 'IL', '111 Anna Marie Rd', 'Chicago', '60611', '4456371059',
 TRUE, '09:00:00', '22:00:00',
 TRUE, '09:00:00', '22:00:00',
 TRUE, '09:00:00', '22:00:00',
 TRUE, '09:00:00', '22:00:00',
 TRUE, '09:00:00', '22:00:00',
 TRUE, '10:00:00', '21:00:00',
 TRUE, '10:00:00', '21:00:00'),

('USA', 'IL', '1010 W Madison', 'Chicago', '60607', '2247300989',
 TRUE, '07:00:00', '23:00:00',
 TRUE, '07:00:00', '23:00:00',
 TRUE, '07:00:00', '23:00:00',
 TRUE, '07:00:00', '23:00:00',
 TRUE, '07:00:00', '23:00:00',
 TRUE, '08:00:00', '22:00:00',
 TRUE, '09:00:00', '21:00:00'),

('USA', 'TX', '222 Laek Ave', 'Austin', '78701', '3347301092',
 TRUE, '08:00:00', '20:00:00',
 TRUE, '08:00:00', '20:00:00',
 TRUE, '08:00:00', '20:00:00',
 TRUE, '08:00:00', '20:00:00',
 TRUE, '08:00:00', '20:00:00',
 TRUE, '09:00:00', '19:00:00',
 TRUE, '10:00:00', '18:00:00'),

('USA', 'TX', '333 Southwest St', 'Austin', '78701', '2238949399',
 TRUE, '09:00:00', '21:00:00',
 TRUE, '09:00:00', '21:00:00',
 TRUE, '09:00:00', '21:00:00',
 TRUE, '09:00:00', '21:00:00',
 TRUE, '09:00:00', '21:00:00',
 TRUE, '10:00:00', '20:00:00',
 FALSE, NULL, NULL);

INSERT INTO VENDOR (vendor_name, vendor_phone, vendor_email) VALUES
('PepsiCo', '1234567890', 'contact@pepsico.com'),
('Nestle', '9876543210', 'support@nestle.com');


INSERT INTO BRAND (brand_name, vendor_id) VALUES
('Pepsi', 1),
('Fanta', 1),
('Dove', 2),
('Ben & Jerrys', 2);
-- PRODUCT
INSERT INTO PRODUCT (UPC, product_name, source_nation, package_length, package_width, package_height, std_price, brand_id)
VALUES
('0000000000000001', 'Blood Cleaner', 'USA', 0.210, 0.320, 0.150, 19.99, 1),
('0000000000000002', 'Wallet', 'Italy', 0.085, 0.055, 0.020, 24.99, 2),
('0000000000000003', 'Detergent', 'Germany', 0.500, 0.400, 0.350, 9.49, 3),
('0000000000000004', 'Energy Drink', 'South Korea', 0.130, 0.050, 0.050, 2.99, 4),
('0000000000000005', 'Chainsaw', 'Canada', 0.950, 0.850, 0.600, 89.99, 1),
('0000000000000006', 'Backpack', 'Vietnam', 0.720, 0.500, 0.200, 49.99, 2),
('0000000000000007', 'Toothpaste', 'India', 0.170, 0.030, 0.030, 1.99, 3),
('0000000000000008', 'Laptop Stand', 'China', 0.680, 0.500, 0.060, 34.99, 4),
('0000000000000009', 'Shampoo', 'UK', 0.250, 0.050, 0.050, 5.99, 1),
('0000000000000010', 'Notebook', 'Japan', 0.300, 0.210, 0.010, 3.49, 2),
('0000000000000011', 'Electric Kettle', 'France', 0.330, 0.250, 0.300, 29.99, 1),
('0000000000000012', 'Hair Dryer', 'Brazil', 0.290, 0.180, 0.250, 39.99, 3);

-- Products sold by vendor 1
INSERT INTO VENDOR_PRODUCTS (UPC, vendor_id, unit_price) VALUES
('0000000000000001', 1, 11.99),  
('0000000000000002', 1, 14.99),  
('0000000000000005', 1, 53.99), 
('0000000000000006', 1, 29.99), 
('0000000000000009', 1, 3.59), 
('0000000000000010', 1, 2.09), 
('0000000000000011', 1, 17.99);

-- Products sold by vendor 2
INSERT INTO VENDOR_PRODUCTS (UPC, vendor_id, unit_price) VALUES
('0000000000000003', 2, 5.69),   
('0000000000000004', 2, 1.79),  
('0000000000000007', 2, 1.19),   
('0000000000000008', 2, 20.99),  
('0000000000000012', 2, 23.99);


-- CUSTOMER
INSERT INTO CUSTOMER (
    customer_name, customer_email, customer_phone, 
    customer_country, customer_region, customer_st_addr, 
    customer_city, customer_zip, app_user
)
VALUES
('Hadi Imtiaz', 'hadi@iwu.edu', '309-123-4567', 'USA', 'Illinois', '123 Main St', 'Bloomington', '61701', TRUE),
('Harsh Patel', 'harsh@cvs.com', '403-984-6677', 'USA', 'Illinois', '456 Broadway', 'South Elgin', '67321', FALSE),
('Grace Poulton', 'grace@email.com', '152-334-4556', 'USA', 'Texas', '904 Lecter St', 'San Antonio', '80333', TRUE),
('Nawvatin Azhar', 'Nawvatin@deeplearning.com', '759-323-9823', 'USA', 'New York', '456 7th Ave', 'New York','91936', FALSE);

INSERT INTO SELL (store_id, UPC, max_inventory, current_inventory, overriden__price) VALUES
(1, '0000000000000001', 84, 60, 59.15),
(1, '0000000000000002', 107, 63, 5.47),
(1, '0000000000000003', 193, 66, 79.37),
(1, '0000000000000004', 177, 1, 77.63),
(1, '0000000000000005', 59, 21, 64.16),
(1, '0000000000000006', 62, 16, 70.01),
(1, '0000000000000007', 192, 114, 74.68),
(1, '0000000000000008', 77, 73, 25.42),
(1, '0000000000000009', 67, 43, 33.1),
(1, '0000000000000010', 81, 79, 3.52),
(1, '0000000000000011', 179, 97, 47.8),
(1, '0000000000000012', 131, 125, 69.79),
(2, '0000000000000001', 174, 167, 59.06),
(2, '0000000000000002', 182, 23, 4.18),
(2, '0000000000000003', 70, 10, 50.64),
(2, '0000000000000004', 196, 170, 67.5),
(2, '0000000000000005', 82, 35, 30.44),
(2, '0000000000000006', 82, 5, 74.36),
(2, '0000000000000007', 67, 45, 19.14),
(2, '0000000000000008', 66, 60, 52.59),
(2, '0000000000000009', 107, 67, 89.97),
(2, '0000000000000010', 146, 75, 87.36),
(2, '0000000000000011', 162, 1, 3.68),
(2, '0000000000000012', 150, 40, 27.66),
(3, '0000000000000001', 114, 81, 1.07),
(3, '0000000000000002', 111, 80, 44.22),
(3, '0000000000000003', 93, 66, 92.12),
(3, '0000000000000004', 67, 31, 17.6),
(3, '0000000000000005', 105, 59, 2.44),
(3, '0000000000000006', 140, 126, 85.67),
(3, '0000000000000007', 142, 65, 16.7),
(3, '0000000000000008', 97, 80, 36.95),
(3, '0000000000000009', 77, 22, 38.56),
(3, '0000000000000010', 162, 47, 51.66),
(3, '0000000000000011', 100, 60, 53.42),
(3, '0000000000000012', 200, 84, 81.17),
(4, '0000000000000001', 58, 45, 81.09),
(4, '0000000000000002', 68, 62, 20.57),
(4, '0000000000000003', 75, 37, 98.28),
(4, '0000000000000004', 120, 3, 88.1),
(4, '0000000000000005', 109, 75, 11.68),
(4, '0000000000000006', 199, 180, 37.59),
(4, '0000000000000007', 110, 0, 46.22),
(4, '0000000000000008', 200, 21, 37.22),
(4, '0000000000000009', 185, 170, 30.93),
(4, '0000000000000010', 129, 106, 8.56),
(4, '0000000000000011', 145, 31, 80.5),
(4, '0000000000000012', 110, 70, 4.97),
(5, '0000000000000001', 180, 176, 5.41),
(5, '0000000000000002', 200, 3, 96.89),
(5, '0000000000000003', 178, 171, 21.16),
(5, '0000000000000004', 177, 76, 41.26),
(5, '0000000000000005', 133, 126, 5.59),
(5, '0000000000000006', 83, 47, 5.94),
(5, '0000000000000007', 80, 36, 10.14),
(5, '0000000000000008', 136, 128, 80.37),
(5, '0000000000000009', 123, 111, 4.6),
(5, '0000000000000010', 75, 38, 39.99),
(5, '0000000000000011', 182, 161, 87.48),
(5, '0000000000000012', 196, 35, 43.7),
(6, '0000000000000001', 112, 95, 71.29),
(6, '0000000000000002', 118, 68, 99.78),
(6, '0000000000000003', 64, 27, 70.08),
(6, '0000000000000004', 94, 84, 47.94),
(6, '0000000000000005', 182, 1, 44.01),
(6, '0000000000000006', 166, 37, 68.45),
(6, '0000000000000007', 194, 28, 87.26),
(6, '0000000000000008', 93, 57, 66.44),
(6, '0000000000000009', 81, 24, 21.48),
(6, '0000000000000010', 196, 179, 35.73),
(6, '0000000000000011', 65, 4, 32.99),
(6, '0000000000000012', 172, 139, 42.01);

INSERT INTO ORDERS (order_type, order_status, order_date, total_order_price, store_id, customer_id)
VALUES 
  (1, 1, '2025-04-10 14:30:00', 149.99, 1, 1),
  (0, 1, '2025-04-11 09:20:00', 45.50, 2, 2),
  (1, 0, '2025-04-12 17:45:00', 300.00, 3, 3),
  (0, 1, '2025-04-13 11:10:00', 78.25, 1, 4),
  (1, 1, '2025-04-14 16:00:00', 199.99, 2, 3),
  (0, 0, '2025-04-15 08:30:00', 59.75, 1, 2),
  (1, 1, '2025-04-15 20:10:00', 500.00, 3, 1),
  (0, 0, '2025-04-16 13:25:00', 23.99, 2, 3),
  (1, 1, '2025-04-17 10:45:00', 130.00, 1, 2),
  (0, 1, '2025-04-17 19:15:00', 67.49, 2, 4);


INSERT INTO REORDER_REQUEST (reorder_date, quantity_requested, total_cost, seen_status, vendor_id, upc, store_id)
VALUES
  ('2025-04-01 10:00:00', 24, 287.76, 0, 1, '0000000000000001', 1),
  ('2025-04-02 10:00:00', 14, 755.86, 1, 1, '0000000000000005', 1),
  ('2025-04-03 10:00:00', 24, 86.16, 0, 1, '0000000000000009', 1),
  ('2025-04-09 10:00:00', 78, 92.82, 0, 2, '0000000000000007', 1),
  ('2025-04-10 10:00:00', 3, 71.97, 1, 2, '0000000000000012', 1),
  ('2025-04-11 10:00:00', 176, 315.04, 0, 2, '0000000000000004', 1),
  ('2025-04-12 10:00:00', 1, 20.99, 1, 2, '0000000000000008', 1);



INSERT INTO SHIPMENT (shipment_no, reorder_id, expected_delivery, received_date)
VALUES
  (1, 1, '2025-04-05 14:00:00', '2025-04-06 10:30:00'),
  (2, 2, '2025-04-06 15:00:00', '2025-04-07 09:45:00'),
  (3, 3, '2025-04-07 16:00:00', NULL),
  (4, 4, '2025-04-08 10:00:00', '2025-04-08 14:20:00'),
  (5, 5, '2025-04-09 12:30:00', NULL),
  (6, 6, '2025-04-10 09:00:00', '2025-04-10 17:00:00'),
  (7, 7, '2025-04-11 11:15:00', '2025-04-12 08:50:00');


INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (1, '0000000000000001', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (1, '0000000000000004', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (1, '0000000000000005', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (3, '0000000000000005', 4);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (2, '0000000000000007', 2);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (4, '0000000000000009', 1);
INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (4, '0000000000000007', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (4, '0000000000000004', 4);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (5, '0000000000000001', 2);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (5, '0000000000000002', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (6, '0000000000000011', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (6, '0000000000000012', 17);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (6, '0000000000000003', 2);


INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (7, '0000000000000010', 1);


INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (7, '0000000000000011', 4);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (8, '0000000000000009', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (9, '0000000000000002', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (9, '0000000000000004', 1);

INSERT INTO ORDER_INCLUDES (order_id, UPC, buying_quantity) VALUES (10, '0000000000000007', 1);

COMMIT;

