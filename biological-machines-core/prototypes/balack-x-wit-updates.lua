local item_sounds = require("__base__.prototypes.item_sounds")

local dh = require("__biological-machines-core__.data-helper")



K2_WIND_TURBINE_ZARS_FORK.OVERRIDE_SOLAR_POWER_SCALING["bm-wit"] = 10



data.raw.recipe["bm-mech-armor-mk2"].category = "bm-advanced-robotics"



local wit_map_gen = data.raw.planet["bm-wit"].map_gen_settings
wit_map_gen.property_expression_names["entity:bm-promethium-ore:richness"] = "bm_wit_promethium_richness"
wit_map_gen.property_expression_names["entity:bm-promethium-ore:probability"] = "bm_wit_promethium_probability"
wit_map_gen.autoplace_settings.entity.settings["bm-promethium-ore"] = {}

data:extend({
  --[[
  {
    type = "noise-expression",
    name = "bm_wit_promethium_region",
    expression = "min(wit_mountains_resource_favorability_asteroid,\z
                        wit_place_non_metal_spots(1234, 100, 10,\z
                          3 * control:bm_promethium_ore:size,\z
                          control:bm_promethium_ore:frequency,\z
                          wit_mountains_resource_favorability_asteroid))",
  },
  --]]
  ---[[
  {
    type = "noise-expression",
    name = "bm_wit_promethium_region",
    expression = "spot_noise{x = x + bm_balack_wobble_x,\z
                             y = y + bm_balack_wobble_y,\z
                             seed0 = map_seed,\z
                             seed1 = 1234,\z
                             candidate_spot_count = 1 + 4 * control:bm_promethium_ore:frequency,\z
                             suggested_minimum_candidate_point_spacing = 100,\z
                             skip_span = 3,\z
                             skip_offset = 2,\z
                             region_size = 150,\z
                             density_expression = 1 / (6.75 + (1.5 * control:bm_promethium_ore:size) ^ 2),\z
                             spot_quantity_expression = 6.75 + (1.5 * control:bm_promethium_ore:size) ^ 2,\z
                             spot_radius_expression = 1.5 + 1.5 * control:bm_promethium_ore:size,\z
                             hard_region_target_quantity = 0,\z
                             spot_favorability_expression = wit_mountains_resource_favorability_asteroid > 0.01,\z
                             basement_value = -1,\z
                             maximum_spot_basement_radius = 128}",
  },
  --]]
  {
    type = "noise-expression",
    name = "bm_wit_promethium_probability",
    --[[
    expression = "(control:bm_promethium_ore:size > 0) * 1000\z
      * ((1 + bm_balack_promethium_region) * random_penalty_between(0.9, 1, 1) - 1)",
    ]]
    expression = "35 * (control:bm_promethium_ore:size > 0) * bm_balack_promethium_region * wit_mountains_resource_favorability_asteroid",
  },
  {
    type = "noise-expression",
    name = "bm_wit_promethium_richness",
    expression = "45 * control:bm_promethium_ore:richness\z
      / control:bm_promethium_ore:size\z
      * bm_wit_promethium_region * random_penalty_between(0.9, 1, 1)",
  },
})



--------------------------------------------------------TRAINED AI MODULE
data:extend({
  {
    type = "module",
    name = "bm-ai-control-unit-trained",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-light-trained.png",
    subgroup = "module",
    color_hint = { text = "S" },
    category = "bm-ai",
    tier = 4,
    order = "z[ai-control-unit]-b",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    stack_size = 10,
    weight = 100 * kg,
    effect = {
      productivity = 0.2,
      consumption = 1,
      pollution = 1,
      speed = 1,
      quality = -0.5,
    },
    default_import_location = "bm-wit",
    spoil_ticks = 30 * minute,
    spoil_result = "bm-ai-control-unit"
  },
  {
    type = "recipe",
    name = "bm-ai-control-unit-trained",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-light-trained.png",
    category = "electromagnetics",
    --subgroup = "module",
    --order = "z[ai-control-unit]-b",
    enabled = false,
    allow_productivity = false,
    maximum_productivity = 0,
    allow_decomposition = false,
    energy_required = 30,
    ingredients = {
      {type = "item", name = "bm-ai-control-unit", amount = 1},
      {type = "item", name = "bm-complete-data-disk", amount = 1},
    },
    results = {
      {type = "item", name = "bm-ai-control-unit-trained", amount = 1},
      {type = "item", name = "bm-empty-data-disk", amount = 1, probability = 0.9},
    },
    main_product = "bm-ai-control-unit-trained",
  },
  {
    type = "technology",
    name = "bm-trained-ai-control-unit",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-trained-tech.png",
    icon_size = 256,
    essential = true,
    effects = {
      {type = "unlock-recipe", recipe = "bm-ai-control-unit-trained"},
    },
    prerequisites = {"bm-activated-ai-control-unit", "bm-interstellar-science-pack"},
    unit = {
      count = 5000,
      ingredients = util.table.deepcopy(bm_all_sci_packs),
      time = 120
    }
  },
})
