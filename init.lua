staffs = {}

local function convert(itemstack, user, pos, nodelist, uses)
	local pname = user:get_player_name();
	if core.is_protected(pos, pname) then
		core.record_protection_violation(pos, pname)
		return
	end

	local prenode = core.get_node(pos).name
	local nodename = nodelist[prenode]

	if nodename then
		core.swap_node(pos, {name = nodename})
		itemstack:add_wear(65535 / uses)
		return itemstack
	end
end

function staffs.convert(itemstack, user, pointed_thing, nodelist, uses)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under

	return convert(itemstack, user, pos, nodelist, uses) or itemstack
end
--same thing, but a 3x3x3 area

function staffs.convert3(itemstack, user, pointed_thing, nodelist, uses)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = table.copy(pointed_thing.under)

	pos.x = pos.x - 1
	pos.y = pos.y - 1
	pos.z = pos.z - 1
	for x = 1, 3 do
		for y = 1, 3 do
			for z = 1, 3 do
				itemstack = convert(itemstack, user, pos, nodelist, uses) or itemstack
				pos.z = pos.z + 1
			end
			pos.y = pos.y + 1
			pos.z = pos.z - 3
		end
		pos.y = pos.y - 3
		pos.x = pos.x + 1
	end
	return itemstack
end

staffs.landscapingstaff = {}

staffs.landscapingstaff.nodes = {
	["default:dirt"] = "ethereal:green_moss",
	["default:dirt_with_rainforest_litter"] = "ethereal:jungle_dirt",
	["default:dirt_with_grass"] = "ethereal:green_moss",
	["default:dirt_with_dry_grass"] = "default:dirt",
	["default:dirt_with_coniferous_litter"] = "default:dirt",
	["default:dirt_with_snow"] = "ethereal:cold_dirt",
	["default:permafrost"] = "default:permafrost_with_moss",
	["default:permafrost_with_moss"] = "default:permafrost",
	["ethereal:grove_dirt"] = "ethereal:prairie_dirt",
	["ethereal:bamboo_dirt"] = "ethereal:grove_dirt",
	["ethereal:prairie_dirt"] = "ethereal:cold_dirt",
	["ethereal:cold_dirt"] = "ethereal:bamboo_dirt",
	["ethereal:crystal_dirt"] = "ethereal:crystal_moss",
	["ethereal:fiery_dirt"] = "ethereal:fiery_moss",
	["ethereal:gray_dirt"] = "ethereal:gray_moss",
	["ethereal:mushroom_dirt"] = "ethereal:mushroom_moss",
	["ethereal:dry_dirt"] = "default:dirt_with_grass",

}

core.register_tool("staffs:landscapingstaff", {
	description = "Landscaping Staff",
	inventory_image = "landscaping_staff.png",
	wield_image = "landscaping_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return staffs.convert(itemstack, user, pointed_thing, staffs.landscapingstaff.nodes, 500)
	end,
})

core.register_tool("staffs:landscapingstaff2", {
	description = "Greater Landscaping Staff",
	inventory_image = "landscaping_staff.png",
	wield_image = "landscaping_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return staffs.convert3(itemstack, user, pointed_thing, staffs.landscapingstaff.nodes, 5000)
	end,
})

core.register_craft({
	output = "staffs:landscapingstaff",
	recipe = {
		{"bucket:bucket_lava", "bucket:bucket_river_water", "ethereal:bucket_cactus"},
		{"default:diamondblock", "default:obsidian", "default:diamondblock"},
		{"", "default:obsidian", ""}
	}
})

core.register_craft({
	output = "staffs:landscapingstaff2",
	recipe = {
		{"gemeric:aoe_rune", "birthstones:peridot", "gemeric:aoe_rune"},
		{"birthstones:peridot", "staffs:landscapingstaff", "birthstones:peridot"},
		{"gemeric:aoe_rune", "birthstones:peridot", "gemeric:aoe_rune"},
	}
})

local growstaff_uses = 100

core.register_tool("staffs:growstaff", {
	description = "Super-Grow Staff",
	inventory_image = "grow_staff.png",
	wield_image = "grow_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		if type(user) == "userdata" then
			if pointed_thing.type ~= "node" then
				return
			end

			local pos = pointed_thing.under
			local pname = user:get_player_name()
			
			if core.is_protected(pos, pname) then
				core.record_protection_violation(pos, pname)
				return
			end
			
			if bonemeal:on_use(pos, 1) then
				itemstack:add_wear(65535 / growstaff_uses) 
			end
			return itemstack
		end
	end,
})

