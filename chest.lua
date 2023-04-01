local function show_chest(itemstack, player, pointed_thing)
    if not player:get_player_control().sneak then 
        local new_stack = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
        if new_stack then
            return new_stack
        end
    end

	local meta = itemstack:get_meta()
    local inv_id = "portability:chest_"..minetest.sha1(minetest.get_us_time())..tostring(math.random())
    local portable_inventory = minetest.deserialize(meta:get_string("portable_inventory"))
    minetest.log(minetest.serialize(portable_inventory))
    local inv = minetest.create_detached_inventory(inv_id)
    inv.set_size(27)
    local chest_formspec = "size[9,8.75]"..
        "label[0,0;"..formspec_escape(C("#313131", "Portable Chest")).."]"..
        "list[detached:"..inv_id..";main;0,0.5;9,3;]"..
        itemslot_bg(0,0.5,9,3)..
        "label[0,4.0;"..formspec_escape(C("#313131", "Inventory")).."]"..
        "list[current_player;main;0,4.5;9,3;9]"..
        itemslot_bg(0,4.5,9,3)..
        "list[current_player;main;0,7.74;9,1;]"..
        itemslot_bg(0,7.74,9,1)..
        "listring[detached:"..inv_id..";main]"..
        "listring[current_player;main]"
    minetest.show_formspec(player:get_player_name(), "portability:chest", chest_formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname:find("portability:chest") == 1 then
        if fields.quit then
            local itemstack = player:get_wielded_item()
            if itemstack:get_name() ~= "portability:chest" then
                minetest.log("ERROR", itemstack:get_name())
                crash_the_server_at_least_for_now____idk_what_else_to_do()
            end
            local meta = itemstack:get_meta()
            local inv_id = meta:get_string("inv_id")
            local inv = minetest.get_inventory(inv_id)
            meta:set_string("portable_inv", minetest.serialize(inv))
        end
    end
end)

minetest.register_tool("portability:chest", {
    description = "Portable Chest",
    on_secondary_use = show_chest,
    on_place = show_chest,
    groups = {shulker_box = 1, container = 2},
    portable_inventory = {}
})