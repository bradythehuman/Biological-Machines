--assumes that every planet will include a gravity surface condition and an icon (not icons)

local rp_prod = data.raw.technology["rocket-part-productivity"]
rp_prod.effects = {}

local unlock = {
  nauvis = "rocket-silo",
  gleba = "carbon-fiber",
  aquilo = "planet-discovery-aquilo",
  fulgora = "holmium-processing",
  vulcanus = "tungsten-carbide",
  ["bm-wit"] = "bm-planet-discovery-wit",
  ["bm-balack"] = "bm-planet-discovery-balack",
  ["shattered-planet"] = "bm-planet-discovery-shattered-planet",
  ["bm-dyson-sphere"] = "bm-solar-system-discovery-homeworld",
}

local sheilding = {
  nauvis = "steel-plate",
  gleba = "carbon-fiber",
  aquilo = "carbon-fiber",
  fulgora = "holmium-plate",
  vulcanus = "tungsten-carbide",
  ["bm-wit"] = "iron-plate",
  ["bm-balack"] = "steel-plate",
  ["shattered-planet"] = "bm-radiation-sheilding",
  ["bm-dyson-sphere"] = "steel-plate",
}

local rp_order = "c-"
data.raw.item["rocket-part"].order = rp_order

for planet_name, planet in pairs(data.raw["planet"]) do
  local recipe_name = "bm-rocket-part-" .. planet_name
  table.insert(rp_prod.effects, {type = "change-recipe-productivity", recipe = recipe_name, change = 0.1})

  local enable = true
  if unlock[planet_name] then
    table.insert(data.raw.technology[unlock[planet_name]].effects, {type = "unlock-recipe", recipe = recipe_name})
    enable = false
  end

  local gravity = planet.surface_properties.gravity or 10
  local rp_amount = math.max(math.floor(10 / gravity), 1)
  local fuel_amount = math.max(math.floor(gravity / 10), 1)

  local surface_conditions = {}
  for sp_name, sp_value in pairs(planet.surface_properties) do
    table.insert(surface_conditions, {
      property = sp_name,
      min = sp_value,
      max = sp_value
    })
  end

  local icon_size = planet.icon_size or 64

  data:extend({{
    type = "recipe",
    name = recipe_name,
    localised_name = {"item-name.rocket-part"},
    localised_description = {"item-description.rocket-part"},
    icons = {
      {icon = "__base__/graphics/icons/rocket-part.png", icon_size=64},
      {
        icon = planet.icon, icon_size = icon_size,
        scale = (64 / icon_size) * 0.25, shift = {-8, 8}
      }
    },
    category = "advanced-crafting",
    subgroup = "space-rocket",
    order = rp_order .. (planet.order or "zzz"), --in case planet mod doesn't have order
    enabled = enable,
    --hide_from_player_crafting = false,
    allow_productivity = true,
    allow_quality = false,
    surface_conditions = surface_conditions,
    energy_required = 3 * rp_amount,
    ingredients = {
      {type = "item", name = sheilding[planet_name] or "steel-plate", amount = rp_amount},
      {type = "item", name = "processing-unit", amount = rp_amount},
      {type = "item", name = "low-density-structure", amount = rp_amount},
      {type = "item", name = "rocket-fuel", amount = fuel_amount},
    },
    results = {{type = "item", name = "rocket-part", amount = rp_amount}}
  }})
end



local rp_recipe = data.raw.recipe["rocket-part"]
rp_recipe.hide_from_player_crafting = true
rp_recipe.allow_productivity = false
rp_recipe.ingredients = {
  {type = "item", name = "rocket-part", amount = 1}
}

local rp_item = data.raw.item["rocket-part"]
rp_item.hidden = false
rp_item.subgroup = "space-rocket"
rp_item.stack_size = 1
rp_item.weight = 2000 * kg

--data.raw["rocket-silo"]["rocket-silo"].rocket_parts_required = 50

data:extend({
  {
    type = "recipe",
    name = "rocket-part-recycling",
    localised_name = {"recipe-name.recycling", {"item-name.rocket-part"}},
    icons = {
      {
        icon = "__quality__/graphics/icons/recycling.png"
      },
      {
        icon = "__base__/graphics/icons/rocket-part.png",
        scale = 0.5 * 0.8,
      },
      {
        icon = "__quality__/graphics/icons/recycling-top.png"
      },
    },
    subgroup = "space-rocket",
    category = "recycling",
    hidden = true,
    enabled = true,
    unlock_results = false,
    ingredients = {{type = "item", name = "rocket-part", amount = 1, ignored_by_stats = 1}},
    results = {
      {type = "item", name = "low-density-structure", amount = 1, probability = 0.25, ignored_by_stats = 1},
      {type = "item", name = "processing-unit", amount = 1, probability = 0.25, ignored_by_stats = 1},
      --{type = "item", name = "rocket-fuel", amount = 1, probability = 0.25, ignored_by_stats = 1},
    }, -- Will show as consumed when item is destroyed
    energy_required = 1 / 16,
  }
})
