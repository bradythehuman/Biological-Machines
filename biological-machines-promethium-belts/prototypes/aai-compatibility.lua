AAILoaders.make_tier{
  name = "promethium",
  transport_belt = "promethium-transport-belt",
  color = {r = 219, g = 59, b = 205, a = 211},
  fluid = "lubricant",
  fluid_per_minute = "0.3",
  technology = {
    prerequisites = {"promethium-transport-belt", "aai-turbo-loader"},
    unit = util.table.deepcopy(data.raw.technology["promethium-transport-belt"].unit),
  },
  recipe = {
    categories = {"metallurgy"},
    ingredients = {
      {type = "item", name = "aai-turbo-loader", amount = 1},
      {type = "item", name = "promethium-asteroid-chunk", amount = 5},
      {type = "item", name = "quantum-processor", amount = 5},
      {type = "fluid", name = "lubricant", amount = 50},
    },
    energy_required = 4,
  },
  unlubricated_recipe = {
    categories = {"metallurgy"},
    ingredients = {
      {type = "item", name = "aai-turbo-loader", amount = 1},
      {type = "item", name = "promethium-asteroid-chunk", amount = 50},
      {type = "item", name = "quantum-processor", amount = 50},
      {type = "fluid", name = "lubricant", amount = 500},
    },
    energy_required = 20,
  },
}

data.raw["item"]["aai-promethium-loader"].weight = 40 * kg

data.raw["loader-1x1"]["aai-turbo-loader"].next_upgrade = "aai-promethium-loader"

data.raw["recipe"]["aai-promethium-loader"].surface_conditions = data.raw["recipe"]["promethium-transport-belt"].surface_conditions

if mods["biological-machines-industry"]
and settings.startup["bm-aai-loader-override"].value then
  local promethium_item = data.raw["item"]["aai-promethium-loader"]
  promethium_item.subgroup = "belt"
  promethium_item.order = "d[loader]-e[promethium-loader]"

  data.raw["recipe"]["aai-promethium-loader"].ingredients = {
    {type = "item", name = "aai-turbo-loader", amount = 1},
    {type = "item", name = "promethium-asteroid-chunk", amount = 5},
    {type = "item", name = "quantum-processor", amount = 5},
    {type = "fluid", name = "lubricant", amount = 50},
  }
end
