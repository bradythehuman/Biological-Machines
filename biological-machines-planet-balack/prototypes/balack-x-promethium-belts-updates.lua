local recycling = require("__recycler__.recycling")

local dh = require("__biological-machines-core__.data-helper")



--RECIPES
local remove_promethium = {
  "promethium-transport-belt", "promethium-underground-belt",
  "promethium-splitter",
}
dh.remove_ingredient(remove_promethium, "promethium-asteroid-chunk")

local add_sheilding = {
  ["promethium-transport-belt"] = 1,
  ["promethium-underground-belt"] = 10,
  ["promethium-splitter"] = 5,
}
dh.add_ingredient_table(add_sheilding, "item", "bm-radiation-sheilding")



--TECH
dh.remove_prereq("promethium-transport-belt", "promethium-science-pack")

dh.add_prereq("promethium-transport-belt", "bm-planet-discovery-balack")

data.raw["technology"]["promethium-transport-belt"].unit.ingredients = util.table.deepcopy(data.raw.technology["bm-tank-mk2"].unit.ingredients)

data.raw["technology"]["promethium-transport-belt"].unit.time = 120



--LOADER
if mods["aai-loaders"] and settings.startup["aai-loaders-mode"].value ~= "graphics-only" then
  dh.remove_ingredient("aai-promethium-loader", "promethium-asteroid-chunk")
  dh.add_ingredient("aai-promethium-loader", "item", "bm-radiation-sheilding", 5)

  dh.remove_ingredient("aai-promethium-loader", "quantum-processor")
  dh.add_ingredient("aai-promethium-loader", "item", "quantum-processor", 5)

  dh.remove_ingredient("aai-promethium-loader", "lubricant")
  dh.add_ingredient("aai-promethium-loader", "fluid", "lubricant", 50)
end
--[[
if mods["aai-loaders"] and settings.startup["aai-loaders-mode"].value ~= "graphics-only" then
  AAILoaders.make_tier{
		name = "promethium",
		transport_belt = "promethium-transport-belt",
		color = {r = 199, g = 19, b = 215, a = 231},
		fluid = "lubricant",
		fluid_per_minute = "0.3",
		technology = {
			--name = "promethium-transport-belt",
      prerequisites = {"promethium-transport-belt", "aai-turbo-loader"},
      unit = util.table.deepcopy(data.raw.technology["bm-tank-mk2"].unit),
		},
		recipe = {
			crafting_categories = {"metallurgy"},
			ingredients = {
			  {type = "item", name = "aai-turbo-loader", amount = 1},
			  {type = "item", name = "bm-radiation-sheilding", amount = 5},
			  {type = "item", name = "quantum-processor", amount = 2},
			  {type = "fluid", name = "lubricant", amount = 80},
			},
			energy_required = 4
		},
		unlubricated_recipe = {
			crafting_categories = {"metallurgy"},
			ingredients = {
        {type = "item", name = "aai-turbo-loader", amount = 1},
			  {type = "item", name = "bm-radiation-sheilding", amount = 5},
			  {type = "item", name = "quantum-processor", amount = 2},
			  {type = "fluid", name = "lubricant", amount = 80},
			},
			energy_required = 20
		},
		--next_upgrade = "aai-ultimate-loader"
	}

  local loader_item = data.raw["item"]["aai-promethium-loader"]
  loader_item.subgroup = "belt"
  loader_item.order = "d[loader]-e[promethium-loader]"
  loader_item.weight = 40 * kg

  data.raw["loader-1x1"]["aai-turbo-loader"].next_upgrade = "aai-promethium-loader"

  data.raw["recipe"]["aai-promethium-loader"].surface_conditions = data.raw["recipe"]["promethium-transport-belt"].surface_conditions

  table.insert(remove_promethium, "aai-promethium-loader")
end
]]



--RECYCLING
for _, recipe_name in pairs(remove_promethium) do
  recycling.generate_recycling_recipe(data.raw.recipe[recipe_name], function(_) return true end)
end
