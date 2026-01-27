--TECH
data.raw["technology"]["personal-tesla-defense-equipment"] = nil

data:extend({
  {
    type = "technology",
    name = "personal-tesla-defense-equipment",
    icons = util.technology_icon_constant_equipment("__PersonalTeslaDefenseEquipment__/graphics/tech-icon.png"),
    icon_size = 256,
    effects = {
			{
				type = "unlock-recipe",
				recipe = "personal-tesla-defense-equipment"
			}
		},
    prerequisites = {"speed-module-2", "tesla-weapons", "personal-laser-defense-equipment"},
    unit = {
      count = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"electromagnetic-science-pack", 1}
      },
      time = 60
    }
  },
})

--RECIPE
local tesla_equipment_recipe = data.raw["recipe"]["personal-tesla-defense-equipment"]
tesla_equipment_recipe.category = "bm-advanced-robotics"
tesla_equipment_recipe.ingredients = {
  {type = "item", name = "teslagun", amount = 1},
  {type = "item", name = "low-density-structure", amount = 10},
  {type = "item", name = "speed-module-2", amount = 5},
  {type = "item", name = "electric-engine-unit", amount = 2},
}
tesla_equipment_recipe.enabled = false
tesla_equipment_recipe.energy_required = 30
