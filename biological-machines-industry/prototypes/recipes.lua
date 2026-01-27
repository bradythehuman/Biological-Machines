local dh = require("__biological-machines-core__.data-helper")



--wood gasification? remove pump oil tech trigger, remove oil autoplace on forest tiles (oil mostly in desert)
--resister + battery in processing unit?
--add foundry recipes casting brick from lava or stone?
--replace pistons in y. belt recipe with iron-sticks, add piston/engine/electric-engine to y./r./b. splitter recipes



data.raw["recipe"]["advanced-oxide-asteroid-crushing"].results = {
  {type = "item", name = "ice", amount = 2},
  {type = "item", name = "calcite", amount = 1},
  {type = "item", name = "bm-potassium-nitrate", amount = 2},
  {type = "item", name = "oxide-asteroid-chunk", amount = 1, probability = 0.05}
}



------------------------------------------------CARBON
dh.remove_ingredient("grenade", "coal")

local add_carbon = {
  ["firearm-magazine"] = 1,
  ["shotgun-shell"] = 1,
  ["grenade"] = 5,
  --["casting-steel"] = 1,
  --["casting-low-density-structure"] = 2
}
dh.add_ingredient_table(add_carbon, "item",  "carbon")

local add_carbon_fiber = {
  ["fusion-reactor"] = 200,
  ["fusion-generator"] = 100
}
dh.add_ingredient_table(add_carbon_fiber, "item", "carbon-fiber")

dh.remove_ingredient("explosives", "sulfur")

local add_gunpowder = {
  ["grenade"] = 1,
  ["piercing-rounds-magazine"] = 1,
  ["explosives"] = 1,
  ["piercing-shotgun-shell"] = 1
}
dh.add_ingredient_table(add_gunpowder, "item", "bm-gunpowder-mix")

data.raw["recipe"]["acid-neutralisation"].results = {
  {type = "fluid", name = "steam", amount = 5000, temperature = 500},
  {type = "item", name = "sulfur", amount = 10}
}



------------------------------------------------METAL
local smelting_recipes = {
  {name = "iron-plate", prob = 0.01},
  {name = "copper-plate", prob = 0.01},
  {name = "molten-iron", prob = 0.5},
  {name = "molten-copper", prob = 0.5},
  {name = "tungsten-plate", prob = 0.05}
}
for _, s in pairs(smelting_recipes) do
  table.insert(data.raw["recipe"][s.name].results, {
    type = "item", name = "bm-slag", amount = 1, probability = s.prob
  })
end

local iron_plate = data.raw["recipe"]["iron-plate"]
iron_plate.icon = "__base__/graphics/icons/iron-plate.png"
iron_plate.subgroup = "raw-material"
iron_plate.order = "aa"
iron_plate.main_product = "iron-plate"
local copper_plate = data.raw["recipe"]["copper-plate"]
copper_plate.icon = "__base__/graphics/icons/copper-plate.png"
copper_plate.subgroup = "raw-material"
copper_plate.order = "ab"
copper_plate.main_product = "copper-plate"
local steel_plate = data.raw["recipe"]["steel-plate"]
steel_plate.icon = "__base__/graphics/icons/steel-plate.png"
steel_plate.subgroup = "raw-material"
steel_plate.order = "ac"
steel_plate.ingredients = {{type = "item", name = "bm-steel-mix", amount = 1}}
steel_plate.main_product = "steel-plate"
local tungsten_plate = data.raw["recipe"]["tungsten-plate"]
tungsten_plate.icon = "__space-age__/graphics/icons/tungsten-plate.png"
tungsten_plate.main_product = "tungsten-plate"

local remove_iron_plate = {"fast-inserter", "biochamber"}
dh.remove_ingredient(remove_iron_plate, "iron-plate")

dh.remove_ingredient("chemical-plant", "pipe")

local remove_iron_gear = {
  "long-handed-inserter",
  "fast-splitter", "express-splitter",
  "chemical-plant", "assembling-machine-2", "centrifuge",
  "rocket-turret", "recycler", "oil-refinery"
}
dh.remove_ingredient(remove_iron_gear, "iron-gear-wheel")

local add_gear = {
  ["fast-inserter"] = 2,
  ["splitter"] = 5,
}
dh.add_ingredient_table(add_gear, "item", "iron-gear-wheel")

dh.remove_ingredient("low-density-structure", "steel-plate")
local add_steel = {
  ["speed-module"] = 1,
  ["efficiency-module"] = 1,
  ["productivity-module"] = 1,
  ["quality-module"] = 1,
  ["low-density-structure"] = 5
}
dh.add_ingredient_table(add_steel, "item", "steel-plate")

dh.remove_ingredient("low-density-structure", "copper-plate")
dh.add_ingredient("low-density-structure", "item", "copper-plate", 5)

