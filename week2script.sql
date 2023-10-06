use littlelemondb;


# task 1: In the first task, Little Lemon need you to create a virtual table called OrdersView 
# that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with 
# a quantity greater than 2. 
drop view if exists ordersview;
create view ordersview as
select
	order_id,
    quantity,
    total_cost
from orders
where quantity > 2;

select * from ordersview

# task 2: For your second task, Little Lemon need information from four tables on all customers 
# with orders that cost more than $150
drop view if exists highcostordersview;
create view highcostordersview as
select
    o.order_id,
    o.total_cost,
    c.customer_id,
    c.customer_name,
    m.item_name,
    m.item_category
from orders as o
left join customers as c
	on o.customer_id = c.customer_id
left join menu as m
	on o.item_id = m.item_id
where o.total_cost > 40;

select * from highcostordersview

# task 3: For the third and final task, Little Lemon need you to find all menu items for 
# which more than 2 orders have been placed.
drop view if exists menuitemshighvolumeview;
create view menuitemshighvolumeview as
select 
	item_name
from menu
where item_id = any (select item_id from orders where quantity > 2);

select * from menuitemshighvolumeview

# task 1: In this first task, Little Lemon need you to create a procedure that displays the 
# maximum ordered quantity in the Orders table
drop procedure if exists GetMaxQuantity;
delimiter //
create procedure GetMaxQuantity()
begin
	select 
		max(quantity) 
	from orders;
end //

call GetMaxQuantity();

# task 2: In the second task, Little Lemon need you to help them to create a 
# statement called GetOrderDetail. This prepared statement will help to reduce 
# the parsing time of queries. It will also help to secure the database from SQL injections.
prepare GetOrderDetail from 'select * from orders where order_id = ?';

set @id = 1
execute GetOrderDetail using @id;

# task 3: Your third and final task is to create a stored procedure called CancelOrder. 
# Little Lemon want to use this stored procedure to delete an order record based on the user 
# input of the order id.
drop procedure if exists CancelOrder;
delimiter //
create procedure CancelOrder(in id int)
begin
	declare message varchar(50);
    
	delete from orders
	where order_id = id;
    
    set message = concat('Order ', id, ' is canceled');
    
    select message as 'Confirmation';
end //

call CancelOrder(4);

# task 2: For your second task, Little Lemon need you to create a stored procedure called CheckBooking 
# to check whether a table in the restaurant is already booked. 
drop procedure if exists CheckBooking;
delimiter //
create procedure CheckBooking(in booking_date_in date, in table_number_in int)
begin
    declare message varchar(50);

    select count(*) into @table_count
    from bookings
    where booking_date = booking_date_in and table_number = table_number_in;

    if (@table_count > 0) then
        set message = concat('Table ', table_number_in, ' is already booked.');
    else
        set message = concat('Table ', table_number_in, ' is available.');
    end if;

    select message as 'Booking Status';
end //

call CheckBooking('2023-10-02', 7);

# task 3: For your third and final task, Little Lemon need to verify a booking, and decline any 
# reservations for tables that are already booked under another name. 
drop procedure if exists addvalidbooking;
delimiter //
create procedure AddValidBooking (in booking_id_in int, in booking_date_in date, in table_number_in int)
begin
	declare message varchar(50);
    start transaction;
    
    select count(*) into @table_count
    from bookings
    where booking_date = booking_date_in and table_number = table_number_in;

    if (@table_count = 0) then
        insert into bookings (booking_id, booking_date, table_number)
        values 
        (booking_id_in, booking_date_in, table_number_in);
        commit;
        set message = 'Booking completed.';
    else
		rollback;
        set message = 'Conflicting booking.';
    end if;
    
    select message as 'Booking Status';
end //

call AddValidBooking(4, '2023-10-05', 9);

# task 1: In this first task you need to create a new procedure called AddBooking to add a new table booking record.
drop procedure if exists AddBooking;
delimiter //
create procedure AddBooking(in booking_id_in int, in booking_date_in date, in table_number_in int)
begin
	insert into bookings (booking_id, booking_date, table_number)
	values 
	(booking_id_in, booking_date_in, table_number_in);
    
    select 'New booking added.' as Confirmation;
end //

call AddBooking(5, '2023-10-05', 4);

# task 2:  Little Lemon need you to create a new procedure called UpdateBooking that they can use to update 
# existing bookings in the booking table.
drop procedure if exists UpdateBooking;
delimiter //
create procedure UpdateBooking(in booking_id_in int, in booking_date_new_in date)
begin
	update bookings
    set booking_date = booking_date_new_in
    where booking_id = booking_id_in;
    
    select concat('Updated # ', booking_id_in, '; ', booking_date_new_in) as Confirmation;
end //

call UpdateBooking(5, '2023-10-08');

# task 3: Little Lemon need you to create a new procedure called CancelBooking that they can use to cancel or remove a booking.
drop procedure if exists CancelBooking;
delimiter //
create procedure CancelBooking(in booking_id_in int)
begin
	delete from bookings
    where booking_id = booking_id_in;
    
    select concat('Deleted # ', booking_id_in) as Confirmation;
end //

call CancelBooking(5);