core.register_tool("staffs:growstaff2", {
	description = "Ultra-Grow Staff",
	inventory_image = "grow_staff.png",
	wield_image = "grow_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		if type(user) == "userdata" then
			if pointed_thing.type ~= "node" then
				return
			end

			local pos = pointed_thing.under
			local pname = user:get_player_name()
			
			if core.is_protected(pos, pname) then
				core.record_protection_violation(pos, pname)
				return
			end
			
			if bonemeal:on_use(pos, 4) then
				itemstack:add_wear(65535 / growstaff_uses) 
			end
			return itemstack
		end
	end,
})

core.register_craft({
	output = "staffs:growstaff",
	recipe = {
		{"bonemeal:fertiliser", "bonemeal:fertiliser", "bonemeal:fertiliser"},
		{"ethereal:crystal_block", "default:obsidian", "ethereal:crystal_block"},
		{"", "default:obsidian", ""}
	}
})

core.register_craft({
	output = "staffs:growstaff2",
	recipe = {
		{"gemeric:aoe_rune", "birthstones:alexandrite", "gemeric:aoe_rune"},
		{"birthstones:alexandrite", "staffs:growstaff", "birthstones:alexandrite"},
		{"gemeric:aoe_rune", "birthstones:alexandrite", "gemeric:aoe_rune"}
	}
})


staffs.humiditystaff = {}
staffs.humiditystaff.nodes = {
	["default:snow"] = "default:river_water_source",
	["default:ice"] = "default:river_water_source",
	["farming:straw"] = "cottages:hay",
	["default:coral_skeleton"] = "default:coral_brown",
	["default:coral_brown"] = "default:coral_orange",
	["default:permafrost"] = "default:permafrost_with_moss",
	["default:permafrost_with_moss"] = "default:permafrost",
	["ethereal:sakura_leaves"] = "ethereal:sakura_leaves2",
	["morebricks:copper"] = "morebricks:copperaged",
	["morebricks:cyan"] = "morebricks:cyanaged",
	["morebricks:green"] = "morebricks:greenaged",
	["morebricks:grey"] = "morebricks:greyaged",
	["morebricks:magenta"] = "morebricks:magentaaged",
	["morebricks:orange"] = "morebricks:orangeaged",
	["morebricks:pink"] = "morebricks:pinkaged",
	["morebricks:steel"] = "morebricks:steelaged",
	["morebricks:yellow"] = "morebricks:yellowaged",
	["underch:amphibolite_cobble"] = "underch:amphibolite_mossy_cobble",
	["underch:andesite_cobble"] = "underch:andesite_mossy_cobble",
	["underch:aplite_cobble"] = "underch:aplite_mossy_cobble",
	["underch:basalt_cobble"] = "underch:basalt_mossy_cobble",
	["underch:dark_vindesite_cobble"] = "underch:dark_vindesite_mossy_cobble",
	["underch:diorite_cobble"] = "underch:diorite_mossy_cobble",
	["underch:dolomite_cobble"] = "underch:dolomite_mossy_cobble",
	["underch:gabbro_cobble"] = "underch:gabbro_mossy_cobble",
	["underch:gneiss_cobble"] = "underch:gneiss_mossy_cobble",
	["underch:granite_cobble"] = "underch:granite_mossy_cobble",
	["underch:limestone_cobble"] = "underch:limestone_mossy_cobble",
	["underch:marble_cobble"] = "underch:marble_mossy_cobble",
	["default:gravel"] = "underch:mossy_gravel",
	["underch:pegmatite_cobble"] = "underch:pegmatite_mossy_cobble",
	["underch:peridotite_cobble"] = "underch:peridotite_mossy_cobble",
	["underch:phonolite_cobble"] = "underch:phonolite_mossy_cobble",
	["underch:phylite_cobble"] = "underch:phylite_mossy_cobble",
	["underch:quartzite_cobble"] = "underch:quartzite_mossy_cobble",
	["underch:schist_cobble"] = "underch:schist_mossy_cobble",
	["underch:sichamine_cobble"] = "underch:sichamine_mossy_cobble",
	["default:cobble"] = "default:mossycobble",
	["underch:slate_cobble"] = "underch:slate_mossy_cobble",
	["underch:vindesite_cobble"] = "underch:vindesite_mossy_cobble",
}

