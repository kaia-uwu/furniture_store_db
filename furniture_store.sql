drop schema if exists furniture_store;
create schema furniture_store;
use furniture_store;

create table items (
	id int unsigned not null auto_increment primary key,
    _name varchar(100),
    price decimal(6,2)
);

create table parts (
	id int unsigned not null auto_increment primary key,
    item_id int unsigned not null,
    _name varchar(50),
    
    foreign key (item_id) references items(id)
);

create table materials (
	id int unsigned not null auto_increment primary key,
    _name varchar(50)
);

create table part_materials (
	id int unsigned not null auto_increment primary key,
    part_id int unsigned not null,
    material_id int unsigned not null,
    added_price decimal(6,2),
    
	foreign key (part_id) references parts(id),
    foreign key (material_id) references materials(id)
);

create table builds (
	id int unsigned not null auto_increment primary key,
    item_id int unsigned not null,
    is_default bool,  
    
    foreign key (item_id) references items(id)
);

create table build_parts (
	id int unsigned not null auto_increment primary key,
    build_id int unsigned,
    part_id int unsigned not null,
    material_id int unsigned not null,
    
    foreign key (build_id) references builds(id),
    foreign key (part_id) references parts(id),
    foreign key (material_id) references part_materials(material_id)
);

create table users (
	id int unsigned not null auto_increment primary key,
    username varchar(50),
    _password varchar(50),
    first_name varchar(50),
    last_name varchar(50),
    phone_number varchar(10)
);

create table cart (
	id int unsigned not null auto_increment primary key,
    user_id int unsigned not null,
    build_id int unsigned not null,
    quantity int unsigned not null,
    
    foreign key (user_id) references users(id),
    foreign key (build_id) references builds(id)
);

create table order_statuses (
	id int unsigned not null auto_increment primary key,
    _name varchar(15)
);

create table orders (
	id int unsigned not null auto_increment primary key,
    user_id int unsigned not null,
    status_id int unsigned not null,
    content json,
	placed timestamp,
	due timestamp,
    
    foreign key (user_id) references users(id),
    foreign key (status_id) references order_statuses(id)
);