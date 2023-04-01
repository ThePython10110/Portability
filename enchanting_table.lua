local function show_enchanting(player, enchanting_level)
    local player_meta = player:get_meta()
    player_meta:set_int("mcl_enchanting:num_bookshelves", enchanting_level)
    player_meta:set_string("mcl_enchanting:table_name", "Enchanting Table")
    mcl_enchanting.show_enchanting_formspec(player)
end

for i = 1,15 do
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
    output = "portability:enchanting_table_1",
    recipe = {
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_enchanting:table","mcl_throwing:ender_pearl"},
        {"mcl_throwing:ender_pearl","mcl_throwing:ender_pearl","mcl_throwing:ender_pearl"}
    }
})

for i = 2,15 do
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