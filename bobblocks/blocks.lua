-- BobBlocks mod by RabbiBob
-- State Changes

bobblocks = {}
bobblocks.old_static_nodes = {}

bobblocks.colorlist = {
	"red",
	"orange",
	"yellow",
	"green",
	"blue",
	"indigo",
	"violet",
	"white",
	"grey"
}

bobblocks.update_bobblock = function (pos, node)
	local newnode = node
	if string.find(newnode.name, "_off") then
		newnode.name = string.sub(newnode.name, 1, -5)
	else
		newnode.name = newnode.name.."_off"
	end

    minetest.swap_node(pos, newnode)
    minetest.sound_play("bobblocks_glassblock",
	{pos = pos, gain = 1.0, max_hear_distance = 32,})
end

-- Nodes

minetest.register_node("bobblocks:block", {
	description = "Bobblocks Plain Block",
	drawtype = "glasslike",
	tiles = {"bobblocks_block.png"},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = LIGHT_MAX-0,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, ud_param2_colorable = 1},
	foo = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:block_off"
		}
	},
	on_punch = bobblocks.update_bobblock,
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("bobblocks:block_off", {
	description = "Bobblocks Plain Block (off)",
    tiles = {"bobblocks_block.png"},
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	is_ground_content = true,
	alpha = WATER_ALPHA,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1, ud_param2_colorable = 1},
	drop = 'bobblocks:redblock',
	foo = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:block"
		}
	},
	on_rightclick = bobblocks.update_bobblock,
	after_dig_node = unifieddyes.after_dig_node
})

-- Block Poles
minetest.register_node("bobblocks:pole", {
	description = "Bobblocks Pole",
	drawtype = "fencelike",
	tiles = {"bobblocks_block.png"},
	inventory_image = ("bobblocks_pole_inv.png"),
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = LIGHT_MAX-0,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, ud_param2_colorable = 1},
	foo = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:pole_off"
		}
	},
	on_rightclick = bobblocks.update_bobblock,
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("bobblocks:pole_off", {
	description = "Bobblocks Pole (off)",
	drawtype = "fencelike",
	tiles = {"bobblocks_block.png"},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = LIGHT_MAX-10,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1, ud_param2_colorable = 1},
	drop = 'bobblocks:redpole',
	foo = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:pole"
		}
	},
	on_rightclick = bobblocks.update_bobblock,
	after_dig_node = unifieddyes.after_dig_node
})

-- old static nodes grandfathered-in because they have a different texture or usage than the colored ones.

minetest.register_node("bobblocks:btm", {
	description = "Bobs TransMorgifier v5",
	tiles = {"bobblocks_btm_sides.png", "bobblocks_btm_sides.png", "bobblocks_btm_sides.png",
		"bobblocks_btm_sides.png", "bobblocks_btm_sides.png", "bobblocks_btm.png"},
	inventory_image = "bobblocks_btm.png",
	paramtype2 = "facedir",
	material = minetest.digprop_dirtlike(1.0),
	legacy_facedir_simple = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1}, 
})

minetest.register_node("bobblocks:wavyblock", {
	description = "Bobblocks Wavy-textured Block",
	drawtype = "glasslike",
	tiles = {"bobblocks_wavyblock.png"},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = LIGHT_MAX-0,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, ud_param2_colorable = 1},
	foo = {conductor=
		{
			state = mesecon.state.on,
			offstate = "bobblocks:wavyblock_off"
		}
	},
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("bobblocks:wavyblock_off", {
	description = "Bobblocks Wavy-textured Block (off)",
	tiles = {"bobblocks_wavyblock.png"},
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	is_ground_content = true,
	alpha = WATER_ALPHA,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1, ud_param2_colorable = 1},
	drop = 'bobblocks:wavyblock',
	foo = {conductor=
		{
			state = mesecon.state.off,
			onstate = "bobblocks:wavyblock"
		}
	},
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("bobblocks:wavypole", {
	description = "Wavy-textured Pole",
	drawtype = "fencelike",
	tiles = {"bobblocks_wavyblock.png"},
	inventory_image = ("bobblocks_wavypole_inv.png"),
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, ud_param2_colorable = 1},
	after_dig_node = unifieddyes.after_dig_node,
	--light_source = LIGHT_MAX-0,
})

-- Crafts

minetest.register_craft({
	output = "bobblocks:btm",
	type = "shapeless",
	recipe = {
		"default:glass",
		"default:torch",
		"group:leaves",
		"default:mese_crystal",
		"default:diamond"
	},
})

minetest.register_craft({
	output = "bobblocks:block 2", 
	recipe = {
		{ "default:glass", "default:torch", "default:cobble" },
	},
})

minetest.register_craft({
	output = "bobblocks:pole",
	recipe = {
		{ "bobblocks:block", "group:stick" },
	}
})

minetest.register_craft({
	output = "bobblocks:wavyblock 2",
	type = "shapeless",
	recipe = {
		"bobblocks:block",
		"bobblocks:block"
	},
})

minetest.register_craft({
	output = "bobblocks:wavypole",
	recipe = {
		{ "bobblocks:wavyblock", "group:stick" },
	}
})

-- Convert old static nodes to the param2 scheme

for _, i in ipairs(bobblocks.colorlist) do
	table.insert(bobblocks.old_static_nodes, "bobblocks:"..i.."block")
	table.insert(bobblocks.old_static_nodes, "bobblocks:"..i.."block_off")
	table.insert(bobblocks.old_static_nodes, "bobblocks:"..i.."pole")
	table.insert(bobblocks.old_static_nodes, "bobblocks:"..i.."pole_off")
end

minetest.register_lbm({
	name = "bobblocks:convert",
	label = "Convert bobblocks nodes to use param2 color",
	run_at_every_load = true,
	nodenames = bobblocks.old_static_nodes,
	action = function(pos, node)
		local basename = node.name
		local color = string.sub(node.name, 11) -- delete the mod name

		if string.find(color, "_off") then  -- delete "_off" if it exists
			color = string.sub(color, 1, -5)
		end
		if string.find(color, "pole") then
			color = string.sub(color, 1, -5) -- delete "pole"...
		else
			color = string.sub(color, 1, -6) -- or delete "block"
		end

		local newcolor = "medium_"..color  -- the result of the above should be just the hue

		-- custom re-mappings to use unified dyes' colors that are most similar to the originals
		if color == "blue" then
			newcolor = "medium_skyblue"
		end
		if color == "indigo" then
			newcolor = "light_violet"
		end
		if color == "violet" then
			newcolor = "violet_s50"
		end
		if color == "white" then
			newcolor = "light_grey"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..newcolor, false)
		local newnode = "bobblocks:block"

		if string.find(basename, "grey") then
			paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:grey", false)
			if string.find(basename, "pole") then
				newnode = "bobblocks:wavypole"
			else
				newnode = "bobblocks:wavyblock"
			end
		else
			if string.find(basename, "pole") then
				newnode = "bobblocks:pole"
			end
		end

		local meta = minetest.get_meta(pos)
		minetest.set_node(pos, { name = newnode, param2 = paletteidx })
		meta:set_string("dye", "unifieddyes:"..newcolor)
	end
})
