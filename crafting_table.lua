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