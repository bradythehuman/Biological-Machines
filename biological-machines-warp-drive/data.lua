require("prototypes.entities")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technologies")

local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_require("Moshine", "bm-moshine-override", "prototypes.warp-x-moshine")



data:extend({
  {
    type = "recipe-category",
    name = "bm-warp-drive"
  },
  {
    type = "item-subgroup",
    name = "bm-planet-warp",
    group = "space",
    order = "k-a"
  },
})
