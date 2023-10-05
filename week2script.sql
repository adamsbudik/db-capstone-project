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
delimiter //
drop procedure if exists GetMaxQuantity;
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
delimiter //
drop procedure if exists CancelOrder;
create procedure CancelOrder(in id int, out message varchar(50))
begin
set message = concat('Order ', id, ' is canceled');
delete from orders
where order_id = id;
end //

call CancelOrder(4, @Confirmation);
select @Confirmation;