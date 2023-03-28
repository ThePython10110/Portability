local formspec_escape = minetest.formspec_escape
local show_formspec = minetest.show_formspec
local C = minetest.colorize
local text_color = "#313131"
local itemslot_bg = mcl_formspec.get_itemslot_bg

minetest.register_tool("portability:crafting_table", {
    description = "Portable Crafting Table",
    inventory_image = "portability_crafting_table.png",
    on_place = function(itemstack, player, pointed_thing)
        mcl_crafting_table.show_crafting_form(player)
    end,
    on_secondary_use = function(itemstack, player, pointed_thing)
        mcl_crafting_table.show_crafting_form(player)
    end
})

minetest.register_craft({
    output = "portability:crafting_table",
    recipe = {
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_crafting_table:crafting_table","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"}
    }
})

-- Christmas chest setup
local it_is_christmas = false
local date = os.date("*t")
if (
	date.month == 12 and (
		date.day == 24 or
		date.day == 25 or
		date.day == 26
	)
) then
	it_is_christmas = true
end

local ender_chest_texture = {"portability_ender_chest.png"}
if it_is_christmas then
    ender_chest_texture = {"portability_ender_chest_christmas.png"}
end

local formspec_ender_chest = "size[9,8.75]"..
	"label[0,0;"..minetest.formspec_escape(minetest.colorize("#313131", "Ender Chest")).."]"..
	"list[current_player;enderchest;0,0.5;9,3;]"..
	mcl_formspec.get_itemslot_bg(0,0.5,9,3)..
	"label[0,4.0;"..minetest.formspec_escape(minetest.colorize("#313131", "Inventory")).."]"..
	"list[current_player;main;0,4.5;9,3;9]"..
	mcl_formspec.get_itemslot_bg(0,4.5,9,3)..
	"list[current_player;main;0,7.74;9,1;]"..
	mcl_formspec.get_itemslot_bg(0,7.74,9,1)..
	"listring[current_player;enderchest]"..
	"listring[current_player;main]"

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname:find("portability:ender_chest") == 1 then
        if fields.quit then
            minetest.sound_play("mcl_chests_enderchest_close", {to_player = player:get_player_name()})
        end
    end
end)

minetest.register_tool("portability:ender_chest", {
    description = "Portable Ender Chest",
    inventory_image = ender_chest_texture,
    on_place = function(itemstack, player, pointed_thing)
        minetest.sound_play("mcl_chests_enderchest_open", {to_player = player:get_player_name()})
        minetest.show_formspec(player:get_player_name(), "portability:ender_chest_"..player:get_player_name(), formspec_ender_chest)
    end,
    on_secondary_use = function(itemstack, player, pointed_thing)
        minetest.show_formspec(player:get_player_name(), "portability:ender_chest_"..player:get_player_name(), formspec_ender_chest)
    end
})



minetest.register_craft({
    output = "portability:ender_chest",
    recipe = {
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_chests:ender_chest","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"}
    }
})

