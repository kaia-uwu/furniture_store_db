use furniture_store;

delimiter $$

drop procedure if exists add_item; $$
create procedure add_item (
	in i_name varchar(100), 
    in i_cost decimal(6,2)
)
begin 
	insert into items (_name, cost) values (i_name, i_cost);
end; $$

drop procedure if exists add_category; $$
create procedure add_category (
	in i_name varchar(50)
)
begin 
	insert into categories(_name) values (i_name);
end; $$

drop procedure if exists add_item_category; $$
create procedure add_item_category (
	in i_item_id int unsigned, 
    in i_category_id int unsigned
)
begin 
	insert into item_categories(item_id, category_id) values (i_item_id, i_category_id);
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

drop procedure if exists add_material_category; $$
create procedure add_material_category (
	in i_material_id int unsigned, 
    in i_category_id int unsigned
)
begin 
	insert into material_categories(material_id, category_id) values (i_material_id, i_category_id);
end; $$

drop procedure if exists add_part_materials; $$
create procedure add_part_materials (
	in i_part_id int unsigned, 
    in i_material_id int unsigned, 
    in i_added_cost decimal(6,2)
)
begin 
	insert into part_materials(part_id, material_id, added_cost) values (i_part_id, i_material_id, i_added_cost);
end; $$

drop procedure if exists add_build; $$
create procedure add_build (
	in i_item_id int unsigned, 
    in i_is_built_in int unsigned
)
begin 
	set @max_id = (select id from builds order by id desc limit 1);
    set @earliest_deleted_id = (select id from builds where is_deleted = true order by id desc limit 1);
    
    if ((select count(@earliest_deleted_id)) = 1) then
		update builds set item_id = i_item_id, is_built_in = i_is_built_in, is_deleted = false where id = @earliest_deleted_id;
    else
		if (@max_id is null) then 
			set @max_id = 1; 
		else 
			set @max_id = @max_id + 1; 
        end if;
		insert into builds values (@max_id, i_item_id, i_is_built_in, false);
    end if;
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
    declare builds_cursor cursor for 
		select id, is_deleted from builds order by id desc;
	declare continue handler for not found 
		set done = true;
        
	open cart_cursor;
	_loop: loop
		fetch cart_cursor into current_id;
		if done then
			leave _loop;
		end if;
		call delete_from_cart(current_id);
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

	set @max_id = (select id from builds order by id desc limit 1);
    if (i_id = @max_id) then 
		delete from builds where id = i_id;
        
        set done = false;
        open builds_cursor;
		_loop: loop
			fetch builds_cursor into current_id, current_is_deleted;
			if (done or current_is_deleted = false) then
				leave _loop;
			end if;
            delete from builds where id = current_id;
		end loop;
		close builds_cursor;
	else
		update builds set is_deleted = true where id = i_id;
	end if;
end; $$

drop procedure if exists add_build_part; $$
create procedure add_build_part (
	in i_build_id int unsigned, 
    in i_part_id int unsigned, 
    in i_material_id int unsigned
)
begin
	set @max_id = (select id from build_parts order by id desc limit 1);
    set @earliest_deleted_id = (select id from build_parts where is_deleted = true order by id desc limit 1);
    
    if ((select count(@earliest_deleted_id)) = 1) then
		update build_parts set build_id = i_build_id, part_id = i_part_id, material_id = i_material_id, is_deleted = false where id = @earliest_deleted_id;
    else
		if (@max_id is null) then 
			set @max_id = 1; 
		else 
			set @max_id = @max_id + 1; 
        end if;
		insert into build_parts values (@max_id, i_build_id, i_part_id, i_material_id, false);
	end if;
end; $$

drop procedure if exists delete_build_part; $$
create procedure delete_build_part (
	in i_id int unsigned
)
begin
	declare done int default false;
    declare current_id int unsigned;
    declare current_is_deleted bool;
	declare build_parts_cursor cursor for 
		select id, is_deleted from build_parts order by id desc;
	declare continue handler for not found 
		set done = true;
        
	set @max_id = (select id from build_parts order by id desc limit 1);
    if (i_id = @max_id) then 
		delete from build_parts where id = i_id;
        
        set done = false;
        open build_parts_cursor;
		_loop: loop
			fetch build_parts_cursor into current_id, current_is_deleted;
			if (done or current_is_deleted = false) then
				leave _loop;
			end if;
            delete from build_parts where id = current_id;
		end loop;
		close build_parts_cursor;
	else
		update build_parts set is_deleted = true where id = i_id;
	end if;
