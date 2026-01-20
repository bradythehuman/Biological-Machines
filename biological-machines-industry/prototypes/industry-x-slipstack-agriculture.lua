--PLANT
local plant_entity = data.raw.plant["slipstack-plant"]
plant_entity.minable.results =       {
  {type = "item", name = "spoilage", amount = 6},
  {type = "item", name = "stone", amount = 4}
}
plant_entity.growth_ticks = 5 * minute



--ITEM
data.raw.item["slipstack-seed"].order = "a[seeds]-d[slipstack-seed]-b"



--RECIPE
local seed_recipe = data.raw.recipe["slipstack-seed"]
seed_recipe.icons = {
  {
    icon = seed_recipe.icon
  },
  {
    icon = "__base__/graphics/icons/fluid/water.png",
    scale = 0.35,
    shift = {5, -5},
  }
}
seed_recipe.icon = nil
seed_recipe.order = "a[seeds]-d[slipstack-seed]-a"
seed_recipe.ingredients = {
  {type = "fluid", name = "water", amount = 1000},
  {type = "item", name = "nutrients", amount = 1}
}
seed_recipe.results = {
  {type = "item", name = "slipstack-seed", amount = 1, probability = 0.1},
  {type = "item", name = "spoilage", amount = 5}
}
seed_recipe.primary_result = "slipstack-seed"



--TECHNOLOGY
local slipstack_tech = data.raw.technology["slipstack-propagation"]
slipstack_tech.prerequisites = {"agricultural-science-pack"}
slipstack_tech.research_trigger = nil
slipstack_tech.unit = {
  count = 100,
  ingredients =
  {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"space-science-pack", 1},
    {"agricultural-science-pack", 1}
  },
  time = 60
}
