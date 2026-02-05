local smelting_recipes = {
  {name = "iron-plate", prob = 0.01},
  {name = "copper-plate", prob = 0.01},
  {name = "molten-iron", prob = 0.5},
  {name = "molten-copper", prob = 0.5},
  {name = "tungsten-plate", prob = 0.05}
}
for _, s in pairs(smelting_recipes) do
  table.insert(data.raw["recipe"][s.name].results, {
    type = "item", name = "bm-slag", amount = 1, probability = s.prob
  })
end

local iron_plate = data.raw["recipe"]["iron-plate"]
iron_plate.icon = "__base__/graphics/icons/iron-plate.png"
iron_plate.subgroup = "raw-material"
iron_plate.order = "aa"
iron_plate.main_product = "iron-plate"
local copper_plate = data.raw["recipe"]["copper-plate"]
copper_plate.icon = "__base__/graphics/icons/copper-plate.png"
copper_plate.subgroup = "raw-material"
copper_plate.order = "ab"
copper_plate.main_product = "copper-plate"
local steel_plate = data.raw["recipe"]["steel-plate"]
steel_plate.icon = "__base__/graphics/icons/steel-plate.png"
steel_plate.subgroup = "raw-material"
steel_plate.order = "ac"
steel_plate.ingredients = {{type = "item", name = "bm-steel-mix", amount = 1}}
steel_plate.main_product = "steel-plate"
local tungsten_plate = data.raw["recipe"]["tungsten-plate"]
tungsten_plate.icon = "__space-age__/graphics/icons/tungsten-plate.png"
tungsten_plate.main_product = "tungsten-plate"
