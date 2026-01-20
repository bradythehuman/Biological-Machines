local dh = require("__biological-machines-core__.data-helper")

--[[
-splitters use gears, piston, electric engine, nothing
-express prereq electric engine instead of lubricant
-unlock lubricant from tar with alcohol if no lubricant from crude oil
-replace oil processing prereq from loader with alcohol
-remove lubricant prereq from fast loader?
]]


local loader_item = data.raw["item"]["aai-loader"]
loader_item.subgroup = "belt"
loader_item.order = "d[loader]-a[loader]"

local express_item = data.raw["item"]["aai-fast-loader"]
express_item.subgroup = "belt"
express_item.order = "d[loader]-b[fast-loader]"

local express_item = data.raw["item"]["aai-express-loader"]
express_item.subgroup = "belt"
express_item.order = "d[loader]-c[express-loader]"
express_item.weight = 20 * kg

local turbo_item = data.raw["item"]["aai-turbo-loader"]
turbo_item.subgroup = "belt"
turbo_item.order = "d[loader]-d[turbo-loader]"
turbo_item.weight = 40 * kg

data.raw["recipe"]["aai-loader"].ingredients = {
  {type = "item", name = "steel-plate", amount = 5},
  {type = "item", name = "transport-belt", amount = 2},
  {type = "item", name = "iron-gear-wheel", amount = 5},
  {type = "item", name = "electronic-circuit", amount = 5}
}

data.raw["recipe"]["aai-fast-loader"].ingredients = {
  {type = "item", name = "aai-loader", amount = 1},
  {type = "item", name = "bm-piston", amount = 10},
  {type = "item", name = "advanced-circuit", amount = 5}
}

data.raw["recipe"]["aai-express-loader"].ingredients = {
  {type = "item", name = "aai-fast-loader", amount = 1},
  {type = "item", name = "electric-engine-unit", amount = 5},
  {type = "item", name = "processing-unit", amount = 2},
  {type = "fluid", name = "lubricant", amount = 80}
}

data.raw["recipe"]["aai-turbo-loader"].ingredients = {
  {type = "item", name = "aai-express-loader", amount = 1},
  {type = "item", name = "processing-unit", amount = 2},
  {type = "item", name = "tungsten-plate", amount = 15},
  {type = "fluid", name = "lubricant", amount = 80}
}
data.raw["recipe"]["aai-turbo-loader"].category = "metallurgy"

--


if settings.startup["aai-loaders-mode"].value == "lubricated" then
  dh.remove_recipe_unlock("lubricant", "lubricant-from-tar")
  dh.add_recipe_unlock("alcohol", "lubricant-from-tar")

  dh.remove_prereq("aai-loader", "oil-processing")
  dh.add_prereq("aai-loader", "alcohol")

  dh.remove_prereq("aai-fast-loader", "lubricant")
else
  dh.add_prereq("aai-loader", "steel-processing")
end

dh.remove_prereq("aai-fast-loader", "chemical-science-pack")
--dh.add_prereq("aai-fast-loader", "advanced-circuit")
data.raw["technology"]["aai-fast-loader"].unit.ingredients = {
  {"automation-science-pack", 1},
  {"logistic-science-pack", 1},
}
