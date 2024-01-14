if minetest.get_game_info().id == "mineclone2" then
    mcl_item_id.set_mod_namespace("portability")
end

local modpath = minetest.get_modpath("portability")
dofile(modpath.."/crafting_table.lua")
dofile(modpath.."/ender_chest.lua")
dofile(modpath.."/enchanting_table.lua")