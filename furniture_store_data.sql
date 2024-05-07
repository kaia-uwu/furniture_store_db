use furniture_store;

call add_item("Papentable", 200.99);
call add_item("Schlupenseaten", 50.99);
call add_item("Atabenche", 150.99);
call add_item("Bunkschlef", 100.99);
call add_item("Bettabel", 80.99);

call add_part(1, "Surface");
call add_part(1, "Accent");
call add_part(1, "Legs");

call add_part(2, "Seat");
call add_part(2, "Legs");

call add_part(3, "Seat");
call add_part(3, "Legs");

call add_part(4, "Body");
call add_part(4, "Shelves");

call add_part(5, "Body");
call add_part(5, "Surface");
call add_part(5, "Drawer");

call add_material("Wood 1");
call add_material("Wood 2");
call add_material("Wood 3");
call add_material("Wood 4");
call add_material("Wood 5");
call add_material("Aluminium");
call add_material("Gold");
call add_material("Steel");
call add_material("White marble");
call add_material("Black marble");
call add_material("Beige marble");
call add_material("Leather");
call add_material("Fabric");

call add_part_materials(1, 1, 0);
call add_part_materials(2, 1, 0);
call add_part_materials(2, 7, 49.99);
call add_part_materials(3, 1, 0);

call add_part_materials(4, 1, 0);
call add_part_materials(4, 13, 0);
call add_part_materials(5, 1, 0);
call add_part_materials(5, 6, 10.99);

call add_part_materials(6, 1, 0);
call add_part_materials(6, 2, 0);
call add_part_materials(6, 3, 0);
call add_part_materials(6, 4, 0);
call add_part_materials(6, 13, 0);
call add_part_materials(7, 1, 0);
call add_part_materials(7, 2, 0);
call add_part_materials(7, 3, 0);
call add_part_materials(7, 4, 0);
call add_part_materials(7, 6, 10.99);

call add_part_materials(8, 1, 0);
call add_part_materials(9, 1, 0);

call add_part_materials(10, 1, 0);
call add_part_materials(11, 1, 0);
call add_part_materials(12, 1, 0);

call add_build(1, true);
call add_build(2, true);
call add_build(3, true);
call add_build(4, true);
call add_build(5, true);

call add_build_part(1, 1, 1);
call add_build_part(1, 2, 7);
call add_build_part(1, 3, 1);

call add_build_part(2, 4, 13);
call add_build_part(2, 5, 6);

call add_build_part(3, 6, 4);
call add_build_part(3, 7, 4);

call add_build_part(4, 8, 1);
call add_build_part(4, 9, 1);

call add_build_part(5, 10, 1);
call add_build_part(5, 11, 1);
call add_build_part(5, 12, 1);

call add_user("admin", "admin", "", "", "");
call add_user("test", "test", "Firstname", "Lastname", "0123456789");
call add_user("carl_marks", "commulists", "Carl", "Marks", "0952678123");

call add_to_cart(2, 1, 1);
call add_to_cart(2, 2, 4);
call add_to_cart(2, 3, 4);

call add_order_status("Pending");
call add_order_status("Accepted");
call add_order_status("Rejected");
call add_order_status("Cancelled");
call add_order_status("Dispatched");
call add_order_status("Delivered");

call add_order(2, 6, json_object(), "2023-01-07 21:31:00", "2023-02-11 5:23:00");
call add_order(2, 5, json_object(), "2023-03-04 13:24:00", null);