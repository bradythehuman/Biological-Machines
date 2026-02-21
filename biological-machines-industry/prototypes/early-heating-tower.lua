local dh = require("__biological-machines-core__.data-helper")



dh.add_prereq("nuclear-power", "heating-tower")
dh.add_prereq("planet-discovery-gleba", "heating-tower")

dh.remove_prereq("planet-discovery-aquilo", "heating-tower")

dh.remove_recipe_unlock("nuclear-power", "heat-pipe")
dh.remove_recipe_unlock("nuclear-power", "heat-exchanger")
dh.remove_recipe_unlock("nuclear-power", "steam-turbine")



local heating_tower_tech = data.raw.technology["heating-tower"]
heating_tower_tech.prerequisites = {"concrete"}
heating_tower_tech.research_trigger = nil
heating_tower_tech.unit = {
  count = 600,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
  },
  time = 30
}
