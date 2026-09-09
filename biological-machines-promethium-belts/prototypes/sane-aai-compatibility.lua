local promethium_recipe = data.raw["recipe"]["aai-promethium-loader"]
promethium_recipe.ingredients = {
    {type = "item", name = "aai-turbo-loader", amount = 1},
    {type = "item", name = "quantum-processor", amount = 1},
    {type = "item", name = "promethium-asteroid-chunk", amount = 4},
    {type = "fluid", name = "lubricant", amount = 40}
}
promethium_recipe.energy_required = 2

table.insert(data.raw["technology"]["promethium-transport-belt"].effects,
  {type = "unlock-recipe", recipe = promethium_recipe.name}
)

data.raw["item"]["aai-promethium-loader"].weight = 1000000/25

data.raw["technology"]["aai-promethium-loader"] = nil
