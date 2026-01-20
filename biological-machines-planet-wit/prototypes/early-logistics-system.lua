local dh = require("__biological-machines-core__.data-helper")



local unit_ingredients = {
  {"automation-science-pack", 1},
  {"logistic-science-pack", 1},
  {"chemical-science-pack", 1},
},



dh.remove_prereq("logistic-system", "space-science-pack")
dh.add_prereq("logistic-system", "logistic-robotics")

data.raw.technology["logistic-system"].unit.ingredients = unit_ingredients



if mods["aai-containers"] then
  local tech_names = {
    "aai-strongbox-logistic", "aai-storehouse-logistic", "aai-warehouse-logistic"
  }
  for i=1, #tech_names do
    data.raw.technology[tech_names[i]].unit.ingredients = unit_ingredients
  end
end
