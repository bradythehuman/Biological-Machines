local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local tree_mined_sound =  require("__base__.prototypes.entity.sounds").tree_mined
local dh = require("__biological-machines-core__.data-helper")


local chimneys = {"vulcanus-chimney", "vulcanus-chimney-faded", "vulcanus-chimney-cold"}
dh.add_entity_drop("simple-entity", chimneys, "bm-sulfuric-bacteria", {0, 5})



table.insert(data.raw["assembling-machine"]["assembling-machine-1"].crafting_categories, "organic-or-hand-crafting")
local org_hand_recipes = {"wood-processing", "nutrients-from-spoilage", "nutrients-from-fish", "nutrients-from-biter-egg"}
for i=1, #org_hand_recipes do
  data.raw["recipe"][org_hand_recipes[i]].category = "organic-or-hand-crafting"
end
--------------------------------------------------NUTRIENT SUBGROUP
data:extend({
  {
    type = "item-subgroup",
    name = "bm-nutrients",
    group = "intermediate-products",
    order = "lz"
  },
})

data.raw["item"]["spoilage"].subgroup = "bm-nutrients"
data.raw["item"]["spoilage"].order = "a"
data.raw["item"]["nutrients"].subgroup = "bm-nutrients"
data.raw["item"]["nutrients"].order = "b"

local nutrient_recipes = {
  ["nutrients-from-spoilage"] = "c-a",
  ["nutrients-from-fish"] = "c-c",
  ["nutrients-from-biter-egg"] = "c-d",
  ["nutrients-from-yumako-mash"] = "c-e",
  ["nutrients-from-bioflux"] = "c-f",
}
for recipe_name, order in pairs(nutrient_recipes) do
  data.raw["recipe"][recipe_name].subgroup = "bm-nutrients"
  data.raw["recipe"][recipe_name].order = order
end

data.raw["recipe"]["wood-processing"].order = "b-a"
data.raw["item"]["tree-seed"].order = "b-b"
data.raw["recipe"]["fish-breeding"].order = "c-a"
data.raw["item"]["biter-egg"].subgroup = "nauvis-agriculture"
data.raw["item"]["biter-egg"].order = "c-b"



--------------------------------------------------------TECHNOLOGY
local landfill = data.raw["technology"]["landfill"]
landfill.prerequisites = {"automation-science-pack"}
landfill.unit = {
  count = 25,
  ingredients = {{"automation-science-pack", 1}},
  time = 15
}
local agriculture = data.raw["technology"]["agriculture"]
table.insert(agriculture.effects, {type="unlock-recipe", recipe="bm-nutrients-from-berries"})
agriculture.prerequisites = {"landfill", "steel-processing"}
agriculture.unit = {
  count = 75,
  ingredients = {{"automation-science-pack", 1}},
  time = 15
}
agriculture.research_trigger = nil

if mods["biological-machines-hunger"] then
  dh.add_prereq("planet-discovery-gleba", "bm-food-processing")
else
  dh.add_prereq("planet-discovery-gleba", "agriculture")
end
data.raw["technology"]["yumako"].prerequisites = {"planet-discovery-gleba"}
data.raw["technology"]["jellynut"].prerequisites = {"planet-discovery-gleba"}

local vulcanus_effects = {"bm-sulfuric-bacteria", "bm-sulfuric-bacteria-cultivation"}
dh.add_recipe_unlock("planet-discovery-vulcanus", vulcanus_effects)

local recycling_effects = {"bm-hydrocarbon-bacteria", "bm-hydrocarbon-bacteria-cultivation"}
dh.add_recipe_unlock("recycling", recycling_effects)



