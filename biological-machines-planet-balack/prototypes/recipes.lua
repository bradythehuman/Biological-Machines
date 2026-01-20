--[[
-add previous tier of armor to recipes for power armor mk1/mk2. add flying robot framges to mech armor recipe
-greasy sludge (chemistry)-> crude  oil, water, spoilage
-scarp (recycling)-> engine unit, lds, t1 speed module, refined concrete, stone, coal, carbon, sulfur
-t3 efficiency module recipe uses pentapod eggs instead of spoilage
-ai control unit <-(biocube) quantum processor, t3 speed, t3 efficiency, t3 prod, t3 quality, fish
  -uses radioactive tissue instead of fish if mod section is installed
-radiation sheilding <-(biocube) tungsten plate, carbon fiber, promethium chunk
-hyperspace drive <-(biocube) ai control unit, radiation sheilding, supercapacitor, beacon
-hyperspace power cell <-(biocube) ai control unit, radiation sheilding, superconductor, u-235
-mech armor mk2 <-(biocube) ai control unit, radiation sheilding, mech armor
]]

--replace coal with carbon in scrap recycling if bm industry installed. or increase coal?



data.raw["recipe"]["bm-warp-drive"].ingredients = {
  {type = "item", name = "bm-warp-drive-part", amount = 20}
}
--subgroup = "bm-balack-processes"

local warp_cell = data.raw["recipe"]["bm-warp-power-cell"]
warp_cell.category = "bm-bio-cube"
warp_cell.subgroup = "bm-balack-processes"
warp_cell.energy_required = 120
warp_cell.ingredients = {
  {type = "item", name = "bm-ai-control-unit-active", amount = 1},
  {type = "item", name = "bm-radiation-sheilding", amount = 10},
  {type = "item", name = "superconductor", amount = 5},
  {type = "item", name = "lithium-plate", amount = 5},
}

data.raw.recipe["fish-breeding"].surface_conditions = {
  {property = "pressure", min = 1000, max = 1500}
}


