use furniture_store;

delimiter $$

drop procedure if exists add_item; $$
create procedure add_item (
	in i_name varchar(100), 
    in i_price decimal(6,2)
)
begin 
	insert into items (_name, price) values (i_name, i_price);
end; $$

drop procedure if exists add_part; $$
create procedure add_part (
	in i_item_id int unsigned, 
    in i_name varchar(50)
)
begin 
	insert into parts(item_id, _name) values (i_item_id, i_name);
end; $$

drop procedure if exists add_material; $$
create procedure add_material (
	in i_name varchar(50)
)
begin 
	insert into materials(_name) values (i_name);
end; $$

drop procedure if exists add_part_materials; $$
create procedure add_part_materials (
	in i_part_id int unsigned, 
    in i_material_id int unsigned, 
    in i_added_price decimal(6,2)
)
begin 
	insert into part_materials(part_id, material_id, added_price) values (i_part_id, i_material_id, i_added_price);
end; $$

drop procedure if exists add_build; $$
create procedure add_build (
	in i_item_id int unsigned, 
    in i_is_default int unsigned
)
begin 
	insert into builds(item_id, is_default) values (i_item_id, i_is_default);
end; $$

drop procedure if exists delete_build; $$
create procedure delete_build (
	in i_id int unsigned
)
begin 
	declare done int default false;
    declare current_id int unsigned;
    declare current_is_deleted bool;
    declare cart_cursor cursor for 
		select id from cart where build_id = i_id;
	declare build_parts_cursor cursor for 
		select id from build_parts where build_id = i_id;
	declare continue handler for not found 
		set done = true;
        
	open cart_cursor;
	_loop: loop
		fetch cart_cursor into current_id;
		if done then
			leave _loop;
		end if;
		delete from cart where id = current_id;
	end loop;
	close cart_cursor;
	
    set done = false;
	open build_parts_cursor;
	_loop: loop
		fetch build_parts_cursor into current_id;
		if done then
			leave _loop;
		end if;
		call delete_build_part(current_id);
	end loop;
	close build_parts_cursor;

	delete from builds where id = i_id;
end; $$

drop procedure if exists add_build_part; $$
create procedure add_build_part (
	in i_build_id int unsigned, 
    in i_part_id int unsigned, 
    in i_material_id int unsigned
)
begin
	insert into build_parts(build_id, part_id, material_id) values (i_build_id, i_part_id, i_material_id);
end; $$

drop procedure if exists delete_build_part; $$
create procedure delete_build_part (
	in i_id int unsigned
)
begin
	delete from build_parts where id = i_id;
end; $$

drop procedure if exists add_user; $$
create procedure add_user (
	in i_username varchar(50), 
    in i_password varchar(50),
    in i_first_name varchar(50), 
    in i_last_name varchar(50), 
    in i_phone_number varchar(50)
)
begin
	if ((select count(id) from users where username = i_username) = 0) then
		insert into users(username, _password, first_name, last_name, phone_number) values (i_username, i_password, i_first_name, i_last_name, i_phone_number);
	end if;
end; $$

drop procedure if exists add_to_cart; $$
create procedure add_to_cart (
	in i_user_id int unsigned,
    in i_build_id int unsigned,
    in i_quantity int unsigned
)
begin
	if ((select count(build_id) from cart where user_id = i_user_id and build_id = i_build_id) > 0) then
        update cart set quantity = quantity + i_quantity where id = (select id from (select * from cart) as _cart where user_id = i_user_id and build_id = i_build_id limit 1);
	else
		insert into cart(user_id, build_id, quantity) values (i_user_id, i_build_id, i_quantity);
	end if;
end; $$

drop procedure if exists edit_in_cart; $$
create procedure edit_in_cart (
	in i_user_id int unsigned,
    in i_build_id int unsigned,
    in i_new_quantity int unsigned
)
begin
	if ((select count(build_id) from cart where user_id = i_user_id and build_id = i_build_id) > 0) then
		set @existing_id = (select id from (select * from cart) as _cart where user_id = i_user_id and build_id = i_build_id limit 1);
        set @quantity = (select quantity from cart where id = @existing_id);
        if (@quantity > 0) then
			if (i_new_quantity <= 0) then
				delete from cart where id = @existing_id;
                if ((select count(id) from cart where build_id = i_build_id) = 0 and !(select is_default from builds where id = i_build_id)) then
					call delete_build(i_build_id);
                end if;
			else
				update cart set quantity = i_new_quantity where id = @existing_id;
			end if;
		end if;
	end if;
