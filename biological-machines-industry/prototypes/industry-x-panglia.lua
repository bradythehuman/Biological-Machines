local dh = require("__biological-machines-core__.data-helper")



dh.add_recipe_unlock("panglia_advanced_circuit_from_panglite_fiber", "bm-electronic-circuit-from-fiber")

--dh.add_recipe_unlock("panglia_low_density_structure_from_panglite_fiber", "bm-refined-concrete-from-fiber")

dh.add_ingredient("panglia_branbalite_slurry_to_rocket_fuel", "fluid", "lubricant", 10)
for _, ingredient in pairs(data.raw.recipe["panglia_branbalite_slurry_to_lubricant"].ingredients) do
  if ingredient.name == "steam" then
    ingredient.name = "sulfuric-acid"
  end
end



--dh.add_ingredient("matter_printer", "item", "refined-concrete", 20)

--dh.add_ingredient("simulation_chamber", "item", "carbon-fiber", 50)
dh.add_ingredient("simulation_chamber", "item", "webbed_processor_tile", 5)


data:extend({
  {
    type = "recipe",
    name = "bm-electronic-circuit-from-fiber",
    icons = {
      {
        icon = "__panglia_planet__/graphics/icons/panglia_panglite_fiber.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__base__/graphics/icons/electronic-circuit.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    categories = {"crafting", "electromagnetics"},
    subgroup = "panglia-processes",
    order = "b[otherres]-ac",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "panglia_panglite_fiber", amount = 1},
      {type = "item", name = "copper-cable", amount = 6}
    },
    results = {
      {type = "item", name = "electronic-circuit", amount = 2}
    },
    main_product = "electronic-circuit",
    allow_decomposition = false,
    surface_conditions = {{property = "pressure", min = 1401, max = 1401}},
    sort_item_ingredients = false,
    auto_recycle = false,
  },
  --[[
  {
    type = "recipe",
    name = "bm-refined-concrete-from-fiber",
    icons = {
      {
        icon = "__panglia_planet__/graphics/icons/panglia_panglite_fiber.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__base__/graphics/icons/refined-concrete.png",
        scale = 0.35,
        shift = {-4, -4},
        draw_background = true,
      },
    },
    categories = {"crafting-with-fluid"},
    subgroup = "panglia-processes",
    order = "b[otherres]-ac",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "panglia_panglite_fiber", amount = 1},
      {type = "item", name = "stone-brick", amount = 10},
      {type = "fluid", name = "steam", amount = 100},
    },
    results = {
      {type = "item", name = "refined-concrete", amount = 2}
    },
    main_product = "refined-concrete",
    allow_decomposition = false,
    surface_conditions = {{property = "pressure", min = 1401, max = 1401}},
    sort_item_ingredients = false,
    auto_recycle = false,
  },
  ]]
})
