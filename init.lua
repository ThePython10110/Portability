local formspec_escape = minetest.formspec_escape
local show_formspec = minetest.show_formspec
local C = minetest.colorize
local text_color = "#313131"
local itemslot_bg = mcl_formspec.get_itemslot_bg

minetest.register_tool("portability:crafting_table", {
    description = "Portable Crafting Table",
    inventory_image = "portability_crafting_table.png",
    on_place = function(itemstack, player, pointed_thing)
		-- Use pointed node's on_rightclick function first, if present
        if not player:get_player_control().sneak then 
            local new_stack = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
            if new_stack then
                return new_stack
            end
        end
        mcl_crafting_table.show_crafting_form(player)
    end,
    on_secondary_use = function(itemstack, player, pointed_thing)
		-- Use pointed node's on_rightclick function first, if present
        local new_stack = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
		if new_stack then
			return new_stack
		end
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

local ender_chest_texture = "portability_ender_chest.png"
if it_is_christmas then
    ender_chest_texture = "portability_ender_chest_christmas.png"
end

local formspec_ender_chest = "size[9,8.75]"..
	"label[0,0;"..formspec_escape(C("#313131", "Ender Chest")).."]"..
	"list[current_player;enderchest;0,0.5;9,3;]"..
	itemslot_bg(0,0.5,9,3)..
	"label[0,4.0;"..formspec_escape(C("#313131", "Inventory")).."]"..
	"list[current_player;main;0,4.5;9,3;9]"..
	itemslot_bg(0,4.5,9,3)..
	"list[current_player;main;0,7.74;9,1;]"..
	itemslot_bg(0,7.74,9,1)..
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

local function show_enchanting(player, enchanting_level)
    local player_meta = player:get_meta()
    player_meta:set_int("mcl_enchanting:num_bookshelves", enchanting_level)
    player_meta:set_string("mcl_enchanting:table_name", "Enchanting Table")
    mcl_enchanting.show_enchanting_formspec(player)
end

for i = 0,15 do
    minetest.register_tool("portability:enchanting_table_"..i, {
        description = "Portable Enchanting Table (Level "..i..")",
        inventory_image = "portability_enchanting_table.png",
        enchanting_level = i,
        on_place = function(itemstack, player, pointed_thing)
            -- Use pointed node's on_rightclick function first, if present
            if not player:get_player_control().sneak then 
                local new_stack = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
                if new_stack then
                    return new_stack
                end
            end
            show_enchanting(player, i)
        end,
        on_secondary_use = function(itemstack, player, pointed_thing)
            -- Use pointed node's on_rightclick function first, if present
            local new_stack = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
            if new_stack then
                return new_stack
            end
            show_enchanting(player, i)
        end
    })
end

minetest.register_craft({
    output = "portability:enchanting_table_0",
    recipe = {
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_enchanting:table","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"}
    }
})

for i = 1,15 do
    minetest.register_craft({
        output = "portability:enchanting_table_"..i,
        type = "shapeless",
        recipe = {"portability:enchanting_table_"..i-1, "mcl_books:bookshelf"}
    })
    minetest.register_craft({
        output = "mcl_books:bookshelf",
        type = "shapeless",
        recipe = {"portability:enchanting_table_"..i},
        replacements = {{"portability:enchanting_table_"..i, "portability:enchanting_table_"..i-1}}
    })
end