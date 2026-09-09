local tile_sounds = require("__base__.prototypes.tile.tile-sounds")



data:extend({
  {
    type = "autoplace-control",
    name = "bm_promethium_ore",
    localised_name = {"", "[entity=bm-promethium-ore] ", {"entity-name.bm-promethium-ore"}},
    richness = true,
    --order = "d-a",
    order = "f-a",
    category = "resource"
  },
  {
    type = "resource",
    name = "bm-promethium-ore",
    icon = "__biological-machines-core__/graphics/promethium-ore-icon.png",
    flags = {"placeable-neutral"},
    order = "a-b-e",
    tree_removal_probability = 0.7,
    tree_removal_max_distance = 32 * 32,
    walking_sound = tile_sounds.walking.ore,
    driving_sound = tile_sounds.driving.stone,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 10,
      result = "promethium-asteroid-chunk",
      fluid_amount = 2,
      required_fluid = "fluoroketone-cold"
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    stage_counts = {145, 110, 80, 55, 35, 20, 10, 5},
    stages = {
      sheet = {
        filename = "__biological-machines-core__/graphics/promethium-ore-entity.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
    stages_effect = {
      sheet =
      {
        filename = "__biological-machines-core__/graphics/promethium-ore-glow-entity.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5,
        blend_mode = "additive",
        flags = {"light"}
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    effect_darkness_multiplier = 3.6,
    min_effect_alpha = 0.2,
    max_effect_alpha = 0.3,
    mining_visualisation_tint = {r = 1, g = 0.5, b = 0.6, a = 1.000}, -- #cfff7fff
    map_color = {0.7, 0, 0},
    autoplace = {
      control = "bm_promethium_ore",
      order = "c",
      probability_expression = "",
      --probability_expression = "bm_fulgora_promethium_probability",
      richness_expression = "",
      --richness_expression = "bm_fulgora_promethium_richness",
    },
  }
})
--]]
