local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("snouz_better_substation", "supercapacitor")
dh.add_ingredient("snouz_better_substation", "item", "superconductor", 10)

local substation_tech = data.raw["technology"]["snouz_better_substation_tech"]
substation_tech.prerequisites = {"electromagnetic-science-pack", "production-science-pack", "electric-energy-distribution-2"}
substation_tech.unit.ingredients = {
  {"automation-science-pack", 1},
  {"logistic-science-pack", 1},
  {"chemical-science-pack", 1},
  {"production-science-pack", 1},
  {"space-science-pack", 1},
  {"electromagnetic-science-pack", 1}
}

local substation_entity = data.raw["electric-pole"]["snouz_better_substation"]
substation_entity.maximum_wire_distance = 51
substation_entity.supply_area_distance = 25.5
