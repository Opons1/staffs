landscapingstaff = {}
landscapingstaff.nodes = {
	{"default:dirt", "ethereal:green_moss"},
	{"default:dirt_with_rainforest_litter", "ethereal:jungle_dirt"},
	{"default:dirt_with_grass", "ethereal:green_moss"},
	{"default:dirt_with_dry_grass", "default:dirt"},
	{"default:dirt_with_coniferous_litter", "default:dirt"},
	{"default:dirt_with_snow", "default:cold_dirt"},
	{"default:permafrost", "default:permafrost_with_moss"},
	{"default:permafrost_with_moss", "default:permafrost"},
	{"ethereal:grove_dirt", "ethereal:prairie_dirt"},
	{"ethereal:bamboo_dirt", "ethereal:grove_dirt"},
	{"ethereal:prairie_dirt", "ethereal:cold_dirt"},
	{"ethereal:cold_dirt", "ethereal:bamboo_dirt"},
	{"ethereal:crystal_dirt", "ethereal:crystal_moss"},
	{"ethereal:fiery_dirt", "ethereal:fiery_moss"},
	{"ethereal:gray_dirt", "ethereal:gray_moss"},
	{"ethereal:mushroom_dirt", "ethereal:mushroom_moss"},
    {"ethereal:dry_dirt", "default:dirt_with_grass"},
}

minetest.register_tool("staffs:landscapingstaff", {
	description = "Landscaping Staff",
	inventory_image = "landscaping_staff.png",
	wield_image = "landscaping_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos).name

		for _, now in ipairs(landscapingstaff.nodes) do
			if node == now[1] then
				minetest.swap_node(pos, {name = now[2]})

				if not minetest.setting_getbool("creative_mode") then
					itemstack:add_wear(65535 / 499) -- 500 uses
				end

				return itemstack
			end
		end
	end,
})

minetest.register_craft({
	output = "staffs:landscapingstaff",
	recipe = {
		{"bucket:bucket_lava", "bucket:bucket_river_water", "ethereal:bucket_cactus"},
		{"default:diamondblock", "default:obsidian", "default:diamondblock"},
		{"", "default:obsidian", ""}
	}
})

growstaff = {}
growstaff.nodes = {
	{"moretrees:apple_tree_sapling", "moretrees:apple_tree_sapling_ongen"},
	{"moretrees:beech_sapling", "moretrees:beech_sapling_ongen"},
	{"moretrees:birch_sapling", "moretrees:birch_sapling_ongen"},
	{"moretrees:cedar_sapling", "moretrees:cedar_sapling_ongen"},
	{"moretrees:date_palm_sapling", "moretrees:date_palm_sapling_ongen"},
	{"moretrees:fir_sapling", "moretrees:fir_sapling_ongen"},
	{"moretrees:oak_sapling", "moretrees:oak_sapling_ongen"},
	{"moretrees:palm_sapling", "moretrees:palm_sapling_ongen"},
	{"moretrees:poplar_sapling", "moretrees:poplar_sapling_ongen"},
	{"moretrees:poplar_small_sapling", "moretrees:poplar_small_sapling_ongen"},
	{"moretrees:rubber_tree_sapling", "moretrees:rubber_tree_sapling_ongen"},
	{"moretrees:sequioa_sapling", "moretrees:seqouia_sapling_ongen"},
	{"moretrees:spruce_sapling", "moretrees:spruce_sapling_ongen"},
	{"moretrees:willow_sapling", "moretrees:willow_sapling_ongen"},
}    

minetest.register_tool("staffs:growstaff", {
	description = "Super-Grow Staff",
	inventory_image = "grow_staff.png",
	wield_image = "grow_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos).name

		for _, now in ipairs(growstaff.nodes) do
			if node == now[1] then
				minetest.swap_node(pos, {name = now[2]})

				if not minetest.setting_getbool("creative_mode") then
					itemstack:add_wear(65535 / 29) -- 30 uses
				end

				return itemstack
			end
		end
	end,
})

minetest.register_craft({
	output = "staffs:growstaff",
	recipe = {
		{"bonemeal:fertilizer", "bonemeal:fertilizer", "bonemeal:fertilizer"},
		{"ethereal:crystal_block", "default:obsidian", "ethereal:crystal_block"},
		{"", "default:obsidian", ""}
	}
})

