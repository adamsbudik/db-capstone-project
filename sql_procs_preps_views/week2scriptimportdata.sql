use littlelemondb;

insert into bookings (booking_id, booking_date, table_number)
values
(1, '2023-10-02', 8),
(2, '2023-10-03', 8),
(3, '2023-10-04', 6);

insert into customers (customer_id, customer_name, contact_number)
values
(1, 'cust one', 123456789),
(2, 'cust two', 987654321)

insert into menu (item_id, item_category, item_name)
values
(1, 'starter', 'salad'),
(2, 'starter', 'soup'),
(3, 'entree', 'beef'),
(4, 'entree', 'chicken'),
(5, 'dessert', 'cake')

insert into orders_delivery_status (order_id, delivery_date, status)
values
(1, '2023-10-02', 'partial delivery'),
(2, '2023-10-03', 'completed'),
(3, '2023-10-04', 'no items delivered');

insert into staff (staff_id, staff_name, role, salary)
values
(1, 'staff one', 'manager', 70000),
(2, 'staff two', 'assistant', 50000);

insert into orders (order_id, item_id, staff_id, customer_id, booking_id, order_date, quantity, total_cost)
values
(1, 1, 2, 1, 1, '2023-10-02', 6, 30),
(1, 3, 2, 1, 1, '2023-10-02', 2, 20),
(1, 5, 2, 1, 1, '2023-10-02', 2, 10),
(2, 1, 1, 2, 2, '2023-10-03', 1, 5),
(2, 2, 1, 2, 2, '2023-10-03', 1, 4),
(2, 4, 1, 2, 2, '2023-10-03', 1, 10),
(3, 3, 1, 1, 3, '2023-10-04', 5, 50);