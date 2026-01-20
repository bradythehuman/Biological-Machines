local slurry = {type = "unlock-recipe", recipe = "bm-nutrient-slurry"}
table.insert(data.raw["technology"]["bioflux-processing"].effects, slurry)



data:extend({
  {
    type = "technology",
    name = "bm-food-processing",
    icon = "__biological-machines-hunger__/graphics/closed-can.png",
    icon_size = 64,
    prerequisites = {"automation-2", "agriculture"},

    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 15
    },

    effects = {
      {type = "unlock-recipe", recipe = "bm-berry-paste"},
      --{type = "unlock-recipe", recipe = "dehydrated-nutrients"},
      {type = "unlock-recipe", recipe = "bm-nutrient-paste"},
      {type = "unlock-recipe", recipe = "bm-empty-can"},
      {type = "unlock-recipe", recipe = "bm-canned-fish"}
    }
  },
  --[[
  {
    type = "technology",
    name = "nutrient-slurry",
    icon = "__biological-machines-hunger__/graphics/nutrient-slurry.png",
    icon_size = 64,
    prerequisites = {"agricultural-science-pack", "food-processing"},
    unit = {
      count = 500,
      ingredients = {
        {"automation-science-pack",   1},
        {"logistic-science-pack",     1},
        {"chemical-science-pack",     1},
        {"space-science-pack",        1},
        {"agricultural-science-pack", 1}
      },
      time = 60
    },
    effects = {{type = "unlock-recipe", recipe = "nutrient-slurry"}}
  },
  ]]
  {
    type = "technology",
    name = "bm-fluroflux",
    icon = "__biological-machines-hunger__/graphics/fluroflux-research.png",
    icon_size = 256,
    prerequisites = {"agricultural-science-pack"},
    unit = {
      count = 2000,
      ingredients = {
        {"automation-science-pack",   1},
        {"logistic-science-pack",     1},
        {"chemical-science-pack",     1},
        {"space-science-pack",        1},
        {"agricultural-science-pack", 1}
      },
      time = 60
    },
    effects = {
      {type = "unlock-recipe", recipe = "bm-fluroflux"},
      {type = "unlock-recipe", recipe = "bm-nutrients-from-fluroflux"},
      {type = "unlock-recipe", recipe = "bm-medkit"},
      {type = "unlock-recipe", recipe = "bm-stims"},
      {type = "unlock-recipe", recipe = "bm-fortified-nutrient-slurry"}
    }
  },
  {
    type = "technology",
    name = "bm-biological-recycler",
    icon = "__biological-machines-hunger__/graphics/biological-recycler.png",
    icon_size = 128,
    effects = {{type = "unlock-recipe", recipe = "bm-biological-recycler"}},
    prerequisites = {"electromagnetic-science-pack", "utility-science-pack"},
    unit =
    {
      count = 2000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"electromagnetic-science-pack", 1}
      },
      time = 60
    }
  },
  {
    type = "technology",
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
    icon_size = defines.default_icon_size,
    prerequisites = {"bm-food-processing", "planet-discovery-vulcanus"},

    research_trigger = {type = "mine-entity", entity = "small-demolisher-corpse"},

    effects = {{type = "unlock-recipe", recipe = "bm-demolisher-meat-barrel"}}
  },
  {
    type = "technology",
    name = "bm-artificial-organs",
    icon = "__biological-machines-core__/graphics/artificial-organs.png",
    icon_size = 256,
    effects = {{type = "unlock-recipe", recipe = "bm-artificial-organs"}},
    prerequisites = {"biter-egg-handling", "bm-biological-recycler", "metallurgic-science-pack", "efficiency-module-2"},

    unit = {
      count = 5000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"military-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"metallurgic-science-pack", 1}
      },
      time = 60
    }
  },
})
