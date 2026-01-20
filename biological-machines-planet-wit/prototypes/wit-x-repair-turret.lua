local dh = require("__biological-machines-core__.data-helper")



dh.add_ingredient("repair-turret", "item", "bm-helium-power-cell", 5)



data.raw["recipe"]["repair-turret"].category = "robotics"



data.raw["technology"]["repair-turret"].prerequisites = {"space-science-pack"}

local rt_upgrade_techs = {
  "repair-turret", "repair-turret-construction", "repair-turret-efficiency-1",
  "repair-turret-efficiency-2", "repair-turret-efficiency-3",
  "repair-turret-power-1", "repair-turret-power-2", "repair-turret-power-3"
}
for _, tech_name in pairs(rt_upgrade_techs) do
  data.raw["technology"][tech_name].unit.ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"space-science-pack", 1},
  }
end
