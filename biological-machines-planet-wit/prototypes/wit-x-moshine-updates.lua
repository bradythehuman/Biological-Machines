--TRAINED AI CONTROL MODULE
if mods["biological-machines-planet-balack"] then
  local trained_recipe = data.raw.recipe["bm-ai-control-unit-trained"]
  trained_recipe.categories = {"data-processing"}
  trained_recipe.energy_required = 1000
  trained_recipe.ingredients = {
    {type = "item", name = "bm-ai-control-unit", amount = 1},
    {type = "fluid", name = "raw-data", amount = 100},
  }
  trained_recipe.results = {
    {type = "item", name = "bm-ai-control-unit-trained", amount = 1},
  }
end