dh.remove_ingredient("casting-low-density-structure", "molten-iron")
dh.add_ingredient("casting-low-density-structure", "fluid", "bm-molten-steel", 200)
dh.remove_ingredient("casting-low-density-structure", "molten-copper")
dh.add_ingredient("casting-low-density-structure", "fluid", "molten-copper", 60)

local add_piston = {
  --["transport-belt"] = 1,
  ["inserter"] = 1,
  ["long-handed-inserter"] = 1,
  ["fast-splitter"] = 10,
  ["electric-mining-drill"] = 5,
  ["pumpjack"] = 10,
  ["assembling-machine-1"] = 5,
  ["steam-engine"] = 10,
  ["offshore-pump"] = 2,
  ["agricultural-tower"] = 15,
  ["gun-turret"] = 5,
  ["laser-turret"] = 5,
  ["engine-unit"] = 2,
}
dh.add_ingredient_table(add_piston, "item", "bm-piston")

local add_engine = {
  ["chemical-plant"] = 2,
  ["assembling-machine-2"] = 2,
  ["centrifuge"] = 20,
  ["rocket-turret"] = 10,
  ["artillery-turret"] = 30
}
dh.add_ingredient_table(add_engine, "item", "engine-unit")

local add_electric_engine = {
  ["stack-inserter"] = 2,
  ["express-splitter"] = 5,
  ["assembling-machine-3"] = 2,
  ["electromagnetic-plant"] = 10,
  ["recycler"] = 10,
  ["tesla-turret"] = 10,
  ["railgun-turret"] = 20,
  ["cargo-bay"] = 2,
  ["space-platform-starter-pack"] = 10
}
dh.add_ingredient_table(add_electric_engine, "item", "electric-engine-unit")

local molten_iron_to_steel = {
  "big-mining-drill", "casting-steel",
  "casting-low-density-structure", "tungsten-plate",
}
for _, recipe_name in pairs(molten_iron_to_steel) do
  for _, ingredient in pairs(data.raw.recipe[recipe_name].ingredients) do
    if ingredient.name == "molten-iron" then
      ingredient.name = "bm-molten-steel"
    end
  end
end



-------------------------------------------------STONE
data.raw["recipe"]["crusher"].ingredients = {
  {type = "item", name = "iron-plate", amount = 5},
  {type = "item", name = "iron-gear-wheel", amount = 10},
  {type = "item", name = "bm-piston", amount = 5},
  {type = "item", name = "electronic-circuit", amount = 2}
}

data.raw["recipe"]["landfill"].ingredients = {
  {type = "item", name = "stone", amount = 100}
}

dh.remove_ingredient("concrete", "iron-ore")
dh.remove_ingredient("refined-concrete", "steel-plate")

local add_cement = {
  ["concrete"] = 2,
  ["refined-concrete"] = 4
}
dh.add_ingredient_table(add_cement, "item", "bm-cement-mix")

data.raw["recipe"]["concrete-from-molten-iron"] = nil

data.raw["recipe"]["molten-copper-from-lava"].results = {
  {type = "fluid", name = "molten-copper", amount = 250},
  {type = "item", name = "stone", amount = 10},
  {type = "item", name = "iron-ore", amount = 6}
}

data.raw["recipe"]["molten-iron-from-lava"].results = {
  {type = "fluid", name = "molten-iron", amount = 250},
  {type = "item", name = "stone", amount = 10},
  {type = "item", name = "copper-ore", amount = 3}
}

dh.add_ingredient("assembling-machine-3", "item", "concrete", 5)

local add_ref_concrete = {
  ["fusion-reactor"] = 100,
  ["fusion-generator"] = 50
}
dh.add_ingredient_table(add_ref_concrete, "item", "refined-concrete")

local add_glass = {
  ["chemical-plant"] = 5,
  --["small-lamp"] = 1,
  ["display-panel"] = 1,
  ["space-platform-starter-pack"] = 20
}
dh.add_ingredient_table(add_glass, "item", "bm-glass-plate")

local add_chem_plant = {
  ["oil-refinery"] = 2,
  ["biochamber"] = 1,
  ["cryogenic-plant"] = 2
}
dh.add_ingredient_table(add_chem_plant, "item", "chemical-plant")



-------------------------------------------------ELECTRONICS
data.raw["recipe"]["electronic-circuit"].ingredients = {
  {type = "item", name = "copper-cable", amount = 3},
  {type = "item", name = "bm-circuit-board", amount = 1}
}

dh.remove_ingredient("small-lamp", "copper-cable")

local remove_electronic_circuit = {
  --"small-lamp",
  "oil-refinery", "biochamber"
}
dh.remove_ingredient(remove_electronic_circuit, "electronic-circuit")

