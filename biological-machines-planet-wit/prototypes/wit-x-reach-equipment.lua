local reach_recipe = data.raw["recipe"]["reach-equipment"]
reach_recipe.ingredients = {
  {type = "item", name = "low-density-structure", amount = 10},
  {type = "item", name = "advanced-circuit", amount = 5},
  {type = "item", name = "electric-engine-unit", amount = 1},
}
reach_recipe.category = "robotics"



local reach_tech = data.raw["technology"]["reach-equipment"]
reach_tech.prerequisites = {"space-science-pack", "utility-science-pack"}
reach_tech.unit.ingredients = {
  {"automation-science-pack", 1},
  {"logistic-science-pack", 1},
  {"chemical-science-pack", 1},
  {"utility-science-pack", 1},
  {"space-science-pack", 1}
}
