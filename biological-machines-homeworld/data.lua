require("prototypes.decoratives")
require("prototypes.enemies")
require("prototypes.entities")
require("prototypes.items")
require("prototypes.noise-expressions")
require("prototypes.planet")
require("prototypes.recipes")
require("prototypes.technologies")
require("prototypes.tiles")



if not mods["biological-machines-cloning"] then
  require("prototypes.dummy-clone")
end



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
