local dh = require("__biological-machines-core__.data-helper")



--remove stingfrond
data.raw.item["bm-stingfrond"].hidden = true
data.raw.item["bm-stingfrond-seed"].hidden = true
data.raw.plant["bm-stingfrond-plant"].hidden = true

local new_results = {}
for _, result in pairs(data.raw.tree["stingfrond"].minable.results) do
  if result.result ~= "bm-stingfrond" then
    table.insert(new_results, result)
  end
end
data.raw.tree["stingfrond"].minable.results = new_results



--replace stigfronds with branbalite in fluroflux and stim recipes
dh.remove_ingredient("bm-fluroflux", "bm-stingfrond")
dh.add_ingredient("bm-fluroflux", "item", "panglia_branbalite", 1)

dh.remove_ingredient("bm-stims", "bm-stingfrond")
dh.add_ingredient("bm-stims", "item", "panglia_branbalite", 1)

dh.add_prereq("bm-fluroflux", "panglia_branbalite_slurry")
dh.add_prereq("panglia_dna_manipulation", "bm-fluroflux")



dh.remove_ingredient("panglia_cloned_specimen_body_0", "bioflux")
dh.add_ingredient("panglia_cloned_specimen_body_0", "item", "bm-fluroflux", 1)



dh.add_recipe_unlock("bm-fluroflux", "bm-fortified-nutrient-slurry-from-fiber")
dh.add_recipe_unlock("bm-fluroflux", "bm-stims-from-fiber")
data:extend({
  {
    type = "recipe",
    name = "bm-fortified-nutrient-slurry-from-fiber",
    icons = {
      {
        icon = "__panglia_planet__/graphics/icons/panglia_panglite_fiber.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__biological-machines-hunger__/graphics/fortified-nutrient-slurry.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    categories = {"organic"},
    subgroup = "panglia-processes",
    order = "b[otherres]-ac",
    auto_recycle = false,
    enabled = false,
    allow_productivity = false,
    energy_required = 10,
    ingredients = {
      {type = "item", name = "panglia_panglite_fiber", amount = 1},
      {type = "fluid", name = "steam", amount = 20},
      {type = "item", name = "bm-fluroflux", amount = 1},
      {type = "item", name = "spoilage", amount = 10}
    },
    results = {{type = "item", name = "bm-fortified-nutrient-slurry", amount = 2}},
    allow_decomposition = false,
    surface_conditions = {{property = "pressure", min = 1401, max = 1401}},
    sort_item_ingredients = false,
    auto_recycle = false,
  },
  {
    type = "recipe",
    name = "bm-stims-from-fiber",
    icons = {
      {
        icon = "__panglia_planet__/graphics/icons/panglia_panglite_fiber.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/stims.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    categories = {"crafting-with-fluid"},
    subgroup = "panglia-processes",
    order = "b[otherres]-ac",
    enabled = false,
    allow_productivity = false,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "panglia_panglite_fiber", amount = 1},
      {type = "item", name = "panglia_branbalite", amount = 1},
      {type = "item", name = "solid-fuel", amount = 2},
      {type = "fluid", name = "steam", amount = 10},
    },
    results = {{type = "item", name = "bm-stims", amount = 4}},
  },
})
