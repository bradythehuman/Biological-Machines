require("prototypes.entities")
require("prototypes.items")
require("prototypes.noise-expressions")
require("prototypes.planet")
require("prototypes.recipes")
require("prototypes.technologies")
require("prototypes.tiles")




data:extend({
  {
    type = "recipe-category",
    name = "bm-market"
  },
  {
    type = "item-subgroup",
    name = "bm-homeworld",
    group = "space",
    order = "k-b",
    --group = "intermediate-products",
    --order = "p-z-z",
  },
})
