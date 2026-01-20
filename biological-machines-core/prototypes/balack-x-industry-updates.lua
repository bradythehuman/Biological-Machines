local dh = require("__biological-machines-core__.data-helper")
--[[
local balack_scrap_add = {
  ["carbon"] = 0.1,
  ["potash"] = 0.05,
}
if settings.startup["bm-boompuff-agriculture"].value then
  balack_scrap_add["jelly"] = 0.01
end

local balack_scrap_results = data.raw["recipe"]["bm-balack-scrap-recycling"].results
for name, probability in pairs(balack_scrap_add) do
  table.insert(balack_scrap_results,
    {type = "item", name = name, amount = 1, probability = probability, show_details_in_recipe_tooltip = false}
  )
end
]]

table.insert(
  data.raw["recipe"]["bm-balack-scrap-recycling"].results,
  {type = "item", name = "carbon", amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false}
)
table.insert(
  data.raw["recipe"]["bm-balack-scrap-recycling"].results,
  {type = "item", name = "bm-potassium-nitrate", amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false}
)



dh.add_recipe_unlock("bm-planet-discovery-balack", "bm-advanced-oil-sludge-seperation")

data:extend({
  {
    type = "recipe",
    name = "bm-advanced-oil-sludge-seperation",
    icons = {
      {
        icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
        scale = 0.25,
        shift = {-5, -8},
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/oil-sludge.png",
        scale = 0.25,
        shift = {5, -8},
        draw_background = true,
      },
      {
        icon = "__base__/graphics/icons/fluid/heavy-oil.png",
        scale = 0.25,
        shift = {-9, 8},
        draw_background = true,
      },
      {
        icon = "__base__/graphics/icons/fluid/light-oil.png",
        scale = 0.25,
        shift = {0, 8},
        draw_background = true,
      },
      {
        icon = "__biological-machines-core__/graphics/ethanol.png",
        scale = 0.25,
        shift = {9, 8},
        draw_background = true,
      },
    },
    category = "cryogenics",
    subgroup = "bm-balack-processes",
    order = "b-a",
    enabled = false,
    allow_productivity = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "bm-oil-sludge", amount = 50},
      {type = "fluid", name = "sulfuric-acid", amount = 2},
    },
    results = {
      {type = "fluid", name = "heavy-oil", amount = 10},
      {type = "fluid", name = "light-oil", amount = 10},
      {type = "fluid", name = "bm-ethanol", amount = 3},
      {type = "item", name = "ice", amount = 1},
      {type = "item", name = "solid-fuel", amount = 1},
    }
  },
})

if settings.startup["bm-boompuff-agriculture"].value then
  dh.add_prereq("bm-bio-cube-ooze", "bm-boompuff")

  dh.add_recipe_unlock("bm-bio-cube-ooze", "bm-napalm-from-ooze")

  data:extend({
    {
      type = "recipe",
      name = "bm-napalm-from-ooze",
      icons = {
        {
          icon = "__biological-machines-planet-balack__/graphics/bio-cube-ooze.png",
          scale = 0.35,
          shift = {-4, -4},
        },
        {
          icon = "__biological-machines-industry__/graphics/napalm.png",
          scale = 0.35,
          shift = {4, 4},
          draw_background = true,
        },
      },
      category = "organic-or-chemistry",
      subgroup = "bm-balack-processes",
      order = "c-d",
      auto_recycle = false,
      enabled = false,
      allow_productivity = true,
      allow_decomposition = false,
      energy_required = 2,
      ingredients = {
        {type = "fluid", name = "light-oil", amount = 50},
        {type = "fluid", name = "bm-puff-gas", amount = 35},
        {type = "item", name = "bm-bio-cube-ooze", amount = 10}
      },
      results = {
        {type = "fluid", name = "bm-napalm", amount = 50}
      },
      crafting_machine_tint = {
        primary = {0.91, 0.27, 0.0},
        secondary = {1.0, 0.72, 0.5}
      }
    }
  })
end