data:extend({
  {
    type = "recipe",
    name = "bm-balack-scrap-recycling",
    icons = {
      {
        icon = "__quality__/graphics/icons/recycling.png"
      },
      {
        icon = "__biological-machines-planet-balack__/graphics/balack-scrap.png",
        scale = 0.4
      },
      {
        icon = "__quality__/graphics/icons/recycling-top.png"
      }
    },
    category = "recycling-or-hand-crafting",
    subgroup = "bm-balack-processes",
    order = "a-a",
    enabled = false,
    auto_recycle = false,
    energy_required = 0.2,
    ingredients = {{type = "item", name = "bm-balack-scrap", amount = 1}},
    results = {
      {type = "item", name = "iron-gear-wheel", amount = 1, probability = 0.12, show_details_in_recipe_tooltip = false},
      {type = "item", name = "steel-plate", amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false},
      {type = "item", name = "engine-unit", amount = 1, probability = 0.06, show_details_in_recipe_tooltip = false},
      {type = "item", name = "copper-cable", amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false},
      {type = "item", name = "processing-unit", amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false},
      {type = "item", name = "small-lamp", amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false},
      {type = "item", name = "low-density-structure", amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false},
      {type = "item", name = "stone", amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false},
      {type = "item", name = "refined-concrete", amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false},
      {type = "item", name = "coal", amount = 1, probability = 0.1, show_details_in_recipe_tooltip = false},
      {type = "item", name = "explosive-uranium-cannon-shell", amount = 1, probability = 0.1, show_details_in_recipe_tooltip = false},
    }
  },
  {
    type = "recipe",
    name = "bm-oil-sludge-seperation",
    icons = {
      {
        icon = "__biological-machines-k2-assets__/graphics/oil-sludge.png",
        scale = 0.3,
        shift = {0, -6},
      },
      {
        icon = "__base__/graphics/icons/fluid/crude-oil.png",
        scale = 0.25,
        shift = {-8, 8},
        draw_background = true,
      },
      {
        icon = "__base__/graphics/icons/fluid/water.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    category = "chemistry",
    subgroup = "bm-balack-processes",
    order = "b",
    enabled = false,
    allow_productivity = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = {{type = "fluid", name = "bm-oil-sludge", amount = 50}},
    results = {
      {type = "fluid", name = "crude-oil", amount = 25},
      {type = "fluid", name = "water", amount = 25},
      {type = "item", name = "spoilage", amount = 10},
    }
  },
  {
    type = "recipe",
    name = "bm-bio-cube",
    icon = "__biological-machines-planet-balack__/graphics/bio_cube/pathogen-lab-icon.png",
    category = "organic-or-hand-crafting",
    subgroup = "bm-balack-processes",
    enabled = false,
    allow_productivity = false,
    allow_decomposition = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "bm-balack-scrap", amount = 100},
      {type = "item", name = "biochamber", amount = 2},
      {type = "item", name = "assembling-machine-3", amount = 2},
    },
    results = {{type = "item", name = "bm-bio-cube", amount = 1}},
  },
  {
    type = "recipe",
    name = "bm-radiation-sheilding",
    icon = "__biological-machines-k2-assets__/graphics/radiation-sheilding.png",
    category = "bm-bio-cube",
    subgroup = "bm-balack-processes",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "tungsten-carbide", amount = 5},
      {type = "item", name = "carbon-fiber", amount = 10},
      {type = "item", name = "low-density-structure", amount = 1},
      {type = "item", name = "promethium-asteroid-chunk", amount = 1},
      {type = "item", name = "bioflux", amount = 5},
      {type = "fluid", name = "heavy-oil", amount = 10},
    },
    results = {{type = "item", name = "bm-radiation-sheilding", amount = 5}},
  },
  {
    type = "recipe",
    name = "bm-ai-control-unit",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-dark.png",
    category = "bm-bio-cube",
    subgroup = "bm-balack-processes",
    order = "d",
    enabled = false,
    allow_productivity = false,
    allow_decomposition = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "speed-module-3", amount = 1},
      {type = "item", name = "efficiency-module-3", amount = 1},
      {type = "item", name = "productivity-module-3", amount = 1},
      {type = "item", name = "quality-module-3", amount = 1},
      {type = "item", name = "quantum-processor", amount = 5},
      {type = "item", name = "raw-fish", amount = 1},
    },
    results = {{type = "item", name = "bm-ai-control-unit", amount = 1}},
  },
  {
    type = "recipe",
    name = "bm-ai-control-unit-active",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-light.png",
    category = "organic",
    subgroup = "bm-balack-processes",
    order = "d",
    enabled = false,
    allow_productivity = false,
    maximum_productivity = 0,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "bm-ai-control-unit", amount = 1},
      {type = "item", name = "uranium-235", amount = 1},
    },
    results = {{type = "item", name = "bm-ai-control-unit-active", amount = 1}},
  },
  {
    type = "recipe",
    name = "bm-warp-drive-part",
    icons = {
      {
        icon = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-icon.png",
      },
      {
        icon = "__base__/graphics/icons/iron-gear-wheel.png",
        scale = 0.25,
        shift = {8, -8},
      },
    },
    category = "bm-bio-cube",
    subgroup = "bm-balack-processes",
    enabled = false,
    allow_productivity = false,
    allow_decomposition = false,
    energy_required = 120,
    ingredients = {
      {type = "item", name = "bm-ai-control-unit", amount = 2},
      {type = "item", name = "bm-radiation-sheilding", amount = 25},
      {type = "item", name = "beacon", amount = 1},
      {type = "item", name = "supercapacitor", amount = 10},
      {type = "item", name = "tungsten-plate", amount = 10},
    },
    results = {{type = "item", name = "bm-warp-drive-part", amount = 1}},
  },
  {
    type = "recipe",
    name = "bm-tank-mk2",
    enabled = false,
    allow_productivity = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "tank", amount = 1},
      {type = "item", name = "electric-engine-unit", amount = 50},
      {type = "item", name = "bm-radiation-sheilding", amount = 200},
      {type = "item", name = "superconductor", amount = 100},
      {type = "item", name = "bm-ai-control-unit", amount = 10},
      {type = "item", name = "fusion-reactor-equipment", amount = 2},
    },
    results = {{type = "item", name = "bm-tank-mk2", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-mech-armor-mk2",
    enabled = false,
    allow_productivity = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "mech-armor", amount = 1},
      {type = "item", name = "flying-robot-frame", amount = 50},
      {type = "item", name = "bm-radiation-sheilding", amount = 100},
      {type = "item", name = "supercapacitor", amount = 50},
      {type = "item", name = "bm-ai-control-unit", amount = 25},
      {type = "item", name = "biochamber", amount = 1},
    },
    results = {{type = "item", name = "bm-mech-armor-mk2", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-bio-cube-ooze",
    icon = "__biological-machines-planet-balack__/graphics/bio-cube-ooze.png",
    category = "bm-bio-cube",
    subgroup = "bm-balack-processes",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "bioflux", amount = 50},
      {type = "fluid", name = "heavy-oil", amount = 100},
    },
    results = {{type = "item", name = "bm-bio-cube-ooze", amount = 100}},
  },
  {
    type = "recipe",
    name = "bm-radiation-sheilding-from-ooze",
    icons = {
      {
        icon = "__biological-machines-planet-balack__/graphics/bio-cube-ooze.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/radiation-sheilding.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    category = "organic",
    subgroup = "bm-balack-processes",
    order = "c-c",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "tungsten-carbide", amount = 5},
      {type = "item", name = "carbon-fiber", amount = 10},
      {type = "item", name = "low-density-structure", amount = 1},
      {type = "item", name = "promethium-asteroid-chunk", amount = 1},
      {type = "item", name = "bm-bio-cube-ooze", amount = 10}
    },
    results = {{type = "item", name = "bm-radiation-sheilding", amount = 5}},
  },
  {
    type = "recipe",
    name = "bm-hypersonic-rounds-magazine",
    enabled = false,
    energy_required = 10,
    ingredients = {
      {type = "item", name = "bm-radiation-sheilding", amount = 2},
      {type = "item", name = "explosives", amount = 2},
      {type = "item", name = "uranium-235", amount = 1},
      {type = "item", name = "tungsten-plate", amount = 1},
    },
    results = {{type = "item", name = "bm-hypersonic-rounds-magazine", amount = 1}},
  },
})
