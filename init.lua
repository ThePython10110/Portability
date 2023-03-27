minetest.register_tool("portable_crafting_table:portable_crafting_table", {
    description = "Portable Crafting Table",
    inventory_image = "crafting_workbench_top.png",
    on_place = mcl_crafting_table.show_crafting_form(player)
})