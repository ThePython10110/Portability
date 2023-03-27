local formspec_escape = minetest.formspec_escape
local show_formspec = minetest.show_formspec
local C = minetest.colorize
local text_color = "#313131"
local itemslot_bg = mcl_formspec.get_itemslot_bg

minetest.register_tool("portable_crafting_table:portable_crafting_table", {
    description = "Portable Crafting Table",
    inventory_image = "crafting_workbench_top.png",
    on_place = function(itemstack, player, pointed_thing)
        mcl_crafting_table.show_crafting_form(player)
    end,
    on_secondary_use = function(itemstack, player, pointed_thing)
        mcl_crafting_table.show_crafting_form(player)
    end
})