data:extend({
  {
    type = "recipe",
    name = "bm-berry-paste",
    icon = "__biological-machines-hunger__/graphics/berry-paste.png",
    category = "crafting-with-fluid",
    subgroup = "bm-processed-food",
    order = "b",
    enabled = false,
    allow_productivity = true,
    auto_recycle = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-berry", amount = 5},
      {type = "fluid", name = "steam", amount = 10}
    },
    results = {
      {type = "item", name = "bm-berry-paste", amount = 1},
      --{type = "item", name = "bm-berry-seed", amount = 1}
    },
    --main_product = "bm-berry-paste"
  },
  --[[
  {
    type = "recipe",
    name = "dehydrated-nutrients",
    icon = "__biological-machines-hunger__/graphics/dehydrated-nutrients.png",
    category = "smelting",
    enabled = false,
    allow_productivity = true,
    auto_recycle = false,
    energy_required = 2,
    ingredients = {{type = "item", name = "nutrients", amount = 1}},
    results = {{type = "item", name = "dehydrated-nutrients", amount = 1}}
  },
  ]]
  {
    type = "recipe",
    name = "bm-nutrient-paste",
    icon = "__biological-machines-hunger__/graphics/nutrient-paste.png",
    category = "organic-or-assembling",
    enabled = false,
    allow_productivity = true,
    auto_recycle = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "nutrients", amount = 5},
      {type = "fluid", name = "steam", amount = 10}
    },
    results = {{type = "item", name = "bm-nutrient-paste", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-empty-can",
    icon = "__biological-machines-hunger__/graphics/empty-can.png",
    category = "crafting",
    enabled = false,
    allow_productivity = true,
    energy_required = 0.2,
    ingredients = {{type = "item", name = "steel-plate", amount = 1}},
    results = {{type = "item", name = "bm-empty-can", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-canned-fish",
    icon = "__biological-machines-hunger__/graphics/closed-can.png",
    category = "crafting-with-fluid",
    enabled = false,
    allow_productivity = false,
    energy_required = 2,
    ingredients = {
      {type = "fluid", name = "steam", amount = 10},
      {type = "item", name = "bm-empty-can", amount = 1},
      {type = "item", name = "raw-fish", amount = 1}
    },
    results = {{type = "item", name = "bm-canned-fish", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-nutrient-slurry",
    icon = "__biological-machines-hunger__/graphics/nutrient-slurry.png",
    category = "organic",
    enabled = false,
    allow_productivity = false, --does biochamber 50% still apply? i want it to
    energy_required = 2,
    ingredients = {
      {type = "fluid", name = "steam", amount = 20},
      {type = "item", name = "plastic-bar", amount = 1},
      {type = "item", name = "bioflux", amount = 1},
      {type = "item", name = "nutrients", amount = 20}
    },
    results = {{type = "item", name = "bm-nutrient-slurry", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-fluroflux",
    icon = "__biological-machines-hunger__/graphics/fluroflux.png",
    category = "organic",
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "bioflux", amount = 2},
      {type = "item", name = "bm-stingfrond", amount = 1}
    },
    results = {{type = "item", name = "bm-fluroflux", amount = 1}},
    crafting_machine_tint = {
      primary = {r = 0.000, g = 0.457, b = 1.000, a = 1.000}, -- #ff7400ff
      secondary = {r = 0.000, g = 0.196, b = 1.000, a = 1.000}, -- #ff3100ff
    }
  },
  {
    type = "recipe",
    name = "bm-nutrients-from-fluroflux",
    icons = {
      {
        icon = "__biological-machines-hunger__/graphics/fluroflux.png",
        --icon_size = 64,
        scale = 0.35,
        shift = {-6, -6},
      },
			{
        icon = "__biological-machines-core__/graphics/nutrients-from-blank.png",
        --icon_size = 64,
      }
		},
    --icon = "__biological-machines-hunger__/graphics/nutrients-from-fluroflux.png",
    category = "organic",
    subgroup = "bm-nutrients",
    order = "c-g",
    enabled = false,
    allow_productivity = true,
    energy_required = 2,
    ingredients = {{type = "item", name = "bm-fluroflux", amount = 2}},
    results = {{type = "item", name = "nutrients", amount = 40}}
  },
  {
    type = "recipe",
    name = "bm-fortified-nutrient-slurry",
    icon = "__biological-machines-hunger__/graphics/fortified-nutrient-slurry.png",
    category = "organic",
    enabled = false,
    allow_productivity = false,
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "steam", amount = 20},
      {type = "item", name = "plastic-bar", amount = 1},
      {type = "item", name = "bm-fluroflux", amount = 1},
      {type = "item", name = "nutrients", amount = 20}
    },
    results = {{type = "item", name = "bm-fortified-nutrient-slurry", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-medkit",
    icon = "__biological-machines-k2-assets__/graphics/medkit.png",
    category = "crafting",
    enabled = false,
    allow_productivity = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "plastic-bar", amount = 1},
      {type = "item", name = "iron-bacteria", amount = 5},
      {type = "item", name = "jelly", amount = 5}
    },
    results = {{type = "item", name = "bm-medkit", amount = 4}}
  },
  {
    type = "recipe",
    name = "bm-stims",
    icon = "__biological-machines-k2-assets__/graphics/stims.png",
    category = "crafting",
    enabled = false,
    allow_productivity = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "plastic-bar", amount = 1},
      {type = "item", name = "bm-stingfrond", amount = 1},
      {type = "item", name = "jelly", amount = 5}
    },
    results = {{type = "item", name = "bm-stims", amount = 4}},
  },
  {
    type = "recipe",
    name = "bm-demolisher-meat-barrel",
    icons = {
      {
        icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
        icon_size = defines.default_icon_size
      },
      {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
        icon_size = defines.default_icon_size,
        tint = util.get_color_with_alpha({0.61, 0.11, 0.54}, 0.75, true)
      },
      {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
        icon_size = defines.default_icon_size,
        tint = util.get_color_with_alpha({0.94, 0.26, 0.91}, 0.75, true)
      }
    },
    category = "crafting-with-fluid",
    enabled = false,
    allow_productivity = false,
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "steam", amount = 25},
      {type = "item", name = "barrel", amount = 1},
      {type = "item", name = "bm-demolisher-meat", amount = 1}
    },
    results = {{type = "item", name = "bm-demolisher-meat-barrel", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-biological-recycler",
    icon = "__biological-machines-hunger__/graphics/biological-recycler.png",
    icon_size = 128,
    category = "crafting",
    enabled = false,
    allow_productivity = false,
    energy_required = 10,
    ingredients = {
      {type = "item", name = "processing-unit", amount = 10},
      {type = "item", name = "plastic-bar", amount = 50},
      {type = "item", name = "steel-plate", amount = 10},
      {type = "item", name = "holmium-plate", amount = 10}
    },
    results = {{type = "item", name = "bm-biological-recycler", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-artificial-organs",
    icon = "__biological-machines-core__/graphics/artificial-organs.png",
    icon_size = 256,
    category = "crafting",
    enabled = false,
    allow_productivity = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "biochamber", amount = 1},
      {type = "item", name = "bm-biological-recycler", amount = 1},
      {type = "item", name = "biter-egg", amount = 5},
      {type = "item", name = "efficiency-module-2", amount = 25},
      {type = "item", name = "tungsten-carbide", amount = 25}
    },
    results = {{type = "item", name = "bm-artificial-organs", amount = 1}}
  },
})
