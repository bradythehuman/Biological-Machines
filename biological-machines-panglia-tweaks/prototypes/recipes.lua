local dh = require("__biological-machines-core__.data-helper")



table.insert(data.raw.recipe["panglia_igneous_rock_to_lava"].results,
  {type = "item", name = "panglia_panglite", amount = 1}
)

dh.add_ingredient("panglia_low_density_structure_from_panglite_fiber", "item", "steel-plate", 4)

--concrete from brick and fiber

--add concrete to synap assembler and sim chamber



--HIDE COSMIC INCUBATION
data.raw.recipe["universe_precursor"].hidden = true
data.raw.recipe["panglia_universe_precursor_volcanic"].hidden = true
data.raw.recipe["panglia_universe_precursor"].hidden = true

data.raw["item-subgroup"]["matter_printer_recipes"].hidden = true



--DNA SOURCE
local raw_dna = data.raw.recipe["datacell-dna-raw"]
raw_dna.categories = {"data-processing"}
raw_dna.energy_required = 600 --50

for _, result in pairs(raw_dna.results) do
  if result.name == "datacell-dna-raw" then
    result.shared_probability.max = 0.1
  elseif result.name == "datacell-empty" then
    result.shared_probability.min = 0.1
  end
end

local dna_source
if mods["biological-machines-radioactive-tissue"] then
  dna_source = "bm-radioactive-tissue"
else
  dna_source = "biter-egg"
end
dh.add_ingredient("datacell-dna-raw", "item", dna_source, 1)
table.insert(raw_dna.results,
  {type = "item", name = dna_source, amount = 1, independent_probability = 0.99}
)

for _, result in pairs(data.raw.recipe["panglia_cloned_specimen_body_0"].results) do
  if result.name == "datacell-dna-raw" then
    result.name = "datacell-empty"
  end
end



--NEW RECIPES
data:extend({
  --[[
  {
    type = "recipe",
    name = "bm-processing-unit-from-fiber",
    icon = icons .. "panglia_advanced_circuit_from_panglite_fiber.png",
    categories = {"crafting", "electromagnetics"},
    subgroup = "panglia-processes",
    order = "b[otherres]-ac",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    energy_required = 0.5 * beacon_multiplier,
    ingredients =
    {
      {type = "item", name = "panglia_panglite_fiber", amount = 2},
      {type = "item", name = "electronic-circuit", amount = 2},
      {type = "item", name = "copper-cable", amount = 4}
    },
    results = {
      {type = "item", name = "advanced-circuit", amount = 1}
    },
    main_product = "advanced-circuit",
    allow_decomposition = false,
    surface_conditions = panglia_only,
    sort_item_ingredients = false,
    auto_recycle = false,
  },
  ]]
  {
    type = "recipe",
    name = "bm-igneous-rock-incubation",
    icons = {
      {
        icon = "__panglia_planet__/graphics/icons/panglia_panglite-1.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__panglia_planet__/graphics/icons/panglia_igneous_rock-1.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    categories = {"bm-panglite-incubator"},
    subgroup = "panglia-processes",
    order = "b[otherres]-bca",
    auto_recycle = false,
    allow_decomposition = false,
    allow_productivity = true,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "panglia_panglite", amount = 20},
      {type = "item", name = "panglia_igneous_rock", amount = 20},
    },
    results = {
      {type = "item", name = "stone", amount_min = 0, amount_max = 20, independent_probability = 0.4},
      {type = "item", name = "iron-ore", amount_min = 0, amount_max = 20, independent_probability = 0.2},
      {type = "item", name = "copper-ore", amount_min = 0, amount_max = 20, independent_probability = 0.2},
      {type = "item", name = "uranium-238", amount_min = 0, amount_max = 20, independent_probability = 0.2},
      {type = "item", name = "calcite", amount_min = 0, amount_max = 20, independent_probability = 0.1},
    }
  },
  {
    type = "recipe",
    name = "bm-branbalite-incubation",
    icons = {
      {
        icon = "__panglia_planet__/graphics/icons/panglia_panglite-1.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__panglia_planet__/graphics/icons/panglia_branbalite_1.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    categories = {"bm-panglite-incubator"},
    subgroup = "panglia-processes",
    order = "b[otherres]-bcb",
    auto_recycle = false,
    allow_decomposition = false,
    allow_productivity = true,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "panglia_panglite", amount = 20},
      {type = "item", name = "panglia_branbalite", amount = 5},
    },
    results = {
      {type = "item", name = "solid-fuel", amount_min = 0, amount_max = 20, independent_probability = 0.4},
      {type = "item", name = "spoilage", amount_min = 0, amount_max = 20, independent_probability = 0.3},
      {type = "item", name = "carbon", amount_min = 0, amount_max = 20, independent_probability = 0.2},
      {type = "item", name = "nutrients", amount_min = 0, amount_max = 20, independent_probability = 0.1},
      --{type = "item", name = "plastic-bar", amount_min = 0, amount_max = 20, independent_probability = 0.1},
      {type = "item", name = "sulfur", amount_min = 0, amount_max = 20, independent_probability = 0.1},
    }
  },
  {
    type = "recipe",
    name = "bm-dust-incubation",
    icons = {
      {
        icon = "__panglia_planet__/graphics/icons/panglia_panglite-1.png",
        scale = 0.35,
        shift = {-4, -4},
      },
      {
        icon = "__panglia_planet__/graphics/icons/panglia_dust.png",
        scale = 0.35,
        shift = {4, 4},
        draw_background = true,
      },
    },
    categories = {"bm-panglite-incubator"},
    subgroup = "panglia-processes",
    order = "b[otherres]-bcc",
    auto_recycle = false,
    allow_decomposition = false,
    allow_productivity = true,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "panglia_panglite", amount = 20},
      {type = "item", name = "panglia_dust", amount = 100},
    },
    results = {
      {type = "item", name = "panglia_igneous_rock", amount_min = 0, amount_max = 300},
    }
  },
})
