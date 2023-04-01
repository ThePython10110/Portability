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

local ender_chest_texture = "portability_ender_chest.png"
if it_is_christmas then
    ender_chest_texture = "portability_ender_chest_christmas.png"
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
            minetest.sound_play("ender_chest_close", {to_player = player:get_player_name()})
        end
    end
end)

minetest.register_tool("portability:ender_chest", {
    description = "Portable Ender Chest",
    inventory_image = ender_chest_texture,
    on_place = function(itemstack, player, pointed_thing)
		-- Use pointed node's on_rightclick function first, if present
        if not player:get_player_control().sneak then 
            local new_stack = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
            if new_stack then
                return new_stack
            end
        end
        minetest.sound_play("ender_chest_open", {to_player = player:get_player_name()})
        minetest.show_formspec(player:get_player_name(), "portability:ender_chest_"..player:get_player_name(), formspec_ender_chest)
    end,
    on_secondary_use = function(itemstack, player, pointed_thing)
		-- Use pointed node's on_rightclick function first, if present
        local new_stack = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
		if new_stack then
			return new_stack
		end
        minetest.sound_play("ender_chest_open", {to_player = player:get_player_name()})
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