-----------------------------------------------BERRIES
local berry_bush = {
  type = "plant",
  name = "bm-berry-bush",
  icon = "__biological-machines-core__/graphics/berry-bush.png",
  icon_size = 256,
  flags = plant_flags,
  minable = {
    mining_particle = "wooden-particle",
    mining_time = 0.5,
    results = {
      {type = "item", name = "wood", amount = 1, probability = 0.5},
      {type = "item", name = "bm-berry", amount = 10}
    },
    mining_trigger = {{
      type = "direct",
      action_delivery = {{type = "instant", target_effects = leaf_sound_trigger}}
    }}
  },
  mined_sound = tree_mined_sound,
  growth_ticks = 5 * minute,
  emissions_per_second = { pollution = -0.001 },
  max_health = 50,
  --collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
  selection_box = {{-0.5, -1.5}, {0.5, 0.4}},
  drawing_box_vertical_extension = 0.8,
  subgroup = "trees",
  impact_category = "tree",
  --autoplace = util.table.deepcopy(data.raw["tree"]["tree-08"].autoplace),
  autoplace = {
    control = "trees",
    order = "a[tree]-b[forest]-f",
    probability_expression =
      "min(0.3, trees_forest_path_cutout_faded,\z
      min(0,\z
          asymmetric_ramps{input=temperature, from_bottom=1, from_top=14, to_top=16, to_bottom=17},\z
          asymmetric_ramps{input=moisture, from_bottom=0.3, from_top=0.4, to_top=1, to_bottom=2})\z
      + min(0, distance/15 - 15)\z
      - 8 + 1 * control:trees:size\z
      + tree_small_noise * 0.1\z
      + multioctave_noise{x = x,\z
                          y = y,\z
                          persistence = 1,\z
                          seed0 = map_seed,\z
                          seed1 = 'tree-08',\z
                          octaves = 10,\z
                          input_scale = 1 * control:trees:frequency,\z
                          output_scale = 10})",
    richness_expression = "clamp(random_penalty_at(6, 1), 0, 1)"
  },
  surface_conditions = {{property = "pressure", min = 1000, max = 1000}},
  --[[
  autoplace = {
    control = "trees",
    order = "a[tree]-b[forest]-f",
    probability_expression =
      "min(0.3, trees_forest_path_cutout_faded,\z
      min(0,\z
          asymmetric_ramps{input=temperature, from_bottom=0.1, from_top=14, to_top=16, to_bottom=17},\z
          asymmetric_ramps{input=moisture, from_bottom=0.3, from_top=0.4, to_top=1, to_bottom=2})\z
      + min(0, distance/20 - 3)\z
      - 0.5 + 0.2 * control:trees:size\z
      + tree_small_noise * 0.1\z
      + multioctave_noise{x = x,\z
                          y = y,\z
                          persistence = 0.65,\z
                          seed0 = map_seed,\z
                          seed1 = 'tree-08',\z
                          octaves = 3,\z
                          input_scale = 10 * control:trees:frequency,\z
                          output_scale = 0.7})",
    richness_expression = "clamp(random_penalty_at(6, 1), 0, 1)"
  },
  ]]
  pictures = {{size = 256, filename = "__biological-machines-core__/graphics/berry-bush.png", scale = 0.5}},
  --colors = minor_tints(),
  agricultural_tower_tint = {
    primary = {r = 0.218, g = 0.218, b = 0.552, a = 1.000},
    secondary = {r = 0.561, g = 0.308, b = 0.613, a = 1.000},
  },
  --[[
  ambient_sounds =
  {
    sound =
    {
      variations = sound_variations("__space-age__/sound/world/plants/yumako-tree", 6, 0.5),
      advanced_volume_control =
      {
        fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0}}}
      }
    },
    radius = 7.5,
    min_entity_count = 2,
    max_entity_count = 10,
    entity_to_sound_ratio = 0.2,
    average_pause_seconds = 8
  },
  ]]
  map_color = {255, 255, 255}
}
berry_bush.autoplace.tile_restriction = data.raw["plant"]["tree-plant"].autoplace.tile_restriction

data:extend({
  berry_bush,
  {
    type = "item",
    name = "bm-berry",
    icon = "__biological-machines-core__/graphics/berry.png",
    subgroup = "nauvis-agriculture",
    order = "a-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 50,
    weight = 1 * kg,

    fuel_category = "chemical",
    fuel_value = "250kJ",

    spoil_ticks = 30 * minute,
    spoil_result = "spoilage"
  },
  {
    type = "recipe",
    name = "bm-nutrients-from-berries",
    icons = {
      {
        icon = "__biological-machines-core__/graphics/berry.png",
        -- icon_size = 64,
        scale = 0.30,
        shift = {-5, -5},
      },
			{
        icon = "__biological-machines-core__/graphics/nutrients-from-blank.png",
        --icon_size = 64,
      }
		},
    category = "organic-or-hand-crafting",
    subgroup = "bm-nutrients",
    order = "c-b",
    enabled = false,
    allow_productivity = true,
    energy_required = 0.5,
    ingredients = {{type = "item", name = "bm-berry", amount = 1}},
    results = {{type = "item", name = "nutrients", amount = 1}}
  },
  {
    type = "item",
    name = "bm-berry-seed",
    localised_name = {"item-name.bm-berry-seed"},
    icon = "__biological-machines-core__/graphics/berry-seed.png",
    subgroup = "nauvis-agriculture",
    order = "a-b",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,

    fuel_category = "chemical",
    fuel_value = "100kJ",

    plant_result = "bm-berry-bush",
    place_result = "bm-berry-bush"
  },
  {
    type = "recipe",
    name = "bm-berry-seed",
    icon = "__biological-machines-core__/graphics/berry-seed.png",
    category = "crafting",
    enabled = true,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {{type = "item", name = "bm-berry", amount = 2}},
    results = {{type = "item", name = "bm-berry-seed", amount = 1}}
  }
})



