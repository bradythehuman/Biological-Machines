local dh = require("__biological-machines-core__.data-helper")

local remove_cable = {"deadlock-large-lamp", "deadlock-electric-copper-lamp", "deadlock-floor-lamp"}
dh.remove_ingredient(remove_cable, "copper-cable")

local add_lightbulb = {
  ["deadlock-large-lamp"] = 4,
  ["deadlock-electric-copper-lamp"] = 4,
  ["deadlock-floor-lamp"] = 4,
}
dh.add_ingredient_table(add_lightbulb, "item",  "bm-lightbulb")

dh.remove_ingredient("deadlock-electric-copper-lamp", "advanced-circuit")

dh.add_ingredient("deadlock-electric-copper-lamp", "item", "electronic-circuit", 1)
