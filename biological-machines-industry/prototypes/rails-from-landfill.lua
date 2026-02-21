local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("rail", "stone")

local rail_recipe = data.raw["recipe"]["rail"]
rail_recipe.energy_required = (rail_recipe.energy_required or 0.5) * 50
for _, ingredient in pairs(rail_recipe.ingredients) do
  ingredient.amount = ingredient.amount * 50
end
for _, result in pairs(rail_recipe.results) do
  result.amount = result.amount * 50
end

dh.add_ingredient("rail", "item", "landfill", 1)
