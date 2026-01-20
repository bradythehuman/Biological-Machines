--ALL SCIENCE
table.insert(bm_add_all_packs, "bm-solar-system-discovery-homeworld")
table.insert(bm_add_all_packs, "bm-market-productivity")



data:extend({
  {
    type = "technology",
    name = "bm-solar-system-discovery-homeworld",
    icon = "__biological-machines-homeworld__/graphics/dyson-sphere-starmap.png",
    icon_size = 1000,
    essential = true,
    effects = {
      {
        type = "unlock-space-location",
        space_location = "bm-dyson-sphere",
        use_icon_overlay_constant = false
      },
      {
        type = "unlock-recipe",
        recipe = "bm-homeworld-market",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-super-credit",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-interstellar-energy-link",
      },
    },
    prerequisites = {"bm-warp-drive", "bm-cloning"},
    unit = {
      count = 10000,
      time = 120
    }
  },
  {
    type = "technology",
    name = "bm-solar-system-discovery-new",
    icon = "__biological-machines-homeworld__/graphics/new-system-starmap.png",
    icon_size = 512,
    essential = true,
    effects = {
      {
        type = "unlock-space-location",
        space_location = "bm-new-system",
        use_icon_overlay_constant = false
      },
    },
    prerequisites = {"bm-solar-system-discovery-homeworld"},
    research_trigger = {
      type = "build-entity",
      entity = "bm-interstellar-energy-link"
    },
    --[[
    unit = {
      count = 10000,
      time = 120
    }
    ]]
  },
  {
    type = "technology",
    name = "bm-market-productivity",
    icons = util.technology_icon_constant_recipe_productivity("__biological-machines-homeworld__/graphics/credit-productivity.png"),
    icon_size = 256,
    effects = {
      {
        type = "change-recipe-productivity",
        recipe = "bm-super-credit",
        change = 0.1
      },
    },
    prerequisites = {"bm-solar-system-discovery-homeworld"},
    unit = {
      count_formula = "1.1^(L-1)*1000",
      time = 120
    },
    max_level = "infinite",
    upgrade = true,
  }
})
