local dh = require("__biological-machines-core__.data-helper")



local remove_laser_turret = {"personal-laser-defense-equipment", "discharge-defense-equipment"}
dh.remove_ingredient(remove_laser_turret, "laser-turret")

local add_helium_cell = {
  ["laser-turret"] = 10,
  ["personal-laser-defense-equipment"] = 30,
  ["discharge-defense-equipment"] = 15,
}
dh.add_ingredient_table(add_helium_cell, "item", "bm-helium-power-cell")

local add_battery = {
  ["personal-laser-defense-equipment"] = 30,
  ["discharge-defense-equipment"] = 60,
}
dh.add_ingredient_table(add_battery, "item", "battery")

dh.add_ingredient("bm-warp-power-cell", "item", "bm-mixed-gas-power-cell", 5)



-----------------------------------------------------THRUSTER JUICE
--[[
local remove_water = {
  "thruster-fuel", "advanced-thruster-fuel",
  "thruster-oxidizer", "advanced-thruster-oxidizer"
}
dh.remove_ingredient(remove_water, "water")
]]

--dh.add_ingredient("thruster-fuel", "fluid", "hydrogen", 10)
--dh.add_ingredient("advanced-thruster-fuel", "fluid", "hydrogen", 100)

dh.remove_ingredient("advanced-thruster-fuel", "carbon")
dh.add_ingredient("advanced-thruster-fuel", "item", "carbon", 10)

--dh.add_ingredient("thruster-oxidizer", "fluid", "oxygen", 10)
--dh.add_ingredient("advanced-thruster-oxidizer", "fluid", "oxygen", 100)

dh.remove_ingredient("advanced-thruster-oxidizer", "iron-ore")
dh.add_ingredient("advanced-thruster-oxidizer", "item", "iron-ore", 10)

local craftable_on_wit = {
  "thruster-fuel", "advanced-thruster-fuel",
  "thruster-oxidizer", "advanced-thruster-oxidizer",
}
for i=1, #craftable_on_wit do
  data.raw["recipe"][craftable_on_wit[i]].surface_conditions = {{property = "pressure", min = 0, max = 50}}
end

local space_science = data.raw["recipe"]["space-science-pack"]
space_science.category = "bm-advanced-robotics"
space_science.ingredients = {
  {type = "fluid", name = "thruster-oxidizer", amount = 100},
  {type = "item", name = "bm-helium-power-cell", amount = 10},
  {type = "item", name = "electric-engine-unit", amount = 1}
}
space_science.results = {{type = "item", name = "space-science-pack", amount = 3}}
space_science.surface_conditions = {{property = "pressure", min = 50, max = 50}}

