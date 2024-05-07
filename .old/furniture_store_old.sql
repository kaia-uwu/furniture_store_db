drop schema if exists furniture_store;
create schema furniture_store;
use furniture_store;

create table items (
	id int unsigned not null auto_increment primary key,
    _name varchar(100),
    cost decimal(6,2)
);

create table categories (
	id int unsigned not null auto_increment primary key,
    _name varchar(50)
);

create table item_categories (
	id int unsigned not null auto_increment primary key,
    item_id int unsigned not null,
    category_id int unsigned not null,
    
    foreign key (item_id) references items(id),
    foreign key (category_id) references categories(id)
);

create table parts (
	id int unsigned not null auto_increment primary key,
    item_id int unsigned not null,
    _name varchar(50),
    
    foreign key (item_id) references items(id)
);

create table materials (
	id int unsigned not null auto_increment primary key,
    _name varchar(50),
    r smallint unsigned,
    g smallint unsigned,
    b smallint unsigned
);

create table material_categories (
	id int unsigned not null auto_increment primary key,
    material_id int unsigned not null,
    category_id int unsigned not null,
    
    foreign key (material_id) references materials(id),
    foreign key (category_id) references categories(id)
);

create table part_materials (
	id int unsigned not null auto_increment primary key,
    part_id int unsigned not null,
    material_id int unsigned not null,
    added_cost decimal(6,2),
    
	foreign key (part_id) references parts(id),
    foreign key (material_id) references materials(id)
);

create table builds (
	id int unsigned not null primary key,
    item_id int unsigned not null,
    is_built_in bool,  
    is_deleted bool,
    
    foreign key (item_id) references items(id)
);

create table build_parts (
	id int unsigned not null primary key,
    build_id int unsigned,
    part_id int unsigned not null,
    material_id int unsigned not null,
    is_deleted bool,
    
    foreign key (build_id) references builds(id),
    foreign key (part_id) references parts(id),
    foreign key (material_id) references materials(id)
);

create table users (
	id int unsigned not null auto_increment primary key,
    username varchar(50),
    first_name varchar(50),
    middle_name varchar(50),
    last_name varchar(50),
    address text,
    e_mail varchar(50),
    phone_number varchar(10)
);

create table cart (
	id int unsigned not null primary key,
    user_id int unsigned not null,
    build_id int unsigned not null,
    quantity int unsigned not null,
    is_deleted bool,
    
    foreign key (user_id) references users(id),
    foreign key (build_id) references builds(id)
);

create table order_statuses (
	id int unsigned not null auto_increment primary key,
    _name varchar(15)
);

create table warehouses (
	id int unsigned not null auto_increment primary key,
    _name varchar(50),
    address text
);

create table delivery_personnel (
	id int unsigned not null auto_increment primary key,
    first_name varchar(50),
    middle_name varchar(50),
    last_name varchar(50),
    e_mail varchar(50),
    phone_number varchar(10)
);

create table delivery_vehicles (
	id int unsigned not null auto_increment primary key,
    plate_number varchar(8)
);

create table orders (
	id int unsigned not null auto_increment primary key,
    user_id int unsigned not null,
    status_id int unsigned not null,
    warehouse_id int unsigned,
    delivery_personnel_id int unsigned,
    delivery_vehicle_id int unsigned,
    content json,
	placed timestamp,
	due timestamp,
    
    foreign key (user_id) references users(id),
    foreign key (status_id) references order_statuses(id),
    foreign key (warehouse_id) references warehouses(id),
    foreign key (delivery_personnel_id) references delivery_personnel(id),
    foreign key (delivery_vehicle_id) references delivery_vehicles(id)
);
