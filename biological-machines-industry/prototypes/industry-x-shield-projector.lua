local dh = require("__biological-machines-core__.data-helper")


dh.add_ingredient("energy-shield-equipment", "item", "copper-cable", 5)

dh.remove_ingredient("energy-shield-mk2-equipment", "energy-shield-equipment")
dh.add_ingredient("energy-shield-mk2-equipment", "item", "energy-shield-equipment", 5)
dh.add_ingredient("energy-shield-mk2-equipment", "item", "superconductor", 5)



data.raw["recipe"]["shield-projector"].ingredients = {
  {type = "item", name = "low-density-structure", amount = 100},
  {type = "item", name = "superconductor", amount = 100},
  {type = "item", name = "processing-unit", amount = 50},
  {type = "item", name = "copper-cable", amount = 200},
}

local sp_tech = data.raw["technology"]["shield-projector"]
sp_tech.prerequisites = {"electromagnetic-science-pack"}
sp_tech.unit.count = 1500
sp_tech.unit.ingredients = {
  {"automation-science-pack", 1},
  {"logistic-science-pack", 1},
  {"chemical-science-pack", 1},
  {"military-science-pack", 1},
  {"space-science-pack", 1},
  {"electromagnetic-science-pack", 1}
}