end; $$

drop procedure if exists add_user; $$
create procedure add_user (
	in i_username varchar(50), 
    in i_first_name varchar(50), 
    in i_middle_name varchar(50), 
    in i_last_name varchar(50), 
    in i_address text, 
    in i_phone_number varchar(50)
)
begin
	insert into users(username, first_name, middle_name, last_name, address, phone_number) values (i_username, i_first_name, i_middle_name, i_last_name, i_address, i_phone_number);
end; $$

drop procedure if exists add_to_cart; $$
create procedure add_to_cart (
	in i_user_id int unsigned,
    in i_build_id int unsigned,
    in i_quantity int unsigned
)
begin
	set @max_id = (select id from cart order by id desc limit 1);
    set @earliest_deleted_id = (select id from cart where is_deleted = true order by id desc limit 1);
    
    if ((select count(@earliest_deleted_id)) = 1) then
		update cart set user_id = i_user_id, build_id = i_build_id, quantity = i_quantity, is_deleted = false where id = @earliest_deleted_id;
    else
		if (@max_id is null) then 
			set @max_id = 1; 
		else 
			set @max_id = @max_id + 1; 
        end if;
		insert into cart values (@max_id, i_user_id, i_build_id, i_quantity, false);
	end if;
end; $$

drop procedure if exists delete_from_cart; $$
create procedure delete_from_cart (
	in i_id int unsigned
)
begin
	declare done int default false;
    declare current_id int unsigned;
    declare current_is_deleted bool;
	declare cart_cursor cursor for 
		select id, is_deleted from cart order by id desc;
	declare continue handler for not found 
		set done = true;
        
	set @max_id = (select id from cart order by id desc limit 1);
    if (i_id = @max_id) then 
		delete from cart where id = i_id;
        
        set done = false;
        open cart_cursor;
		_loop: loop
			fetch cart_cursor into current_id, current_is_deleted;
			if (done or current_is_deleted = false) then
				leave _loop;
			end if;
            delete from cart where id = current_id;
		end loop;
		close cart_cursor;
	else
		update cart set is_deleted = true where id = i_id;
	end if;
end; $$

drop procedure if exists add_order_status; $$
create procedure add_order_status (
	in i_name varchar(15)
)
begin
	insert into order_statuses(_name) values (i_name);
end; $$

drop procedure if exists add_warehouse; $$
create procedure add_warehouse (
	in i_name varchar(50),
    in i_address text
)
begin
	insert into warehouses(_name, address) values (i_name, i_address);
end; $$

drop procedure if exists add_delivery_personnel; $$
create procedure add_delivery_personnel (
	in i_first_name varchar(50),
    in i_middle_name varchar(50),
    in i_last_name varchar(50),
    in i_phone_number varchar(10)
)
begin
	insert into delivery_personnel(first_name, middle_name, last_name, phone_number) values (i_first_name, i_middle_name, i_last_name, i_phone_number);
end; $$

drop procedure if exists add_delivery_vehicle; $$
create procedure add_delivery_vehicle (
	in i_plate_number varchar(10)
)
begin
	insert into delivery_vehicles(plate_number) values (i_plate_number);
end; $$

drop procedure if exists add_order; $$
create procedure add_order (
	in i_user_id int unsigned,
    in i_status_id int unsigned,
    in i_warehouse_id int unsigned,
    in i_delivery_personnel_id int unsigned,
    in i_delivery_vehicle_id int unsigned,
    in i_content json,
	in i_placed timestamp,
	in i_due timestamp
)
begin
	insert into orders(user_id, status_id, warehouse_id, delivery_personnel_id, delivery_vehicle_id, content, placed, due) 
    values (i_user_id, i_status_id, i_warehouse_id, i_delivery_personnel_id, i_delivery_vehicle_id, i_content, i_placed, i_due);
end; $$

drop function if exists serialize_build; $$
create function serialize_build (i_build_id int unsigned) returns json
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
				call delete_build(current_build_id);
			end loop;
			close cart_cursor;
			
			insert into orders(user_id, status_id, content) values (i_user_id, 1, @builds);
            set o_order_id = LAST_INSERT_ID();
		end if;
    commit;
end; $$