humiditystaff = {}
humiditystaff.nodes = {
	{"default:snow", "default:river_water_source"},
	{"default:ice", "default:river_water_source"},
	{"farming:straw", "cottages:hay"},
	{"default:coral_skeleton", "default:coral_brown"},
	{"default:coral_brown", "default:coral_orange"},
	{"default:dirt", "ethereal:crystal_dirt"},
	{"default:permafrost", "default:permafrost_with_moss"},
	{"default:permafrost_with_moss", "default:permafrost"},
	{"ethereal:sakura_leaves", "ethereal:sakura_leaves2"},
	{"morebricks:copper", "morebricks:copperaged"},
    {"morebricks:cyan", "morebricks:cyanaged"},
    {"morebricks:green", "morebricks:greenaged"},
    {"morebricks:grey", "morebricks:greyaged"},
    {"morebricks:magenta", "morebricks:magentaaged"},
    {"morebricks:orange", "morebricks:orangeaged"},
    {"morebricks:pink", "morebricks:pinkaged"},
    {"morebricks:steel", "morebricks:steelaged"},
    {"morebricks:yellow", "morebricks:yellowaged"},
    {"underch:amphibolite_cobble", "underch:amphibolite_mossy_cobble"},
    {"underch:andesite_cobble", "underch:andesite_mossy_cobble"},
    {"underch:aplite_cobble", "underch:aplite_mossy_cobble"},
    {"underch:basalt_cobble", "underch:basalt_mossy_cobble"},
    {"underch:dark_vindesite_cobble", "underch:dark_vindesite_mossy_cobble"},
    {"underch:diorite_cobble", "underch:diorite_mossy_cobble"},
    {"underch:dolomite_cobble", "underch:dolomite_mossy_cobble"},
    {"underch:marble_cobble", "underch:marble_mossy_cobble"},
    {"default:dirt", "underch:mossy_dirt"},
    {"default:gravel", "underch:mossy_gravel"},
    {"underch:pegmatite_cobble", "underch:pegmatite_mossy_cobble"},
    {"underch:phonolite_cobble", "underch:phonolite_mossy_cobble"},
    {"underch:phylite_cobble", "underch:phylite_mossy_cobble"},
    {"underch:quartzite_cobble", "underch:amphibolite_mossy_cobble"},
    {"underch:schist_cobble", "underch:schist_mossy_cobble"},
    {"default:cobble", "default:mossycobble"},
    {"underch:slate_cobble", "underch:slate_mossy_cobble"},
    {"underch:vindesite_cobble", "underch:vindesite_mossy_cobble"},
}

minetest.register_tool("staffs:humiditystaff", {
	description = "Staff of Humidity",
	inventory_image = "humidity_staff.png",
	wield_image = "humidity_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos).name

		for _, now in ipairs(humiditystaff.nodes) do
			if node == now[1] then
				minetest.swap_node(pos, {name = now[2]})

				if not minetest.setting_getbool("creative_mode") then
					itemstack:add_wear(65535 / 499) -- 500 uses
				end

				return itemstack
			end
		end
	end,
})

minetest.register_craft({
	output = "staffs:humiditystaff",
	recipe = {
		{"bucket:bucket_river_water", "bucket:bucket_river_water", "bucket:bucket_river_water"},
		{"octu:block", "default:obsidian", "octu:block"},
		{"", "default:obsidian", ""}
	}
})

