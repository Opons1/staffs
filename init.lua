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