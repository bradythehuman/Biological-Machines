local dh = require("__biological-machines-core__.data-helper")



--RECIPES
local bot_category = data.raw["recipe"]["logistic-robot"].category

local nuc_logistic_recipe = data.raw["recipe"]["logistic-robot-nuclear"]
nuc_logistic_recipe.category = bot_category
nuc_logistic_recipe.ingredients = {
  {type = "item", name = "logistic-robot", amount = 1},
  {type = "item", name = "quantum-processor", amount = 1},
  {type = "item", name = "uranium-fuel-cell", amount = 1},
  {type = "item", name = "bm-radiation-sheilding", amount = 2},
}

local nuc_construction_recipe = data.raw["recipe"]["construction-robot-nuclear"]
nuc_construction_recipe.category = bot_category
nuc_construction_recipe.ingredients = {
  {type = "item", name = "construction-robot", amount = 1},
  {type = "item", name = "quantum-processor", amount = 1},
  {type = "item", name = "uranium-fuel-cell", amount = 1},
  {type = "item", name = "bm-radiation-sheilding", amount = 2},
}



--TECH
dh.add_prereq("nuclear-robots", "bm-planet-discovery-balack")

local nuc_bot_tech = data.raw["technology"]["nuclear-robots"]
nuc_bot_tech.research_trigger = nil
