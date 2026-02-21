local dh = require("__biological-machines-core__.data-helper")



dh.add_recipe_unlock("bm-glass-deposit", "bm-rail-from-glass-shard")



data:extend({
  {
    type = "recipe",
    name = "bm-rail-from-glass-shard",
    icons = {
      {
        icon = "__base__/graphics/icons/rail.png"
      },
      {
        icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon-opaque.png",
        scale = 0.25,
        shift = {8, 8}
      },
    },
    enabled = false,
    ingredients = {
      {type = "item", name = "bm-glass-shard", amount = 1},
      {type = "item", name = "iron-stick", amount = 1},
      {type = "item", name = "steel-plate", amount = 1}
    },
    results = {{type = "item", name = "rail", amount = 2}}
  },
})
