data:extend({
  {
    type = "technology",
    name = "bm-cloning",
    icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-technology.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "bm-suspension-tank",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-clone",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-suspension-fluid",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-suspend-clone",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-prepare-tank",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-clone-life-support",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-prepared-tank-maintenance",
      },
    },
    prerequisites = {"quantum-processor", "captive-biter-spawner"},
    unit = {
      count = 5000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"cryogenic-science-pack", 1},
      },
      time = 60,
    },
  },
})
