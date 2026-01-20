data:extend({
  {
    type = "recipe",
    name = "bm-suspension-tank",
    icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
    category = "crafting",
    enabled = false,
    allow_productivity = false,
    energy_required = 20,
    ingredients = {
      {type = "item", name = "biochamber", amount = 1},
      {type = "item", name = "carbon-fiber", amount = 20},
      {type = "item", name = "quantum-processor", amount = 10},
    },
    results = {{type = "item", name = "bm-suspension-tank", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-clone",
    icon = "__core__/graphics/icons/entity/character.png",
    category = "organic",
    enabled = false,
    allow_productivity = false,
    energy_required = 120,
    ingredients = {
      {type = "item", name = "biter-egg", amount = 10},
      {type = "item", name = "quantum-processor", amount = 1},
      {type = "item", name = "bioflux", amount = 50},
    },
    results = {{type = "item", name = "bm-clone", amount = 1}},
    result_is_always_fresh = true,
  },
  {
    type = "recipe",
    name = "bm-suspension-fluid",
    icon = "__biological-machines-cloning__/graphics/suspension-fluid.png",
    category = "organic",
    subgroup = "bm-biological-fluid-recipes",
    order = "b-b",
    enabled = false,
    allow_productivity = false,
    energy_required = 8,
    ingredients = {
      {type = "fluid", name = "water", amount = 100},
      {type = "fluid", name = "sulfuric-acid", amount = 10},
      {type = "item", name = "jelly", amount = 10},
      {type = "item", name = "bioflux", amount = 10},
    },
    results = {{type = "fluid", name = "bm-suspension-fluid", amount = 100}}
  },
  {
    type = "recipe",
    name = "bm-suspend-clone",
    icons = {
      {
        icon = "__core__/graphics/icons/entity/character.png",
      },
      {
        icon = "__biological-machines-cloning__/graphics/suspension-fluid.png",
        scale = 0.25,
        shift = {8, -8}
      },
    },
    category = "bm-suspension-tank",
    enabled = false,
    allow_productivity = false,
    energy_required = 8,
    ingredients = {
      {type = "fluid", name = "bm-suspension-fluid", amount = 100},
      {type = "item", name = "bm-clone", amount = 1}
    },
    results = {{type = "item", name = "bm-suspended-clone", amount = 1}},
    result_is_always_fresh = true,
  },
  {
    type = "recipe",
    name = "bm-prepare-tank",
    icons = {
      {
        icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
      },
      {
        icon = "__biological-machines-cloning__/graphics/suspension-fluid.png",
        scale = 0.25,
        shift = {8, -8}
      },
    },
    category = "bm-suspension-tank",
    enabled = false,
    allow_productivity = false,
    energy_required = 8,
    ingredients = {{type = "fluid", name = "bm-suspension-fluid", amount = 100}},
    results = {{type = "item", name = "bm-prepared-tank", amount = 1}},
    result_is_always_fresh = true,
  },
  {
    type = "recipe",
    name = "bm-clone-life-support",
    icon = "__core__/graphics/icons/entity/character.png",
    icons = {
      {
        icon = "__core__/graphics/icons/entity/character.png",
      },
      {
        icon = "__biological-machines-cloning__/graphics/suspension-fluid.png",
        scale = 0.25,
        shift = {8, -8}
      },
      {
        icon = "__base__/graphics/icons/signal/signal-clock.png",
        scale = 0.25,
        shift = {-8, 8}
      },
    },
    category = "bm-suspension-tank-filled",
    subgroup = "bm-cultivation",
    order = "z-b",
    enabled = false,
    allow_productivity = false,
    energy_required = 120,
    ingredients = {
      {type = "fluid", name = "bm-suspension-fluid", amount = 5},
      --{type = "item", name = "bioflux", amount = 1},
    },
    results = {},
    --results = {{type = "item", name = "spoilage", amount = 1}}
    --hidden = true,
  },
  {
    type = "recipe",
    name = "bm-prepared-tank-maintenance",
    icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
    category = "bm-suspension-tank-prepared",
    enabled = false,
    allow_productivity = false,
    energy_required = 120,
    ingredients = {},
    results = {},
    hidden = true,
  },
})
