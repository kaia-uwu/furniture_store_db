use furniture_store;

-- tests the contiguity preserving delete for builds and all related tables
call delete_build(1);
select * from builds;
call delete_build(2);
select * from builds;
call delete_build(3);
select * from builds;
select * from build_parts;
select * from cart;

call add_build(1, true);
call add_build(2, true);
call add_build(3, true);

call add_build_part(4, 1, 1);
call add_build_part(4, 2, 4);
call add_build_part(4, 3, 1);
call add_build_part(5, 4, 1);
call add_build_part(5, 5, 1);
call add_build_part(5, 6, 1);
call add_build_part(6, 7, 6);

call add_to_cart(2, 4, 1);
call add_to_cart(2, 5, 4);
call add_to_cart(2, 6, 4);

select * from builds;
select * from build_parts;
select * from cart; 

-- test creation of an order from the cart
select * from cart where user_id = 2;
call create_order_from_cart(2, @created_order_id);
select @created_order_id;
select * from cart where user_id = 2;
select * from orders;