table.insert(data.raw["recipe"]["scrap-recycling"].results, {
  type = "item", name = "bm-lightbulb", amount = 1, probability = 0.02
})

local add_lightbulb = {
  ["small-lamp"] = 2,
  ["rail-signal"] = 1,
  ["rail-chain-signal"] = 1,
  ["speed-module"] = 3,
  ["efficiency-module"] = 3,
  ["productivity-module"] = 3,
  ["quality-module"] = 3,
  ["car"] = 2,
  ["tank"] = 2,
  ["locomotive"] = 2,
}
dh.add_ingredient_table(add_lightbulb, "item", "bm-lightbulb")
--[[
local add_plastic = {
  ["speed-module-2"] = 20,
  ["efficiency-module-2"] = 20,
  ["productivity-module-2"] = 20,
  ["quality-module-2"] = 20
}
dh.add_ingredient_table(add_plastic, "item", "plastic-bar")
]]

local remove_processing_unit = {"mech-armor", "power-armor-mk2"}
dh.remove_ingredient(remove_processing_unit, "processing-unit")

dh.add_ingredient("spidertron", "item", "productivity-module-2", 25)

--dh.add_ingredient("power-armor", "item", "modular-armor", 1)
dh.add_ingredient("power-armor-mk2", "item", "power-armor", 1)
dh.add_ingredient("mech-armor", "item", "quality-module-2", 25)
dh.add_ingredient("mech-armor", "item", "flying-robot-frame", 40)

dh.add_ingredient("biolab", "item", "efficiency-module", 10)

dh.remove_ingredient("efficiency-module-3", "spoilage")
dh.add_ingredient("efficiency-module-3", "item", "pentapod-egg", 1)



------------------------------------------------OIL
data.raw["recipe"]["heavy-oil-cracking"].ingredients = {
  {type = "fluid", name = "bm-ethanol", amount = 8},
  {type = "fluid", name = "heavy-oil", amount = 40}
}
data.raw["recipe"]["light-oil-cracking"].ingredients = {
  {type = "fluid", name = "bm-ethanol", amount = 6},
  {type = "fluid", name = "light-oil", amount = 30}
}

data.raw["recipe"]["sulfur"].ingredients = {
  {type = "fluid", name = "water", amount = 30},
  {type = "fluid", name = "heavy-oil", amount = 30}
}

table.insert(data.raw["recipe"]["basic-oil-processing"].results,
{type = "item", name = "bm-tar", amount = 3})
--table.insert(data.raw["recipe"]["advanced-oil-processing"].results,
--{type = "item", name = "tar", amount = 1})
table.insert(data.raw["recipe"]["simple-coal-liquefaction"].results,
{type = "item", name = "bm-tar", amount = 2})
table.insert(data.raw["recipe"]["coal-liquefaction"].results,
{type = "item", name = "bm-tar", amount = 1})

data.raw["recipe"]["advanced-oil-processing"].results = {
  {type = "fluid", name = "heavy-oil", amount = 55},
  {type = "fluid", name = "light-oil", amount = 45},
  {type = "fluid", name = "petroleum-gas", amount = 25},
  {type = "item", name = "bm-tar", amount = 1}
}