----------------------------------------------------alcohol
data:extend({
  {
    type = "sticker",
    name = "bm-drunk-1",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = 20 * second,
    damage_per_tick = {amount = -0.25, type = "physical"},
    target_movement_modifier = 2
  },
  {
    type = "sticker",
    name = "bm-hungover-1",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = 1 * minute,
    target_movement_modifier = 0.5
  },
  {
    type = "sticker",
    name = "bm-drunk-2",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = 20 * second,
    damage_per_tick = {amount = -2.5, type = "physical"},
    target_movement_modifier = 5
  },
  {
    type = "sticker",
    name = "bm-hungover-2",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = 1 * minute,
    target_movement_modifier = 0.2
  },
  {
    type = "fluid",
    name = "bm-nutrient-wine",
    icon = "__biological-machines-core__/graphics/nutrient-wine.png",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2kJ",
    base_color = {0.47, 0.38, 0.14},
    flow_color = {0.78, 0.72, 0.56}
  },
  {
    type = "fluid",
    name = "bm-ethanol",
    icon = "__biological-machines-core__/graphics/ethanol.png",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2kJ",
    base_color = {0.45, 0.45, 0.45},
    flow_color = {0.76, 0.76, 0.76}
  },
  {
    type = "recipe",
    name = "bm-nutrient-wine",
    icon = "__biological-machines-core__/graphics/nutrient-wine.png",
    category = "organic-or-chemistry",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-a",
    auto_recycle = false,
    enabled = false,
    allow_productivity = false,
    allow_decomposition = false,
    energy_required = 5,
    surface_conditions = {{property = "pressure", min = 800, max = 4000}},
    ingredients = {
      {type = "fluid", name = "water", amount = 100},
      {type = "item", name = "nutrients", amount = 8},
      {type = "item", name = "spoilage", amount = 2}
    },
    results = {{type = "fluid", name = "bm-nutrient-wine", amount = 100}},
  },
  {
    type = "recipe",
    name = "bm-ethanol",
    icon = "__biological-machines-core__/graphics/ethanol.png",
    category = "chemistry-or-cryogenics",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {{type = "fluid", name = "bm-nutrient-wine", amount = 100}},
    results = {
      {type = "fluid", name = "bm-ethanol", amount = 20},
      {type = "item", name = "spoilage", amount = 5}
    },
    main_product = "bm-ethanol"
  },
  {
    type = "technology",
    name = "bm-alcohol",
    icon = "__biological-machines-core__/graphics/ethanol.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "bm-nutrient-wine"},
      {type = "unlock-recipe", recipe = "bm-ethanol"},
      {type = "unlock-recipe", recipe = "chemical-plant"}
    },
    prerequisites = {"fluid-handling"},
    unit = {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 15
    }
  }
})




