local saplings = {
	{"default:sapling", default.grow_new_apple_tree, "soil"},
	{"default:junglesapling", default.grow_new_jungle_tree, "soil"},
	{"default:emergent_jungle_sapling", default.grow_new_emergent_jungle_tree, "soil"},
	{"default:acacia_sapling", default.grow_new_acacia_tree, "soil"},
	{"default:aspen_sapling", default.grow_new_aspen_tree, "soil"},
	{"default:pine_sapling", pine_grow, "soil"},
	{"default:bush_sapling", default.grow_bush, "soil"},
	{"default:acacia_bush_sapling", default.grow_acacia_bush, "soil"},
	{"default:large_cactus_seedling", default.grow_large_cactus, "sand"},
	{"default:blueberry_bush_sapling", default.grow_blueberry_bush, "soil"},
	{"default:pine_bush_sapling", default.grow_pine_bush, "soil"},
}

local function particle_effect(pos)

	minetest.add_particlespawner({
		amount = 4,
		time = 0.15,
		minpos = pos,
		maxpos = pos,
		minvel = {x = -1, y = 2, z = -1},
		maxvel = {x = 1, y = 4, z = 1},
		minacc = {x = -1, y = -1, z = -1},
		maxacc = {x = 1, y = 1, z = 1},
		minexptime = 1,
		maxexptime = 1,
		minsize = 1,
		maxsize = 3,
		texture = "bonemeal_particle.png",
	})
end


-- tree type check
local function grow_tree(pos, object)

	if type(object) == "table" and object.axiom then
		-- grow L-system tree
		minetest.remove_node(pos)
		minetest.spawn_tree(pos, object)

	elseif type(object) == "string" and minetest.registered_nodes[object] then
		-- place node
		minetest.set_node(pos, {name = object})

	elseif type(object) == "function" then
		-- function
		object(pos)
	end
end


-- sapling check
local function check_sapling(pos, nodename)

	-- what is sapling placed on?
	local under =  minetest.get_node({
		x = pos.x,
		y = pos.y - 1,
		z = pos.z
	})

	local can_grow, grow_on

	-- check list for sapling and function
	for n = 1, #saplings do

		if saplings[n][1] == nodename then

			grow_on = saplings[n][3]

			-- sapling grows on top of specific node
			if grow_on
			and grow_on ~= "soil"
			and grow_on ~= "sand"
			and grow_on == under.name then
				can_grow = true
			end

			-- sapling grows on top of soil (default)
			if can_grow == nil
			and (grow_on == nil or grow_on == "soil")
			and minetest.get_item_group(under.name, "soil") > 0 then
				can_grow = true
			end

			-- sapling grows on top of sand
			if can_grow == nil
			and grow_on == "sand"
			and minetest.get_item_group(under.name, "sand") > 0 then
				can_grow = true
			end

			-- check if we can grow sapling
			if can_grow then
				particle_effect(pos)
				grow_tree(pos, saplings[n][2])
				return
			end
		end
	end
end

function growstaff:add_sapling(list)

	for n = 1, #list do
		table.insert(saplings, list[n])
	end
end

function growstaff:on_use(pos, strength, node)

	-- get node pointed at
	local node = node or minetest.get_node(pos)

	-- return if nothing there
	if node.name == "ignore" then
		return
	end

	-- make sure strength is between 1 and 4
	strength = strength or 1
	strength = math.max(strength, 1)
	strength = math.min(strength, 4)

	-- papyrus and cactus
	if node.name == "default:papyrus" then

		default.grow_papyrus(pos, node)
		particle_effect(pos)
		return

	elseif node.name == "default:cactus" then

		default.grow_cactus(pos, node)
		particle_effect(pos)
		return
	end

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

		for _, nouw in ipairs(landscapingstaff.nodes) do
			if node == nouw[1] then
				minetest.swap_node(pos, {name = nouw[2]})

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


if growstaff.nodes then
particle_effect(pos)
				grow_tree(pos, saplings[n][2])
				return
			end

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

		for _, nouw in ipairs(growstaff.nodes) do
			if node == nouw[1] then
				minetest.swap_node(pos, {name = nouw[2]})

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

		for _, nouw in ipairs(humiditystaff.nodes) do
			if node == nouw[1] then
				minetest.swap_node(pos, {name = nouw[2]})

				if not minetest.setting_getbool("creative_mode") then
					itemstack:add_wear(65535 / 29) -- 30 uses
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