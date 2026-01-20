local dh = require("__biological-machines-core__.data-helper")



data.raw["recipe"]["bm-glass-dust-filtration"].results = {
  {type = "item", name = "bm-sand", amount = 10},
  {type = "item", name = "bm-lime", amount = 2},
  {type = "item", name = "bm-potash", amount = 1},
  {type = "item", name = "bm-glass-shard", amount = 1},
}

local brick_recipe = data.raw["recipe"]["bm-brick-from-glass-shard"]
brick_recipe.ingredients = {
  {type = "fluid", name = "water", amount = 10},
  {type = "item", name = "bm-cement-mix", amount = 1},
  {type = "item", name = "bm-glass-shard", amount = 4},
}
brick_recipe.icons = {
  {
    icon = "__base__/graphics/icons/stone-brick.png",
    --scale = 0.4,
    shift = {0, -4}
  },
  {
    icon = "__biological-machines-industry__/graphics/cement-mix.png",
    scale = 0.25,
    shift = {-8, 8}
  },
  {
    icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon-opaque.png",
    scale = 0.25,
    shift = {8, 8}
  },
}

data.raw["recipe"]["bm-landfill-from-shard"].ingredients = {
  {type = "item", name = "bm-glass-shard", amount = 100}
}

data:extend({
  {
    type = "recipe",
    name = "bm-simple-brick-from-glass-shard",
    --icon = "__biological-machines-planet-wit__/graphics/brick-from-glass-shard.png",
    icons = {
      {
        icon = "__base__/graphics/icons/stone-brick.png",
        --scale = 0.4,
        shift = {0, -4}
      },
      {
        icon = "__space-age__/graphics/icons/calcite.png",
        scale = 0.25,
        shift = {-8, 8}
      },
      {
        icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon-opaque.png",
        scale = 0.25,
        shift = {8, 8}
      },
    },
    category = "crafting",
    subgroup = "bm-wit-processes",
    order = "c-c",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "ice", amount = 1},
      {type = "item", name = "calcite", amount = 1},
      {type = "item", name = "bm-glass-shard", amount = 2}
    },
    results = {{type = "item", name = "stone-brick", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-circuit-board-with-glass",
    --icon = "__biological-machines-industry__/graphics/circuit-board.png",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/circuit-board.png"
      },
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.25,
        shift = {-8, 8}
      },
      {
        icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon-opaque.png",
        scale = 0.25,
        shift = {8, 8}
      },
    },
    category = "crafting",
    subgroup = "bm-wit-processes",
    order = "c-e",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "bm-glass-shard", amount = 2},
      {type = "item", name = "carbon", amount = 1},
      {type = "item", name = "sulfur", amount = 1},
    },
    results = {{type = "item", name = "bm-circuit-board", amount = 2}}
  },
})

dh.add_recipe_unlock("bm-glass-deposit", "bm-simple-brick-from-glass-shard")
dh.add_recipe_unlock("bm-glass-deposit", "bm-circuit-board-with-glass")
