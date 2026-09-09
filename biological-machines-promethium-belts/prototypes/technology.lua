data:extend(
{
    {
    type = "technology",
    name = "promethium-transport-belt",
    icon = "__biological-machines-promethium-belts__/graphics/technology/promethium-transport-belt.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "promethium-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "promethium-underground-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "promethium-splitter"
      },
    },
    prerequisites = {"promethium-science-pack", "turbo-transport-belt"},
    unit = {
      count = settings.startup["promethium-belt-science-count"].value,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 60
    }
  },
}
)