data:extend({
  --[[
  {
    type = "recipe",
    name = "water-separation",
    icon = "__biological-machines-planet-wit__/graphics/water-separation.png",
    category = "chemistry",
    subgroup = "fluid-recipes",
    order = "d[other-chemistry]-c[ice-melting]-a",
    auto_recycle = false,
    enabled = false,
    ingredients = {{type = "fluid", name = "water", amount = 20}},
    energy_required = 1,
    results = {
      {type = "fluid", name = "hydrogen", amount = 10},
      {type = "fluid", name = "oxygen", amount = 10}
    },
    allow_productivity = false,
    allow_decomposition = false,
    crafting_machine_tint = { --from ice melting
      primary = {r = 0.433, g = 0.773, b = 1.000, a = 1.000},
      secondary = {r = 0.591, g = 0.856, b = 1.000, a = 1.000},
      tertiary = {r = 0.381, g = 0.428, b = 0.436, a = 0.502},
      quaternary = {r = 0.499, g = 0.797, b = 0.793, a = 0.733},
    },
    show_amount_in_title = false,
    surface_conditions = {{property = "pressure", max = 50}}
  },
  ]]

  --------------------------------------------------------BASICS FROM HYDROGEN
  {
    type = "recipe",
    name = "bm-plastic-from-thruster-fuel",
    --icon = "__biological-machines-planet-wit__/graphics/plastic-from-thruster-fuel.png",
    icons = {
      {
        icon = "__base__/graphics/icons/plastic-bar.png"
      },
      {
        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
        scale = 0.25,
        shift = {8, -8}
      },
    },
    category = "chemistry",
    subgroup = "bm-wit-processes",
    order = "b-a",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 1,
    ingredients = {
      {type = "fluid", name = "thruster-fuel", amount = 100},
      {type = "item", name = "carbon", amount = 2}
    },
    results = {{type = "item", name = "plastic-bar", amount = 2}},
    crafting_machine_tint = { --same as plastic bar
      primary = {r = 1.000, g = 1.000, b = 1.000, a = 1.000},
      secondary = {r = 0.771, g = 0.771, b = 0.771, a = 1.000},
      tertiary = {r = 0.768, g = 0.665, b = 0.762, a = 1.000},
      quaternary = {r = 0.000, g = 0.000, b = 0.000, a = 1.000},
    },
  },
  {
    type = "recipe",
    name = "bm-solid-fuel-from-thruster-fuel",
    --icon = "__biological-machines-planet-wit__/graphics/solid-fuel-from-hydrogen.png",
    icons = {
      {
        icon = "__base__/graphics/icons/solid-fuel.png"
      },
      {
        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
        scale = 0.25,
        shift = {-10, -8}
      },
    },
    category = "chemistry",
    subgroup = "bm-wit-processes",
    order = "b-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 1,
    ingredients = {
      {type = "fluid", name = "thruster-fuel", amount = 50},
      {type = "fluid", name = "sulfuric-acid", amount = 5},
      {type = "item", name = "carbon", amount = 1}
    },
    results = {{type = "item", name = "solid-fuel", amount = 1}},
    crafting_machine_tint = { --same as thruster fuel
      primary = {r = 0.881, g = 0.100, b = 0.000, a = 0.502},
      secondary = {r = 0.930, g = 0.767, b = 0.605, a = 0.502},
      tertiary = {r = 0.873, g = 0.649, b = 0.542, a = 0.502},
      quaternary = {r = 0.629, g = 0.174, b = 0.000, a = 0.502},
    },
  },
  {
    type = "recipe",
    name = "bm-rocket-fuel-from-thruster-fuel",
    --icon = "__biological-machines-planet-wit__/graphics/rocket-fuel-from-thruster-fuel.png",
    icons = {
      {
        icon = "__base__/graphics/icons/rocket-fuel.png"
      },
      {
        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
        scale = 0.25,
        shift = {-10, -8}
      },
    },
    category = "chemistry",
    subgroup = "bm-wit-processes",
    order = "b-c",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 15,
    ingredients = {
      {type = "fluid", name = "thruster-fuel", amount = 100},
      {type = "fluid", name = "thruster-oxidizer", amount = 100},
      {type = "item", name = "solid-fuel", amount = 10}
    },
    results = {{type = "item", name = "rocket-fuel", amount = 1}},
  },
  {
    type = "recipe",
    name = "bm-lubricant-from-thruster-fuel",
    --icon = "__biological-machines-planet-wit__/graphics/lubricant-from-hydrogen.png",
    icons = {
      {
        icon = "__base__/graphics/icons/fluid/lubricant.png",
        scale = 0.4,
        shift = {0, 4}
      },
      {
        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
        scale = 0.25,
        shift = {-6, -8}
      },
      {
        icon = "__base__/graphics/icons/solid-fuel.png",
        scale = 0.25,
        shift = {6, -8}
      },
    },
    category = "chemistry",
    subgroup = "bm-wit-processes",
    order = "b-d",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 1,
    ingredients = {
      {type = "fluid", name = "thruster-fuel", amount = 10},
      {type = "fluid", name = "sulfuric-acid", amount = 10},
      {type = "item", name = "solid-fuel", amount = 1}
    },
    results = {{type = "fluid", name = "lubricant", amount = 10}},
    crafting_machine_tint = { --same as lubricant
      primary = {r = 0.268, g = 0.723, b = 0.223, a = 1.000},
      secondary = {r = 0.432, g = 0.793, b = 0.386, a = 1.000},
      tertiary = {r = 0.647, g = 0.471, b = 0.396, a = 1.000},
      quaternary = {r = 1.000, g = 0.395, b = 0.127, a = 1.000},
    },
  },

  --------------------------------------------------------GLASS
  {
    type = "recipe",
    name = "bm-brick-from-glass-shard",
    --icon = "__biological-machines-planet-wit__/graphics/brick-from-glass-shard.png",
    icons = {
      {
        icon = "__base__/graphics/icons/stone-brick.png"
      },
      {
        icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon-opaque.png",
        scale = 0.25,
        shift = {8, 8}
      },
    },
    category = "crafting-with-fluid",
    subgroup = "bm-wit-processes",
    order = "c-d",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 4,
    ingredients = {{type = "item", name = "bm-glass-shard", amount = 4}},
    results = {{type = "item", name = "stone-brick", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-glass-dust-filtration",
    icons = {
      {
        icon = "__biological-machines-k2-assets__/graphics/glass-dust.png",
      },
      {
        icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon-opaque.png",
        scale = 0.35,
      },
    },
    category = "crafting-with-fluid",
    subgroup = "bm-wit-processes",
    order = "c-b",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 4,
    ingredients = {{type = "fluid", name = "bm-glass-dust", amount = 200}},
    results = {{type = "item", name = "bm-glass-shard", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-glass-plate-from-shard",
    icon = "__biological-machines-core__/graphics/glass-plate.png",
    category = "smelting",
    subgroup = "bm-wit-processes",
    order = "c-f",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 3.2,
    ingredients = {{type = "item", name = "bm-glass-shard", amount = 1}},
    results = {{type = "item", name = "bm-glass-plate", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-molten-glass-from-shard",
    icon = "__biological-machines-core__/graphics/molten-glass.png",
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "a[melting]-d[molten-glass]",
    auto_recycle = false,
    enabled = false,
    ingredients = {{type = "item", name = "bm-glass-shard", amount = 50}},
    energy_required = 32,
    results = {{type = "fluid", name = "bm-molten-glass", amount = 500}},
    allow_productivity = true,
    hide_from_signal_gui = false,
    main_product =  "bm-molten-glass"
  },
  {
    type = "recipe",
    name = "bm-landfill-from-shard",
    --icon = "__biological-machines-planet-wit__/graphics/landfill-from-shard.png",
    icons = {
      {
        icon = "__base__/graphics/icons/landfill.png"
      },
      {
        icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon.png",
        scale = 0.25,
        shift = {8, 8}
      },
    },
    category = "crafting",
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]-d",
    auto_recycle = false,
    enabled = false,
    energy_required = 0.5,
    ingredients = {{type = "item", name = "bm-glass-shard", amount = 50}},
    results = {{type = "item", name = "landfill", amount = 1}}
  },
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
  {
    type = "recipe",
    name = "bm-helium-power-cell",
    icon = "__biological-machines-planet-wit__/graphics/helium-power-cell.png",
    category = "chemistry-or-cryogenics",
    subgroup = "bm-wit-processes",
    order = "c-g",
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {
      {type = "fluid", name = "bm-helium", amount = 10},
      {type = "item", name = "copper-plate", amount = 1},
      {type = "item", name = "bm-glass-plate", amount = 1}
    },
    results = {{type = "item", name = "bm-helium-power-cell", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-mixed-gas-power-cell",
    icon = "__biological-machines-planet-wit__/graphics/mixed-gas-power-cell.png",
    category = "cryogenics",
    subgroup = "bm-wit-processes",
    order = "c-g",
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {
      {type = "fluid", name = "fluorine", amount = 10},
      {type = "fluid", name = "petroleum-gas", amount = 10},
      {type = "fluid", name = "bm-helium", amount = 10},
      {type = "item", name = "holmium-plate", amount = 2},
      {type = "item", name = "bm-glass-plate", amount = 2}
    },
    results = {{type = "item", name = "bm-mixed-gas-power-cell", amount = 1}}
  },

  --------------------------------------------------------COPPER
  {
    type = "recipe",
    name = "bm-copper-sulfate-electrolysis",
    icon = "__biological-machines-planet-wit__/graphics/copper-sulfate-electrolysis.png",
    category = "chemistry",
    subgroup = "bm-wit-processes",
    order = "a-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "bm-copper-sulfate", amount = 1},
      {type = "fluid", name = "water", amount = 10}
    },
    results = {
      {type = "item", name = "bm-copper-dust", amount = 1},
      {type = "fluid", name = "water", amount = 5},
      {type = "fluid", name = "sulfuric-acid", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "bm-copper-plate-from-dust",
    icon = "__base__/graphics/icons/copper-plate.png",
    category = "smelting",
    subgroup = "bm-wit-processes",
    order = "a-e",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    energy_required = 3.2,
    ingredients = {{type = "item", name = "bm-copper-dust", amount = 1}},
    results = {{type = "item", name = "copper-plate", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-molten-copper-from-dust",
    icon = "__biological-machines-planet-wit__/graphics/molten-copper-from-dust.png",
    category = "metallurgy",
    subgroup = "bm-wit-processes",
    order = "a-f",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    energy_required = 32,
    ingredients = {
      {type = "item", name = "bm-copper-dust", amount = 50},
      {type = "item", name = "calcite", amount = 1},
    },
    results = {{type = "fluid", name = "molten-copper", amount = 500}},
    hide_from_signal_gui = false,
    main_product =  "molten-copper"
  },

  ---------------------------------------------------------INTERSTELLAR
  {
    type = "recipe",
    name = "bm-empty-data-disk",
    energy_required = 6,
    surface_conditions = {{property = "pressure", min = 0, max = 50}},
    enabled = false,
    allow_productivity = true,
    category = "electromagnetics",
    ingredients = {
      {type = "fluid", name = "lubricant", amount = 10},
      {type = "item", name = "bm-glass-plate", amount = 2},
      {type = "item", name = "holmium-plate", amount = 1},
      {type = "item", name = "carbon-fiber", amount = 1},
      {type = "item", name = "advanced-circuit", amount = 1},
    },
    results = {{type = "item", name = "bm-empty-data-disk", amount = 1}},
  },
  {
    type = "recipe",
    name = "bm-initial-data",
    icons = {
      {
        icon = "__biological-machines-k2-assets__/graphics/complete-data-disk.png",
        scale = 0.3,
        shift = {-4, -4}
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/incomplete-data-disk.png",
        scale = 0.4,
        shift = {3, 3}
      },
    },
    --icon = "__biological-machines-k2-assets__/graphics/incomplete-data-disk.png",
    subgroup = "bm-wit-processes",
    order = "c-g-e",
    energy_required = 4,
    enabled = false,
    allow_productivity = false,
    category = "electromagnetics",
    ingredients = {{type = "item", name = "bm-empty-data-disk", amount = 1}},
    results = {
      {type = "item", name = "bm-incomplete-data-disk", amount = 1, probability = 0.7425},
      {type = "item", name = "bm-complete-data-disk", amount = 1, probability = 0.2475},
    },
  },
  {
    type = "recipe",
    name = "bm-secondary-data",
    icons = {
      {
        icon = "__biological-machines-k2-assets__/graphics/incomplete-data-disk.png",
        scale = 0.3,
        shift = {-4, -4}
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/complete-data-disk.png",
        scale = 0.4,
        shift = {3, 3}
      },
    },
    --icon = "__biological-machines-k2-assets__/graphics/complete-data-disk.png",
    subgroup = "bm-wit-processes",
    order = "c-g-f",
    energy_required = 2,
    enabled = false,
    allow_productivity = false,
    category = "electromagnetics",
    ingredients = {{type = "item", name = "bm-incomplete-data-disk", amount = 1}},
    results = {
      {type = "item", name = "bm-incomplete-data-disk", amount = 1, probability = 0.225},
      {type = "item", name = "bm-complete-data-disk", amount = 1, probability = 0.675},
    },
  },
  {
    type = "recipe",
    name = "bm-interstellar-science-pack",
    icon = "__biological-machines-planet-wit__/graphics/interstellar-science-pack-icon.png",
    energy_required = 5,
    surface_conditions = {{property = "pressure", min = 50, max = 50}},
    enabled = false,
    allow_productivity = true,
    category = "bm-advanced-robotics",
    ingredients = {
      {type = "fluid", name = "thruster-oxidizer", amount = 100},
      {type = "item", name = "bm-mixed-gas-power-cell", amount = 5},
      {type = "item", name = "flying-robot-frame", amount = 1},
      {type = "item", name = "bm-complete-data-disk", amount = 1},
    },
    results = {
      {type = "item", name = "bm-interstellar-science-pack", amount = 1},
      {type = "item", name = "bm-empty-data-disk", amount = 1, probability = 0.9, ignored_by_productivity = 1},
    },
    main_product = "bm-interstellar-science-pack",
  },
  {
    type = "recipe",
    name = "bm-advanced-accumulator",
    category = "electromagnetics",
    --subgroup = "bm-wit-processes",
    --order = "a-g-b",
    enabled = false,
    allow_productivity = false,
    energy_required = 20,
    ingredients = {
      {type = "item", name = "low-density-structure", amount = 20},
      {type = "item", name = "lithium-plate", amount = 50},
      {type = "item", name = "quantum-processor", amount = 10},
      {type = "item", name = "supercapacitor", amount = 100},
      {type = "item", name = "bm-mixed-gas-power-cell", amount = 50},
    },
    results = {{type = "item", name = "bm-advanced-accumulator", amount = 1}}
  },
})