colorstaff = {}
colorstaff.nodes = {
    {"wool:black", "wool:blue"},
    {"wool:blue", "wool:brown"},
    {"wool:brown", "wool:cyan"},
    {"wool:cyan", "wool:dark_green"},
    {"wool:dark_green", "wool:dark_grey"},
    {"wool:dark_grey", "wool:green"},
    {"wool:green", "wool:grey"},
    {"wool:grey", "wool:magenta"},
    {"wool:magenta", "wool:orange"},
    {"wool:orange", "wool:pink"},
    {"wool:pink", "wool:red"},
    {"wool:red", "wool:violet"},
    {"wool:violet", "wool:white"},
    {"wool:white", "wool:yellow"},
    {"wool:yellow", "wool:black"},
    {"bakedclay:black", "bakedclay:blue"},
    {"bakedclay:blue", "bakedclay:brown"},
    {"bakedclay:brown", "bakedclay:cyan"},
    {"bakedclay:cyan", "bakedclay:dark_green"},
    {"bakedclay:dark_green", "bakedclay:dark_grey"},
    {"bakedclay:dark_grey", "bakedclay:green"},
    {"bakedclay:green", "bakedclay:grey"},
    {"bakedclay:grey", "bakedclay:magenta"},
    {"bakedclay:magenta", "bakedclay:orange"},
    {"bakedclay:orange", "bakedclay:pink"},
    {"bakedclay:pink", "bakedclay:red"},
    {"bakedclay:red", "bakedclay:violet"},
    {"bakedclay:violet", "bakedclay:white"},
    {"bakedclay:white", "bakedclay:yellow"},
    {"bakedclay:yellow", "bakedclay:black"},
    {"default:glass", "xtraores_rainbow:glass"},
    {"default:wood", "xtraores_rainbow:wood"},
    {"ethereal:illumishroom", "ethereal:illumishroom2"},
    {"ethereal:illumishroom2", "ethereal:illumishroom3"},
    {"ethereal:illumishroom3", "ethereal:illumishroom"},
}
    
minetest.register_tool("staffs:colorstaff", {
	description = "Staff of Color",
	inventory_image = "color_staff.png",
	wield_image = "color_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos).name

		for _, now in ipairs(colorstaff.nodes) do
			if node == now[1] then
				minetest.swap_node(pos, {name = now[2]})

				if not minetest.setting_getbool("creative_mode") then
					itemstack:add_wear(65535 / 499) -- 500 uses
				end

				return itemstack
			end
		end
	end,
})

minetest.register_craft({
	output = "staffs:colorstaff",
	recipe = {
		{"xtraores_rainbow:rainbow", "xtraores_rainbow:rainbow", "xtraores_rainbow:rainbow"},
		{"xtraores_rainbow:rainbow", "xtraores:geminititum_block", "xtraores_rainbow:rainbow"},
		{"", "xtraores_rainbow:wood", ""}
	}
})

mysterystaff = {}
mysterystaff.nodes = {
    {"technic:lead_block", "underch:gold_dense_ore"},
    {"ethereal:bamboo", "ethereal:bamboo_block"},
    {"moretrees:rubber_tree_trunk_empty", "moretrees:rubber_tree_trunk"},
    {"technic:corium_source", "staffs:strange_dust"},
    {"technic:nuclear_reactor_core_active", "staffs:strange_gravel"},
    {"technic:uranium35block", "staffs:strange_dust"},
    {"default:lava_source", "underch:lava_crack"},
    {"technic:concrete", "technic:blast_resistant_concrete"},
}
    
minetest.register_tool("staffs:mysterystaff", {
	description = "Staff of Mystery",
	inventory_image = "mystery_staff.png",
	wield_image = "mystery_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos).name

		for _, now in ipairs(mysterystaff.nodes) do
			if node == now[1] then
				minetest.swap_node(pos, {name = now[2]})

				if not minetest.setting_getbool("creative_mode") then
					itemstack:add_wear(65535 / 29) -- 30 uses
				end

				return itemstack
			end
		end
	end,
})

minetest.register_craft({
	output = "staffs:mysterystaff",
	recipe = {
		{"rhotator:cube", "rhotator:cube", "rhotator:cube"},
		{"default:pick_diamond", "default:shovel_diamond", "default:axe_diamond"},
		{"", "xtraores:unobtanium_block", ""}
	}
})

minetest.register_node ("staffs:strange_dust", {
    description = "Strange Dust",
    tiles = {"strange_dust.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 4,
})

minetest.register_node ("staffs:strange_gravel", {
    description = "Strange Gravel",
    tiles = {"strange_gravel.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 4,
})

technic.register_separating_recipe({ input = {"staffs:strange_gravel"}, output = {"default:gravel", "staffs:plutonium_lump"}, time = 80 })
technic.register_separating_recipe({ input = {"staffs:strange_dust"}, output = {"underch:dust", "staffs:californium252_dust"}, time = 120 })

minetest.register_ore ("staffs:plutonium_lump", {
    description = "Plutonium Lump",
    inventory_image = "plutonium_lump.png",
})

minetest.register_ore ("staffs:californium252_dust", {
    description = "Californium 252 Dust",
    inventory_image = "californium252_dust.png",
})