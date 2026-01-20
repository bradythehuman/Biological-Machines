require("prototypes.entities")
require("prototypes.equipment")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technologies")
require("prototypes.gui")



data:extend({
  --[[
  {
    type = "damage-type",
    name = "bm-starvation"
  },
  ]]
  {
    type = "item-subgroup",
    name = "bm-processed-food",
    group = "combat",
    order = "ca"
  },
  {
    type = "sprite",
    name = "bm-food-icon-red",
    filename = "__core__/graphics/icons/alerts/food-icon-red.png",
    priority = "extra-high-no-scale",
    width = 64,
    height = 64,
    flags = {"gui-icon"},
    scale = 0.5
  },
})
