local adjusted_surface_conditions = {{property = "pressure", min = 0, max = 0}}
if settings.startup["promethium-belt-surface-vulcanus"].value then
  adjusted_surface_conditions = {{property = "pressure", min = 4000, max = 4000}}
end



data:extend
{
    {
    type = "recipe",
    name = "promethium-transport-belt",
    energy_required = 2,
    categories = {"metallurgy"},
    surface_conditions = adjusted_surface_conditions,
    enabled = false,
    auto_recycle = true,
    ingredients = {
      {type = "item", name = "promethium-asteroid-chunk", amount = 1},
      {type = "item", name = "turbo-transport-belt", amount = 1},
      {type = "fluid", name = "lubricant", amount = 20}
    },
    results = {{type = "item", name = "promethium-transport-belt", amount = 1}}
  },
  {
    type = "recipe",
    name = "promethium-underground-belt",
    energy_required = 4,
    categories = {"metallurgy"},
    surface_conditions = adjusted_surface_conditions,
    enabled = false,
    auto_recycle = true,
    ingredients = {
      {type = "item", name = "promethium-asteroid-chunk", amount = 8},
      {type = "item", name = "turbo-underground-belt", amount = 2},
      {type = "fluid", name = "lubricant", amount = 40}
    },
    results = {{type = "item", name = "promethium-underground-belt", amount = 2}}
  },
  {
    type = "recipe",
    name = "promethium-splitter",
    categories = {"metallurgy"},
    surface_conditions = adjusted_surface_conditions,
    enabled = false,
    energy_required = 4,
    auto_recycle = true,
    ingredients = {
      {type = "item", name = "promethium-asteroid-chunk", amount = 3},
      {type = "item", name = "turbo-splitter", amount = 1},
      {type = "item", name = "quantum-processor", amount = 2},
      {type = "fluid", name = "lubricant", amount = 80}
    },
    results = {{type = "item", name = "promethium-splitter", amount = 1}}
  },
  {
    type = "recipe",
    name = "promethium-loader",
    enabled = false,
    hidden = true,
    energy_required = 20,
    auto_recycle = true,
    ingredients =
    {
      {type = "item", name = "promethium-transport-belt", amount = 5},
      {type = "item", name = "turbo-loader", amount = 1},
    },
    results = {{type = "item", name = "promethium-loader", amount = 1}}
  },
}
