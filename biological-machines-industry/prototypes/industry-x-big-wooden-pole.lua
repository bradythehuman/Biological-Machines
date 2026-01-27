local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("big-wooden-pole", "copper-cable")
dh.add_ingredient("big-wooden-pole", "item", "copper-cable", 2)

data.raw["recipe"]["big-wooden-pole"].enabled = false
dh.add_recipe_unlock("electronics", "big-wooden-pole")

local pole_item = data.raw["item"]["big-wooden-pole"]
pole_item.order = "a[energy]-a[small-electric-pole]-a"
pole_item.fuel_value = nil
pole_item.fuel_category = nil
