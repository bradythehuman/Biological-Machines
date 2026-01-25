data.raw["recipe"]["kr-shelter"].ingredients = {
  {type = "item", name = "iron-plate", amount = 100},
  {type = "item", name = "copper-cable", amount = 50},
  {type = "item", name = "bm-suspension-tank", amount = 1},
  {type = "item", name = "fission-reactor-equipment", amount = 1},
  {type = "item", name = "assembling-machine-2", amount = 1},
}

local shelter_tech = data.raw["technology"]["kr-shelter"]
shelter_tech.prerequisites = {"bm-cloning", "fission-reactor-equipment"}
shelter_tech.unit = {
  count = 1000,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"military-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
    {"space-science-pack", 1},
    {"metallurgic-science-pack", 1},
    {"agricultural-science-pack", 1},
    {"electromagnetic-science-pack", 1},
    {"bm-nuclear-military-science-pack", 1},
    {"cryogenic-science-pack", 1},
  },
  time = 60,
}

table.insert(bm_add_full_resistences, data.raw["electric-energy-interface"]["kr-shelter"])
