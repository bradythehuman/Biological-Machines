local dh = require("__biological-machines-core__.data-helper")



--RECIPE INGREDIENTS
data.raw["recipe"]["defender-capsule"].ingredients = {
  {type = "item", name = "flying-robot-frame", amount = 1},
  {type = "item", name = "electronic-circuit", amount = 1},
  {type = "item", name = "piercing-rounds-magazine", amount = 1}
}
data.raw["recipe"]["distractor-capsule"].ingredients = {
  {type = "item", name = "flying-robot-frame", amount = 3},
  {type = "item", name = "advanced-circuit", amount = 2},
  {type = "item", name = "bm-helium-power-cell", amount = 3},
  {type = "item", name = "battery", amount = 2}
}
data.raw["recipe"]["destroyer-capsule"].ingredients = {
  {type = "item", name = "flying-robot-frame", amount = 5},
  {type = "item", name = "processing-unit", amount = 3},
  {type = "item", name = "superconductor", amount = 5},
  {type = "item", name = "supercapacitor", amount = 3}
}



--ROBOT LIFESPAN
data.raw["combat-robot"]["defender"].time_to_live = 60 * 60 * 2.5
data.raw["combat-robot"]["distractor"].time_to_live = 60 * 60 * 3.75
data.raw["combat-robot"]["destroyer"].time_to_live = 60 * 60 * 5



--DEFENDER TECH
dh.add_prereq("defender", "robotics")

local add_chem_sci_pack = {
  "defender", "follower-robot-count-1", "follower-robot-count-2"
}
for i=1, #add_chem_sci_pack do
  table.insert(data.raw["technology"][add_chem_sci_pack[i]].unit.ingredients, {"chemical-science-pack", 1})
end