----------------------------------------------------BACTERIA
data:extend({
  {
    type = "item",
    name = "bm-sulfuric-bacteria",
    icon = "__biological-machines-core__/graphics/sulfuric-bacteria.png",
    subgroup = "bm-cultivation",
    order = "a-e-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 50,
    default_import_location = "vulcanus",
    weight = 1 * kg,
    spoil_ticks = 1 * minute,
    spoil_result = "spoilage"
  },
  {
    type = "recipe",
    name = "bm-sulfuric-bacteria",
    icon = "__biological-machines-core__/graphics/sulfuric-bacteria.png",
    category = "organic-or-chemistry",
    subgroup = "bm-cultivation",
    order = "a-e-b",
    surface_conditions = {{property = "pressure", min = 4000, max = 4000}},
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {{type = "fluid", name = "sulfuric-acid", amount = 100}},
    results = {
      {type = "item", name = "bm-sulfuric-bacteria", amount = 1, probability = 0.1},
      {type = "item", name = "spoilage", amount = 1}
    },
    crafting_machine_tint = {
      primary = {r = 1.000, g = 0.995, b = 0.089, a = 1.000}, -- #fffd16ff
      secondary = {r = 1.000, g = 0.974, b = 0.691, a = 1.000}, -- #fff8b0ff
      tertiary = {r = 0.723, g = 0.638, b = 0.714, a = 1.000}, -- #b8a2b6ff
      quaternary = {r = 0.954, g = 1.000, b = 0.350, a = 1.000}, -- #f3ff59ff
    },
    main_product = "bm-sulfuric-bacteria"
  },
  {
    type = "recipe",
    name = "bm-sulfuric-bacteria-cultivation",
    icon = "__biological-machines-core__/graphics/sulfuric-bacteria-cultivation.png",
    category = "organic-or-chemistry",
    subgroup = "bm-cultivation",
    order = "a-f",
    surface_conditions = {{property = "pressure", min = 4000, max = 4000}},
    enabled = false,
    allow_productivity = true,
    result_is_always_fresh = true,
    energy_required = 4,
    ingredients = {
      {type = "fluid", name = "sulfuric-acid", amount = 20},
      {type = "item", name = "carbon", amount = 2},
      {type = "item", name = "bm-sulfuric-bacteria", amount = 1}
    },
    results = {
      {type = "item", name = "sulfur", amount = 1},
      {type = "item", name = "bm-sulfuric-bacteria", amount = 4}
    },
    crafting_machine_tint = {
      primary = {r = 1.000, g = 0.995, b = 0.089, a = 1.000}, -- #fffd16ff
      secondary = {r = 1.000, g = 0.974, b = 0.691, a = 1.000}, -- #fff8b0ff
      tertiary = {r = 0.723, g = 0.638, b = 0.714, a = 1.000}, -- #b8a2b6ff
      quaternary = {r = 0.954, g = 1.000, b = 0.350, a = 1.000}, -- #f3ff59ff
    }
  },
  {
    type = "item",
    name = "bm-hydrocarbon-bacteria",
    icon = "__biological-machines-core__/graphics/hydrocarbon-bacteria.png",
    subgroup = "bm-cultivation",
    order = "a-g-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 50,
    default_import_location = "fulgora",
    weight = 1 * kg,
    spoil_ticks = 1 * minute,
    spoil_result = "spoilage"
  },
  {
    type = "recipe",
    name = "bm-hydrocarbon-bacteria",
    icon = "__biological-machines-core__/graphics/hydrocarbon-bacteria.png",
    category = "organic-or-chemistry",
    subgroup = "bm-cultivation",
    order = "a-g-b",
    surface_conditions = {{property = "magnetic-field", min = 98, max = 99}},
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {{type = "item", name = "ice", amount = 10}},
    results = {
      {type = "item", name = "bm-hydrocarbon-bacteria", amount = 1, probability = 0.1 },
      {type = "item", name = "spoilage", amount = 1}
    },
    crafting_machine_tint = {
      primary = {r = 0.900, g = 0.1, b = 1, a = 1.000}, -- #fffd16ff
      secondary = {r = 0.95, g = 0.5, b = 1, a = 1.000}, -- #fff8b0ff
      tertiary = {r = 0.6, g = 0.8, b = 0.7, a = 1.000}, -- #b8a2b6ff
      quaternary = {r = 1, g = 0.35, b = 0.95, a = 1.000}, -- #f3ff59ff
    },
    main_product = "bm-hydrocarbon-bacteria"
  },
  {
    type = "recipe",
    name = "bm-hydrocarbon-bacteria-cultivation",
    icon = "__biological-machines-core__/graphics/hydrocarbon-bacteria-cultivation.png",
    category = "organic-or-chemistry",
    subgroup = "bm-cultivation",
    order = "a-h",
    surface_conditions = {{property = "magnetic-field", min = 98, max = 99}},
    enabled = false,
    allow_productivity = true,
    result_is_always_fresh = true,
    energy_required = 4,
    ingredients = {
      {type = "fluid", name = "water", amount = 20},
      {type = "item", name = "solid-fuel", amount = 2},
      {type = "item", name = "bm-hydrocarbon-bacteria", amount = 1}
    },
    results = {{type = "item", name = "bm-hydrocarbon-bacteria", amount = 4}},
    crafting_machine_tint = {
      primary = {r = 0.900, g = 0.1, b = 1, a = 1.000}, -- #fffd16ff
      secondary = {r = 0.95, g = 0.5, b = 1, a = 1.000}, -- #fff8b0ff
      tertiary = {r = 0.6, g = 0.8, b = 0.7, a = 1.000}, -- #b8a2b6ff
      quaternary = {r = 1, g = 0.35, b = 0.95, a = 1.000}, -- #f3ff59ff
    }
  }
})