end; $$

drop procedure if exists remove_from_cart; $$
create procedure remove_from_cart (
	in i_user_id int unsigned,
    in i_build_id int unsigned,
    in i_quantity int unsigned
)
begin
	if ((select count(build_id) from cart where user_id = i_user_id and build_id = i_build_id) > 0) then
		set @existing_id = (select id from (select * from cart) as _cart where user_id = i_user_id and build_id = i_build_id limit 1);
        set @quantity = (select quantity from cart where id = @existing_id);
        if (@quantity > 0) then
			if (@quantity - i_quantity <= 0) then
				delete from cart where id = @existing_id;
                if ((select count(id) from cart where build_id = i_build_id) = 0 and !(select is_default from builds where id = i_build_id)) then
					call delete_build(i_build_id);
                end if;
			else
				update cart set quantity = @quantity- i_quantity where id = @existing_id;
			end if;
		end if;
	end if;
end; $$

drop procedure if exists add_order_status; $$
create procedure add_order_status (
	in i_name varchar(15)
)
begin
	insert into order_statuses(_name) values (i_name);
end; $$

drop procedure if exists add_order; $$
create procedure add_order (
	in i_user_id int unsigned,
    in i_status_id int unsigned,
    in i_content json,
	in i_placed timestamp,
	in i_due timestamp
)
begin
	insert into orders(user_id, status_id, content, placed, due) 
    values (i_user_id, i_status_id, i_content, i_placed, i_due);
end; $$

drop function if exists serialize_build; $$
create function serialize_build (i_build_id int unsigned) 
returns json
reads sql data
begin
	declare current_part_id int unsigned;
	declare current_material_id int unsigned;
    declare done int default false;
	declare build_parts_cursor cursor for 
		select part_id, material_id from build_parts where build_id = i_build_id;
	declare continue handler for not found 
		set done = true;
        
	set @parts = json_array();
        
	open build_parts_cursor;
	_loop: loop
		fetch build_parts_cursor into current_part_id, current_material_id;
		if done then
			leave _loop;
		end if;
		set @parts = json_merge_preserve(@parts, json_array(json_object("part_id", current_part_id, "material_id", current_material_id)));
	end loop;
    close build_parts_cursor;
    
    return json_object("item_id", (select item_id from builds where id = i_build_id), "parts", cast(@parts as json));
end; $$

drop procedure if exists create_order_from_cart; $$
create procedure create_order_from_cart (
	in i_user_id int unsigned,
    out o_order_id int unsigned
)
begin       
	declare current_build_id int unsigned;
	declare current_quantity int unsigned;
    declare done int default false;
	declare cart_cursor cursor for 
		select build_id, quantity from cart where user_id = i_user_id;
	declare continue handler for not found 
		set done = true;
	
    start transaction;
		if((select count(id) from cart where user_id = i_user_id) > 0) then
			set @builds = json_array();
				
			open cart_cursor;
			_loop: loop
				fetch cart_cursor into current_build_id, current_quantity;
				if done then
					leave _loop;
				end if;
				set @builds = json_merge_preserve(@builds, json_array(json_object("quantity", current_quantity, "build", serialize_build(current_build_id))));
                if ((select is_default from builds where id = current_build_id limit 1) = false) then
					call delete_build(current_build_id);
				else
					delete from cart where build_id = current_build_id;
					if ((select count(id) from cart where build_id = current_build_id) = 0 and !(select is_default from builds where id = current_build_id)) then
						call delete_build(current_build_id);
					end if;
				end if;
			end loop;
			close cart_cursor;
			
			insert into orders(user_id, status_id, content) values (i_user_id, 1, @builds);
            set o_order_id = LAST_INSERT_ID();
		end if;
    commit;
end; $$