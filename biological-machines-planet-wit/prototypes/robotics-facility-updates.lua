local dh = require("__biological-machines-core__.data-helper")



--SURFACE
data.raw["item"]["robotics-facility"].default_import_location = "bm-wit"

data.raw["recipe"]["robotics-facility"].surface_conditions = {
  {property = "pressure", min = 50, max = 50}
}

--RECIPE CATEGORIES
data.raw.recipe["engine-unit"].category = "advanced-crafting"
--data.raw.recipe["electric-engine-unit"].category = "crafting-with-fluid"

data.raw.recipe["laser-turret"].category = "bm-advanced-robotics"
data.raw.recipe["personal-laser-defense-equipment"].category = "bm-advanced-robotics"
data.raw.recipe["discharge-defense-equipment"].category = "bm-advanced-robotics"

data.raw.recipe["asteroid-collector"].category = "bm-advanced-robotics"
data.raw.recipe["spidertron"].category = "bm-advanced-robotics"
data.raw.recipe["mech-armor"].category = "bm-advanced-robotics"

table.insert(data.raw["assembling-machine"]["robotics-facility"].crafting_categories, "bm-advanced-robotics")

--RECIPE
data.raw.recipe["robotics-facility"].ingredients = {
  {type = "item", name = "bm-helium-power-cell", amount = 20},
  {type = "item", name = "bulk-inserter", amount = 3},
  {type = "item", name = "steel-plate", amount = 100},
  {type = "item", name = "electric-engine-unit", amount = 10},
  {type = "item", name = "processing-unit", amount = 20}
}

dh.recycle_to_ingredients("robotics-facility")
--[[
data.raw["recipe"]["robotics-facility-recycling"].results = {
  {type = "item", name = "bm-helium-power-cell", amount = 20, probability = 0.25},
  {type = "item", name = "bulk-inserter", amount = 3, probability = 0.25},
  {type = "item", name = "steel-plate", amount = 100, probability = 0.25},
  {type = "item", name = "electric-engine-unit", amount = 10, probability = 0.25},
  {type = "item", name = "processing-unit", amount = 20, probability = 0.25}
}
]]

--TECHNOLOGY
local robo_faci_tech = data.raw["technology"]["robotics-facility"]
robo_faci_tech.prerequisites = {"bm-helium-processing"}
robo_faci_tech.unit = nil
robo_faci_tech.research_trigger = {
  type = "craft-item",
  item = "bm-helium-power-cell",
  count = 20
}

dh.remove_recipe_unlock("space-platform", "asteroid-collector")
dh.add_recipe_unlock("space-platform-thruster", "asteroid-collector")
