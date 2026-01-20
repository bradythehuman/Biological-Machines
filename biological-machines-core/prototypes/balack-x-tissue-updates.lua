local dh = require("__biological-machines-core__.data-helper")



--RECIPES
data.raw.recipe["fish-breeding"].surface_conditions = {
  {property = "pressure", min = 1000, max = 1000}
}

data.raw.recipe["bm-hypersonic-rounds-magazine"].category = "bm-military-crafting"

dh.remove_ingredient("bm-ai-control-unit", "raw-fish")
dh.add_ingredient("bm-ai-control-unit", "item", "bm-radioactive-tissue", 1)

dh.add_ingredient("bm-bio-cube", "item", "bm-radioactive-tissue", 10)

local ai_module_recycling_results = data.raw.recipe["bm-ai-control-unit-recycling"].results
for _, result in pairs(ai_module_recycling_results) do
  if result.name == "raw-fish" then
    result.name = "bm-radioactive-tissue"
  end
end

data:extend({
  {
    type = "recipe",
    name = "bm-uranium-enrichment-with-ooze",
    icons = {
      {
        icon = "__biological-machines-planet-balack__/graphics/bio-cube-ooze.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__base__/graphics/icons/uranium-235.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    category = "organic",
    subgroup = "bm-balack-processes",
    order = "c-d",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "bm-bio-cube-ooze", amount = 10},
      {type = "item", name = "bm-radioactive-tissue", amount = 1},
      {type = "item", name = "uranium-238", amount = 4},
    },
    results = {
      {type = "item", name = "uranium-235", amount = 2},
      {type = "fluid", name = "bm-radioactive-biosludge", amount = 50},
    },
  },
})



--TECHNOLOGIES
local add_ingredient = {
  "bm-planet-discovery-shattered-planet", "bm-planet-discovery-balack",
  "bm-activated-ai-control-unit", "bm-tank-mk2", "bm-mech-armor-mk2",
  "bm-bio-cube-ooze", "bm-hypersonic-ammo",
}
for _, t in pairs(add_ingredient) do
  --data.raw["technology"][t].unit.ingredients = util.table.deepcopy(data.raw.technology["research-productivity"].unit.ingredients)
  table.insert(data.raw["technology"][t].unit.ingredients, {"bm-nuclear-military-science-pack", 1})
end

dh.remove_prereq("bm-tank-mk2", "tank")

dh.add_prereq("bm-bio-cube-ooze", "bm-radioactive-tissue-processing")

dh.add_recipe_unlock("bm-bio-cube-ooze", "bm-uranium-enrichment-with-ooze")
