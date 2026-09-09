local dh = require("__biological-machines-core__.data-helper")



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



data.raw.recipe["fish-breeding"].surface_conditions = {
  {property = "pressure", min = 1000, max = 1500}
}


data:extend({
  {
    type = "recipe",
    name = "bm-balack-scrap-recycling",
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png"
      },
      {
        icon = "__biological-machines-planet-balack__/graphics/balack-scrap.png",
        scale = 0.4,
        draw_background = true,
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        draw_background = true,
      }
    },
    categories = {"recycling", "hand-crafting"},
    subgroup = "bm-balack-processes",
    order = "a-a",
    enabled = false,
    auto_recycle = false,
    energy_required = 0.2,
    ingredients = {{type = "item", name = "bm-balack-scrap", amount = 1}},
    results = {
      {type = "item", name = "iron-gear-wheel", amount = 1, shared_probability = {min = 0, max = 0.12}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "steel-plate", amount = 1, shared_probability = {min = 0.12, max = 0.14}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "engine-unit", amount = 1, shared_probability = {min = 0.14, max = 0.20}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "copper-cable", amount = 1, shared_probability = {min = 0.20, max = 0.23}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "processing-unit", amount = 1, shared_probability = {min = 0.23, max = 0.25}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "small-lamp", amount = 1, shared_probability = {min = 0.25, max = 0.26}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "low-density-structure", amount = 1, shared_probability = {min = 0.26, max = 0.28}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "stone", amount = 1, shared_probability = {min = 0.28, max = 0.29}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "refined-concrete", amount = 1, shared_probability = {min = 0.29, max = 0.34}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "coal", amount = 1, shared_probability = {min = 0.34, max = 0.35}, show_details_in_recipe_tooltip = false},
      {type = "item", name = "explosive-uranium-cannon-shell", amount = 1, shared_probability = {min = 0.35, max = 0.36}, show_details_in_recipe_tooltip = false},
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
    categories = {"chemistry"},
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
    categories = {"bm-bio-cube", "organic", "hand-crafting"},
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
    categories = {"bm-bio-cube"},
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
    categories = {"bm-bio-cube"},
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
      --{type = "item", name = "quality-module-3", amount = 1},
      {type = "item", name = "quantum-processor", amount = 5},
      {type = "item", name = "raw-fish", amount = 1},
    },
    results = {{type = "item", name = "bm-ai-control-unit", amount = 1}},
  },
  {
    type = "recipe",
    name = "bm-ai-control-unit-active",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-light.png",
    categories = {"organic"},
    subgroup = "bm-balack-processes",
    order = "d",
    enabled = false,
    allow_productivity = false,
    allow_quality = false,
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
    categories = {"bm-bio-cube"},
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
    categories = {"organic"},
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
    name = "bm-bioflux-from-ooze",
    icons = {
      {
        icon = "__biological-machines-planet-balack__/graphics/bio-cube-ooze.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__space-age__/graphics/icons/bioflux.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    categories = {"organic"},
    subgroup = "bm-balack-processes",
    order = "c-c",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 6,
    ingredients = {
      {type = "item", name = "solid-fuel", amount = 3},
      {type = "item", name = "bm-bio-cube-ooze", amount = 6}
    },
    results = {{type = "item", name = "bioflux", amount = 4}},
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
    results = {{type = "item", name = "bm-hypersonic-rounds-magazine", amount = 10}},
  },
})
