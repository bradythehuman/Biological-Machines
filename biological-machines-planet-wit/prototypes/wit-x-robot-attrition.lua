local dh = require("__biological-machines-core__.data-helper")



if settings.startup["bm-early-logistics-system"].value then
  dh.add_prereq("robot-attrition-explosion-safety", "space-science-pack")
end

dh.add_prereq("robot-attrition-explosion-safety", "utility-science-pack")



data.raw.technology["robot-attrition-explosion-safety"].unit.ingredients = {
 {"automation-science-pack", 1},
 {"logistic-science-pack", 1},
 {"chemical-science-pack", 1},
 {"space-science-pack", 1},
 {"utility-science-pack", 1},
}