core.register_tool("staffs:humiditystaff", {
	description = "Staff of Humidity",
	inventory_image = "humidity_staff.png",
	wield_image = "humidity_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return staffs.convert(itemstack, user, pointed_thing, staffs.humiditystaff.nodes, 500)
	end,
})
core.register_tool("staffs:humiditystaff2", {
	description = "Greater Staff of Humidity",
	inventory_image = "humidity_staff.png",
	wield_image = "humidity_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return staffs.convert3(itemstack, user, pointed_thing, staffs.humiditystaff.nodes, 5000)
	end,
})

core.register_craft({
	output = "staffs:humiditystaff",
	recipe = {
		{"bucket:bucket_river_water", "bucket:bucket_river_water", "bucket:bucket_river_water"},
		{"octu:block", "default:obsidian", "octu:block"},
		{"", "default:obsidian", ""}
	}
})

core.register_craft({
	output = "staffs:humiditystaff2",
	recipe = {
		{"gemeric:aoe_rune", "birthstones:sapphire", "gemeric:aoe_rune"},
		{"birthstones:sapphire", "staffs:humiditystaff", "birthstones:sapphire"},
		{"gemeric:aoe_rune", "birthstones:sapphire", "gemeric:aoe_rune"},
	}
})

staffs.colorstaff = {}
staffs.colorstaff.nodes = {
	["wool:black"] = "wool:blue",
	["wool:blue"] = "wool:brown",
	["wool:brown"] = "wool:cyan",
	["wool:cyan"] = "wool:dark_green",
	["wool:dark_green"] = "wool:dark_grey",
	["wool:dark_grey"] = "wool:green",
	["wool:green"] = "wool:grey",
	["wool:grey"] = "wool:magenta",
	["wool:magenta"] = "wool:orange",
	["wool:orange"] = "wool:pink",
	["wool:pink"] = "wool:red",
	["wool:red"] = "wool:violet",
	["wool:violet"] = "wool:white",
	["wool:white"] = "wool:yellow",
	["wool:yellow"] = "wool:black",
	["bakedclay:black"] = "bakedclay:blue",
	["bakedclay:blue"] = "bakedclay:brown",
	["bakedclay:brown"] = "bakedclay:cyan",
	["bakedclay:cyan"] = "bakedclay:dark_green",
	["bakedclay:dark_green"] = "bakedclay:dark_grey",
	["bakedclay:dark_grey"] = "bakedclay:green",
	["bakedclay:green"] = "bakedclay:grey",
	["bakedclay:grey"] = "bakedclay:magenta",
	["bakedclay:magenta"] = "bakedclay:orange",
	["bakedclay:orange"] = "bakedclay:pink",
	["bakedclay:pink"] = "bakedclay:red",
	["bakedclay:red"] = "bakedclay:violet",
	["bakedclay:violet"] = "bakedclay:white",
	["bakedclay:white"] = "bakedclay:yellow",
	["bakedclay:yellow"] = "bakedclay:black",
	["default:glass"] = "xtraores_rainbow:glass",
	["default:wood"] = "xtraores_rainbow:wood",
	["ethereal:illumishroom"] = "ethereal:illumishroom2",
	["ethereal:illumishroom2"] = "ethereal:illumishroom3",
	["ethereal:illumishroom3"] = "ethereal:illumishroom",
}
    
core.register_tool("staffs:colorstaff", {
	description = "Staff of Color",
	inventory_image = "color_staff.png",
	wield_image = "color_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return staffs.convert(itemstack, user, pointed_thing, staffs.colorstaff.nodes, 500)
	end,
})

core.register_tool("staffs:colorstaff2", {
	description = "Greater Staff of Color",
	inventory_image = "color_staff.png",
	wield_image = "color_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return staffs.convert3(itemstack, user, pointed_thing, staffs.colorstaff.nodes, 5000)
	end,
})

core.register_craft({
	output = "staffs:colorstaff2",
	recipe = {
		{"gemeric:aoe_rune", "too_many_stones:fire_opal", "gemeric:aoe_rune"},
		{"too_many_stones:fire_opal", "staffs:colorstaff", "too_many_stones:fire_opal"},
		{"gemeric:aoe_rune", "too_many_stones:fire_opal", "gemeric:aoe_rune"},
	}
})

core.register_craft({
	output = "staffs:colorstaff",
	recipe = {
		{"nyancat:nyancat_rainbow", "too_many_stones:fire_opal", "nyancat:nyancat_rainbow"},
		{"nyancat:nyancat_rainbow", "basic_materials:steel_bar", "nyancat:nyancat_rainbow"},
		{"", "basic_materials:steel_bar", ""}
	}
})
