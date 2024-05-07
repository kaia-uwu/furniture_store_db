use furniture_store;

drop view if exists all_items;
create view all_items as
select
items.id as item_id, items._name as item_name, items.price,
parts.id as part_id, parts._name as part_name,
materials.id as material_id, materials._name as material_name,
part_materials.added_price
from items
left join parts on parts.item_id = items.id
left join part_materials on part_materials.part_id = parts.id
left join materials on materials.id = part_materials.material_id
order by items.id;

drop view if exists all_default_builds;
create view all_default_builds as
select
_builds.id as build_id,
items._name as item_name,
parts._name as part_name,
materials._name as material_name
from (select * from builds where builds.is_default) as _builds
left join items on items.id = _builds.item_id
left join build_parts on build_parts.build_id = _builds.id
left join parts on parts.id = build_parts.part_id
left join materials on materials.id = build_parts.material_id
order by _builds.id;

drop view if exists all_non_default_user_cart_builds;
create view all_non_default_user_cart_builds as
select
cart.user_id as user_id,
_builds.id as build_id,
items._name as item_name,
parts._name as part_name,
materials._name as material_name
from (select * from builds where !builds.is_default) as _builds
left join items on items.id = _builds.item_id
left join build_parts on build_parts.build_id = _builds.id
left join parts on parts.id = build_parts.part_id
left join materials on materials.id = build_parts.material_id
left join cart on cart.build_id = _builds.id
order by _builds.id;