data:extend({
  ------------------------------------------------CARBON
  {
    type = "recipe",
    name = "bm-carbonizer",
    icon = "__biological-machines-industry__/graphics/carbonizer-icon.png",
    category = "crafting",
    energy_required = 1,
    ingredients = {{type = "item", name = "stone-brick", amount = 5}},
    results = {{type = "item", name = "bm-carbonizer", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-wood-pyrolysis",
    icons = {
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.4,
        shift = {-2, -2}
      },
      {
        icon = "__base__/graphics/icons/wood.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "bm-pyrolysis",
    subgroup = "bm-pyrolysis",
    order = "a",
    auto_recycle = false,
    allow_decomposition = false,
    energy_required = 9.6,
    ingredients = {{type = "item", name = "wood", amount = 10}},
    results = {
      {type = "item", name = "carbon", amount = 3},
      {type = "item", name = "bm-potash", amount = 3}
    }
  },
  {
    type = "recipe",
    name = "bm-coal-pyrolysis",
    icons = {
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.4,
        shift = {-2, -2}
      },
      {
        icon = "__base__/graphics/icons/coal.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "bm-pyrolysis",
    subgroup = "bm-pyrolysis",
    order = "b",
    auto_recycle = false,
    allow_decomposition = false,
    energy_required = 9.6,
    ingredients = {{type = "item", name = "coal", amount = 10}},
    results = {
      {type = "item", name = "carbon", amount = 2},
      {type = "item", name = "bm-tar", amount = 2},
      {type = "item", name = "bm-potash", amount = 1, probability = 0.5},
      {type = "item", name = "sulfur", amount = 1, probability = 0.5}
    }
  },
  {
    type = "recipe",
    name = "bm-spoilage-pyrolysis",
    icons = {
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.4,
        shift = {-2, -2}
      },
      {
        icon = "__space-age__/graphics/icons/spoilage.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "bm-pyrolysis",
    subgroup = "bm-pyrolysis",
    order = "c",
    auto_recycle = false,
    allow_decomposition = false,
    energy_required = 9.6,
    ingredients = {{type = "item", name = "spoilage", amount = 20}},
    results = {
      {type = "item", name = "carbon", amount = 2},
      {type = "item", name = "bm-potash", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "bm-solid-fuel-pyrolysis",
    icons = {
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.4,
        shift = {-2, -2}
      },
      {
        icon = "__base__/graphics/icons/solid-fuel.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "bm-pyrolysis",
    subgroup = "bm-pyrolysis",
    order = "d",
    auto_recycle = false,
    enabled = false,
    allow_decomposition = false,
    energy_required = 9.6,
    ingredients = {
      {type = "item", name = "solid-fuel", amount = 10}
    },
    results = {
      {type = "item", name = "carbon", amount = 3},
      {type = "item", name = "bm-tar", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "bm-tar-pyrolysis",
    icons = {
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.4,
        shift = {-2, -2}
      },
      {
        icon = "__biological-machines-industry__/graphics/tar.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "bm-pyrolysis",
    subgroup = "bm-pyrolysis",
    order = "e",
    auto_recycle = false,
    allow_decomposition = false,
    energy_required = 9.6,
    ingredients = {{type = "item", name = "bm-tar", amount = 10}},
    results = {
      {type = "item", name = "carbon", amount = 1},
      {type = "item", name = "bm-tar", amount = 5},
      {type = "item", name = "sulfur", amount = 1, probability = 0.5}
    }
  },
  {
    type = "recipe",
    name = "bm-potassium-nitrate",
    icon = "__biological-machines-k2-assets__/graphics/potassium-nitrate.png",
    category = "crafting-with-fluid",
    subgroup = "bm-powder",
    order = "a-d",
    --auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "bm-potash", amount = 5},
      {type = "fluid", name = "water", amount = 10}
    },
    results = {{type = "item", name = "bm-potassium-nitrate", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-gunpowder-mix",
    icon = "__biological-machines-industry__/graphics/gunpowder-mix.png",
    category = "crafting",
    subgroup = "bm-powder",
    order = "b-a",
    --auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "bm-potassium-nitrate", amount = 2},
      {type = "item", name = "carbon", amount = 1},
      {type = "item", name = "sulfur", amount = 1}
    },
    results = {
      {type = "item", name = "bm-gunpowder-mix", amount = 2}
    }
  },

  ------------------------------------------------METAL
  {
    type = "recipe",
    name = "bm-slag-crushing",
    icon = "__biological-machines-industry__/graphics/slag-crushing.png",
    category = "crushing",
    subgroup = "bm-powder",
    order = "c-c",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-slag", amount = 1}
    },
    results = {
      {type = "item", name = "bm-sand", amount = 10},
      {type = "item", name = "carbon", amount = 1},
      {type = "item", name = "sulfur", amount = 1, probability = 0.5},
      {type = "item", name = "bm-slag", amount = 1, probability = 0.2}
    }
  },
  {
    type = "recipe",
    name = "bm-steel-mix",
    icon = "__biological-machines-industry__/graphics/steel-mix.png",
    category = "crushing",
    subgroup = "bm-powder",
    order = "b-a",
    --auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "iron-ore", amount = 5},
      {type = "item", name = "carbon", amount = 1}
    },
    results = {
      {type = "item", name = "bm-steel-mix", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "bm-piston",
    icon = "__biological-machines-industry__/graphics/piston.png",
    category = "crafting",
    subgroup = "intermediate-product",
    allow_productivity = true,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "pipe", amount = 2},
      {type = "item", name = "iron-stick", amount = 2},
      {type = "item", name = "iron-plate", amount = 1}
    },
    results = {{type = "item", name = "bm-piston", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-casting-piston",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/piston.png",
        scale = 0.4,
        shift = {-2, 2},
      },
      {
        icon = "__space-age__/graphics/icons/fluid/molten-iron.png",
        scale = 0.3,
        shift = {4, -4},
      },
    },
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "b[casting]-e[casting-iron-stick]-a",
    enabled = false,
    allow_productivity = true,
    energy_required = 4,
    allow_decomposition = false,
    ingredients = {
      {type = "item", name = "pipe", amount = 2},
      {type = "fluid", name = "molten-iron", amount = 20, fluidbox_multiplier = 10},
    },
    results = {{type = "item", name = "bm-piston", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-molten-steel-from-lava",
    icon = "__biological-machines-industry__/graphics/molten-steel-from-lava.png",
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "a[melting]-a[lava-b]-a",
    auto_recycle = false,
    enabled = false,
    ingredients = {
      {type = "fluid", name = "lava", amount = 500},
      {type = "item", name = "carbon", amount = 10},
      {type = "item", name = "calcite", amount = 1},
    },
    energy_required = 16,
    results = {
      {type = "fluid", name = "bm-molten-steel", amount = 250},
      {type = "item", name = "stone", amount = 10},
      {type = "item", name = "copper-ore", amount = 3},
    },
    allow_productivity = true
  },
  {
    type = "recipe",
    name = "bm-steel-mix-melting",
    icons = {
      {
        icon = "__base__/graphics/icons/iron-ore.png",
        scale = 0.25,
        shift = {-8, -8},
        draw_background = true,
      },
      {
        icon = "__space-age__/graphics/icons/calcite.png",
        scale = 0.25,
        shift = {8, -8},
        draw_background = true,
      },
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.25,
        shift = {0, -8},
        draw_background = true,
      },
      {
        icon = "__biological-machines-industry__/graphics/molten-steel.png",
        draw_background = true,
      },
    },
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "a[melting]-c[molten-copper]-a",
    auto_recycle = false,
    show_amount_in_title = false,
    always_show_products = true,
    enabled = false,
    ingredients = {
      {type = "item", name = "bm-steel-mix", amount = 10},
      {type = "item", name = "calcite", amount = 1},
    },
    energy_required = 32,
    results = {
      {type = "fluid", name = "bm-molten-steel", amount = 500},
      {type = "item", name = "bm-slag", amount = 1, probability = 0.5}
    },
    allow_productivity = true,
    hide_from_signal_gui = false,
    main_product =  "bm-molten-steel",
  },

  ---------------------------------------------------------STONE
  --[[
  {
    type = "recipe",
    name = "volcanic-stone-crushing",
    icon = "__biological-machines-industry__/graphics/stone-crushing.png",
    category = "crushing",
    subgroup = "powder",
    order = "c-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    surface_conditions = {{property = "rock", min = 0, max = 0}},
    ingredients = {{type = "item", name = "stone", amount = 20}},
    results = {
      {type = "item", name = "sand", amount = 15},
      {type = "item", name = "stone", amount = 5}
    }
  },
  ]]
  {
    type = "recipe",
    --name = "sedimentary-stone-crushing",
    name = "bm-stone-crushing",
    icon = "__biological-machines-industry__/graphics/stone-crushing.png",
    category = "crushing",
    subgroup = "bm-powder",
    order = "c-a",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    --surface_conditions = {{property = "rock", min = 1, max = 1}},
    ingredients = {{type = "item", name = "stone", amount = 20}},
    results = {
      {type = "item", name = "bm-sand", amount = 14},
      {type = "item", name = "calcite", amount = 1},
      {type = "item", name = "stone", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "bm-lime",
    icon = "__biological-machines-industry__/graphics/lime.png",
    category = "smelting",
    subgroup = "bm-powder",
    order = "a-c",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 3.2,
    ingredients = {{type = "item", name = "calcite", amount = 1}},
    results = {{type = "item", name = "bm-lime", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-cement-mix",
    icon = "__biological-machines-industry__/graphics/cement-mix.png",
    category = "crushing",
    subgroup = "bm-powder",
    order = "b-b",
    enabled = false,
    allow_productivity = true,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "iron-ore", amount = 1},
      {type = "item", name = "bm-lime", amount = 1},
      {type = "item", name = "bm-sand", amount = 2}
    },
    results = {{type = "item", name = "bm-cement-mix", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-glass-mix",
    icon = "__biological-machines-industry__/graphics/glass-mix.png",
    category = "crafting",
    subgroup = "bm-powder",
    order = "b-c",
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "bm-sand", amount = 5},
      {type = "item", name = "bm-lime", amount = 1},
      {type = "item", name = "bm-potash", amount = 2}
    },
    results = {{type = "item", name = "bm-glass-mix", amount = 5}}
  },
  {
    type = "recipe",
    name = "bm-glass-plate",
    icon = "__biological-machines-core__/graphics/glass-plate.png",
    category = "smelting",
    subgroup = "raw-material",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 3.2,
    ingredients = {{type = "item", name = "bm-glass-mix", amount = 1}},
    results = {{type = "item", name = "bm-glass-plate", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-molten-glass",
    icon = "__biological-machines-core__/graphics/molten-glass.png",
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "a[melting]-d[molten-glass]",
    auto_recycle = false,
    enabled = false,
    ingredients = {{type = "item", name = "bm-glass-mix", amount = 50}},
    energy_required = 32,
    results = {{type = "fluid", name = "bm-molten-glass", amount = 500}},
    allow_productivity = true,
    hide_from_signal_gui = false,
    main_product =  "bm-molten-glass"
  },
  {
    type = "recipe",
    name = "bm-sand-from-lava",
    icons = {
      {
        icon = "__biological-machines-k2-assets__/graphics/sand.png"
      },
      {
        icon = "__space-age__/graphics/icons/fluid/lava.png",
        scale = 0.25,
        shift = {-8, -8},
        draw_background = true,
      },
    },
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "b[casting]-z-a",
    auto_recycle = false,
    enabled = false,
    ingredients = {
      {type = "fluid", name = "lava", amount = 500}
    },
    energy_required = 32,
    results = {
      {type = "item", name = "bm-sand", amount = 25},
      {type = "item", name = "iron-ore", amount = 6},
      {type = "item", name = "copper-ore", amount = 3}
    },
    allow_productivity = true,
    hide_from_signal_gui = false,
  },
  {
    type = "recipe",
    name = "bm-stone-brick-from-lava",
    icons = {
      {
        icon = "__base__/graphics/icons/stone-brick.png"
      },
      {
        icon = "__space-age__/graphics/icons/fluid/lava.png",
        scale = 0.25,
        shift = {-8, -8},
        draw_background = true,
      },
    },
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "b[casting]-z-b",
    auto_recycle = false,
    enabled = false,
    ingredients = {
      {type = "fluid", name = "lava", amount = 100},
      {type = "item", name = "bm-sand", amount = 10}
    },
    energy_required = 10,
    results = {{type = "item", name = "stone-brick", amount = 10}},
    allow_productivity = true,
    hide_from_signal_gui = false,
  },
  {
    type = "recipe",
    name = "bm-landfill-with-wood",
    icons = {
      {
        icon = "__base__/graphics/icons/landfill.png"
      },
      {
        icon = "__base__/graphics/icons/wood.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "crafting",
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]-a",
    auto_recycle = false,
    enabled = false,
    --allow_decomposition = false
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "stone", amount = 50},
      {type = "item", name = "wood", amount = 100}
    },
    results = {{type = "item", name = "landfill", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-landfill-with-spoilage",
    icons = {
      {
        icon = "__base__/graphics/icons/landfill.png"
      },
      {
        icon = "__space-age__/graphics/icons/spoilage.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "crafting",
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]-b",
    auto_recycle = false,
    enabled = false,
    --allow_decomposition = false
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "stone", amount = 50},
      {type = "item", name = "spoilage", amount = 200}
    },
    results = {{type = "item", name = "landfill", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-landfill-from-sand",
    icons = {
      {
        icon = "__base__/graphics/icons/landfill.png"
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/sand.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "crafting",
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]-c",
    auto_recycle = false,
    enabled = false,
    --allow_decomposition = false
    energy_required = 0.5,
    ingredients = {{type = "item", name = "bm-sand", amount = 200}},
    results = {{type = "item", name = "landfill", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-fertile-soil",
    icons = {{
      icon = "__base__/graphics/icons/landfill.png",
      tint = {0.45, 0.25, 0}
    }},
    category = "crafting",
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]-z",
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "landfill", amount = 1},
      {type = "item", name = "spoilage", amount = 100},
      {type = "item", name = "bm-potash", amount = 5},
      {type = "item", name = "raw-fish", amount = 5}
    },
    results = {{type = "item", name = "bm-fertile-soil", amount = 5}}
  },

  ---------------------------------------------------------ELECTRONICS
  {
    type = "recipe",
    name = "bm-resin",
    icon = "__biological-machines-industry__/graphics/resin.png",
    category = "crafting",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {{type = "item", name = "wood", amount = 2}},
    results = {{type = "item", name = "bm-resin", amount = 2}},
    main_product = "bm-resin"
  },
  {
    type = "recipe",
    name = "bm-circuit-board-with-resin",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/circuit-board.png"
      },
      {
        icon = "__biological-machines-industry__/graphics/resin.png",
        scale = 0.25,
        shift = {-8, 8},
        draw_background = true,
      },
      {
        icon = "__base__/graphics/icons/stone-brick.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "crafting",
    subgroup = "nauvis-agriculture",
    order = "b-d",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "stone-brick", amount = 1},
      {type = "item", name = "bm-resin", amount = 2}
    },
    results = {{type = "item", name = "bm-circuit-board", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-circuit-board",
    --[[
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/circuit-board.png"
      },
      {
        icon = "__base__/graphics/icons/plastic-bar.png",
        scale = 0.25,
        shift = {8, 8}
      },
    },
    ]]
    category = "electronics",
    subgroup = "raw-material",
    order = "a-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "bm-glass-plate", amount = 1},
      {type = "item", name = "plastic-bar", amount = 1}
    },
    results = {{type = "item", name = "bm-circuit-board", amount = 4}}
  },
  {
    type = "recipe",
    name = "bm-circuit-board-with-jelly",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/circuit-board.png"
      },
      {
        icon = "__space-age__/graphics/icons/jelly.png",
        scale = 0.25,
        shift = {-8, 8},
        draw_background = true,
      },
      {
        icon = "__base__/graphics/icons/stone-brick.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "crafting",
    subgroup = "agriculture-products",
    order = "a[organic-products]-b[biolubricant]-a",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "stone-brick", amount = 1},
      {type = "item", name = "jelly", amount = 2}
    },
    results = {{type = "item", name = "bm-circuit-board", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-circuit-board-with-tar",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/circuit-board.png"
      },
      {
        icon = "__biological-machines-industry__/graphics/tar.png",
        scale = 0.25,
        shift = {-8, 8},
        draw_background = true,
      },
      {
        icon = "__base__/graphics/icons/stone-brick.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "crafting",
    subgroup = "vulcanus-processes",
    order = "b[casting]-z-c",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 0.5,
    surface_conditions = {{property = "pressure", min = 4000, max = 4000}},
    ingredients = {
      {type = "item", name = "stone-brick", amount = 1},
      {type = "item", name = "bm-tar", amount = 2}
    },
    results = {{type = "item", name = "bm-circuit-board", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-circuit-board-with-carbon-fiber",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/circuit-board.png"
      },
      {
        icon = "__space-age__/graphics/icons/jelly.png",
        scale = 0.25,
        shift = {-8, 8},
        draw_background = true,
      },
      {
        icon = "__space-age__/graphics/icons/carbon-fiber.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "organic",
    subgroup = "agriculture-products",
    order = "a[organic-products]-b[biolubricant]-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "carbon-fiber", amount = 1},
      {type = "item", name = "plastic-bar", amount = 1},
      {type = "item", name = "jelly", amount = 1},
    },
    results = {{type = "item", name = "bm-circuit-board", amount = 4}}
  },
  {
    type = "recipe",
    name = "bm-lightbulb",
    icon = "__biological-machines-industry__/graphics/lightbulb.png",
    category = "crafting",
    subgroup = "intermediate-product",
    enabled = false,
    allow_productivity = true,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-glass-plate", amount = 2},
      {type = "item", name = "copper-cable", amount = 2},
      {type = "item", name = "iron-plate", amount = 1}
    },
    results = {
      {type = "item", name = "bm-lightbulb", amount = 2}
    },
  },

  ---------------------------------------------------------OIL
  {
    type = "recipe",
    name = "bm-sulfur-from-crude-oil",
    icons = {
      {
        icon = "__base__/graphics/icons/sulfur.png"
      },
      {
        icon = "__base__/graphics/icons/fluid/crude-oil.png",
        scale = 0.25,
        shift = {8, -8},
        draw_background = true,
      },
    },
    icon = "__biological-machines-industry__/graphics/sulfur-from-crude-oil.png",
    category = "chemistry",
    energy_required = 2,
    enabled = false,
    auto_recycle = false,
    ingredients = {
      {type = "fluid", name = "water", amount = 30},
      {type = "fluid", name = "crude-oil", amount = 30}
    },
    results = {
      {type = "item", name = "sulfur", amount = 1}
    },
    allow_productivity = true,
    crafting_machine_tint =
    {
      primary = {r = 1.000, g = 0.995, b = 0.089, a = 1.000}, -- #fffd16ff
      secondary = {r = 1.000, g = 0.974, b = 0.691, a = 1.000}, -- #fff8b0ff
      tertiary = {r = 0.723, g = 0.638, b = 0.714, a = 1.000}, -- #b8a2b6ff
      quaternary = {r = 0.954, g = 1.000, b = 0.350, a = 1.000}, -- #f3ff59ff
    }
  },
  {
    type = "recipe",
    name = "bm-seed-oil-from-yumako",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/seed-oil.png",
        scale = 0.4,
        shift = {0, 3}
      },
      {
        icon = "__space-age__/graphics/icons/yumako-seed.png",
        scale = 0.4,
        shift = {0, -10},
        draw_background = true,
      },
    },
    category = "crafting-with-fluid",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-c",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "yumako-seed", amount = 2}
    },
    results = {
      {type = "fluid", name = "bm-seed-oil", amount = 10},
      {type = "item", name = "spoilage", amount = 2}
    }
  },
  {
    type = "recipe",
    name = "bm-seed-oil-from-jellynut",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/seed-oil.png",
        scale = 0.4,
        shift = {0, 3}
      },
      {
        icon = "__space-age__/graphics/icons/jellynut-seed.png",
        scale = 0.4,
        shift = {0, -10},
        draw_background = true,
      },
    },
    category = "crafting-with-fluid",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-d",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "jellynut-seed", amount = 2}
    },
    results = {
      {type = "fluid", name = "bm-seed-oil", amount = 10},
      {type = "item", name = "spoilage", amount = 2}
    }
  },
  {
    type = "recipe",
    name = "bm-seed-oil-from-trees",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/seed-oil.png",
        scale = 0.35,
        shift = {0, 3}
      },
      {
        icon = "__space-age__/graphics/icons/tree-seed.png",
        scale = 0.4,
        shift = {0, -10},
        draw_background = true,
      },
    },
    category = "crafting-with-fluid",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-e",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "tree-seed", amount = 2}
    },
    results = {
      {type = "fluid", name = "bm-seed-oil", amount = 10},
      {type = "item", name = "spoilage", amount = 2}
    }
  },
  {
    type = "recipe",
    name = "bm-seed-oil-from-berries",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/seed-oil.png",
        scale = 0.45,
        shift = {0, 4}
      },
      {
        icon = "__biological-machines-core__/graphics/berry-seed.png",
        scale = 0.5,
        shift = {0, -10},
        draw_background = true,
      },
    },
    category = "crafting-with-fluid",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-f",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-berry-seed", amount = 20}
    },
    results = {
      {type = "fluid", name = "bm-seed-oil", amount = 10},
      {type = "item", name = "spoilage", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "bm-biodeisel",
    icon = "__biological-machines-industry__/graphics/biodeisel.png",
    category = "oil-processing",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-h",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "bm-seed-oil", amount = 100},
      {type = "fluid", name = "bm-ethanol", amount = 25},
      {type = "item", name = "bm-potash", amount = 5}
    },
    results = {
      {type = "fluid", name = "heavy-oil", amount = 35},
      {type = "fluid", name = "light-oil", amount = 35},
      {type = "item", name = "bm-tar", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "bm-solid-fuel-from-tar",
    icon = "__biological-machines-industry__/graphics/solid-fuel-from-tar.png",
    icons = {
      {
        icon = "__base__/graphics/icons/solid-fuel.png",
      },
      {
        icon = "__biological-machines-industry__/graphics/tar.png",
        scale = 0.25,
        shift = {-8, -8},
        draw_background = true,
      },
    },
    category = "chemistry",
    subgroup = "fluid-recipes",
    order = "b[fluid-chemistry]-e[solid-fuel-from-heavy-oil]-a",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-tar", amount = 1},
      {type = "fluid", name = "petroleum-gas", amount = 6}
    },
    results = {
      {type = "item", name = "solid-fuel", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "bm-lubricant-from-tar",
    --icon = "__biological-machines-industry__/graphics/lubricant-from-tar.png",
    icons = {
      {
        icon = "__base__/graphics/icons/fluid/lubricant.png",
        scale = 0.4,
        shift = {0, 4}
      },
      {
        icon = "__biological-machines-core__/graphics/ethanol.png",
        scale = 0.25,
        shift = {-6, -8},
        draw_background = true,
      },
      {
        icon = "__biological-machines-industry__/graphics/tar.png",
        scale = 0.25,
        shift = {6, -8},
        draw_background = true,
      },
    },
    category = "chemistry",
    subgroup = "fluid-recipes",
    order = "b[fluid-chemistry]-e[solid-fuel-from-heavy-oil]-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "bm-tar", amount = 1},
      {type = "fluid", name = "bm-ethanol", amount = 2}
    },
    results = {{type = "fluid", name = "lubricant", amount = 10}},
    crafting_machine_tint =
    {
      primary = {r = 0.268, g = 0.723, b = 0.223, a = 1.000}, -- #44b838ff
      secondary = {r = 0.432, g = 0.793, b = 0.386, a = 1.000}, -- #6eca62ff
      tertiary = {r = 0.647, g = 0.471, b = 0.396, a = 1.000}, -- #a57865ff
      quaternary = {r = 1.000, g = 0.395, b = 0.127, a = 1.000}, -- #ff6420ff
    }
  },
  --[[
  {
    type = "recipe",
    name = "carbon-from-tar",
    icon = "__biological-machines-industry__/graphics/carbon-from-tar.png",
    category = "chemistry",
    subgroup = "raw-material",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "tar", amount = 2},
      {type = "fluid", name = "sulfuric-acid", amount = 20}
    },
    results = {{type = "item", name = "carbon", amount = 1}}
  }
  ]]
})
