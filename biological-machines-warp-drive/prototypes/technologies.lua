data:extend({
  {
    type = "technology",
    name = "bm-warp-drive",
    icon = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-icon-big.png",
    icon_size = 640,
    essential = true,
    effects = {
      {type = "unlock-recipe", recipe = "bm-warp-drive"},
      {type = "unlock-recipe", recipe = "bm-warp-power-cell"},
      {type = "unlock-recipe", recipe = "bm-warp"},
    },
    prerequisites = {"promethium-science-pack"},
    unit = {
      count = 5000,
      ingredients = BM_COPY_ALL_SCI_PACKS(),
      time = 120,
    }
  },
  {
    type = "technology",
    name = "bm-warp-power-cell-productivity",
    icons = util.technology_icon_constant_recipe_productivity("__biological-machines-k2-assets__/graphics/warp-power-cell-productivity.png"),
    icon_size = 256,
    effects = {
      {
        type = "change-recipe-productivity",
        recipe = "bm-warp-power-cell",
        change = 0.1
      },
    },
    prerequisites = {"bm-warp-drive"},
    unit = {
      count_formula = "1.3^(L-1)*1000",
      ingredients = BM_COPY_ALL_SCI_PACKS(),
      time = 120
    },
    max_level = "infinite",
    upgrade = true,
  }
})
