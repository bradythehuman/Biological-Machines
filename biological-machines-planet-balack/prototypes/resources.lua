local tile_sounds = require("__base__.prototypes.tile.tile-sounds")



local balack_scrap = util.table.deepcopy(data.raw["resource"]["scrap"])
balack_scrap.name = "bm-balack-scrap"
balack_scrap.icon = "__biological-machines-planet-balack__/graphics/balack-scrap.png"
balack_scrap.minable.result = "bm-balack-scrap"
balack_scrap.map_color = {0.9, 0.9, 0.9}
balack_scrap.factoriopedia_simulation = nil
balack_scrap.stage_counts = {15000 * 8, 9500 * 7, 5500 * 6, 2900 * 5, 1300 * 4, 400 * 3, 150 * 2, 80 * 1}
balack_scrap.stages = {
  sheet = {
    filename = "__biological-machines-planet-balack__/graphics/balack-scrap-entity.png",
    priority = "extra-high",
    size = 128,
    frame_count = 8,
    variation_count = 8,
    scale = 0.5
  }
}
balack_scrap.autoplace = {
  control = "bm_balack_scrap",
  order = "b",
  probability_expression = "(control:bm_balack_scrap:size > 0)\z
                            * (1 - bm_balack_starting_mask)\z
                            * (min((bm_balack_structure_cells < min(0.1 * frequency, 0.05 + 0.05 * frequency))\z
                               * (1 + bm_balack_structure_subnoise) * abs_mult_height_over * bm_balack_artificial_mask\z
                               + (bm_balack_spots_prebanding < (1.2 + 0.4 * linear_size)) * bm_balack_vaults_and_starting_vault * 10,\z
                               0.5) * (1 - bm_balack_road_paving_2c))\z
                            - bm_bio_cube_scrap_buffer",
  --richness_expression = "(1 + bm_balack_structure_subnoise) * 1000 * (7 / (6 + frequency) + 100 * bm_balack_vaults_and_starting_vault) * richness",
  --richness_expression = "(1 + bm_balack_structure_subnoise) * 5000000 * (7 / (6 + frequency) + 5 * bm_balack_vaults_and_starting_vault) * richness",
  richness_expression = "(1 + bm_balack_structure_subnoise) * 1000 * (7 / (6 + frequency) + 5 * bm_balack_vaults_and_starting_vault) * richness",
  local_expressions =
  {
    abs_mult_height_over = "bm_balack_elevation > (bm_balack_coastline + 10)", -- Resources prevent cliffs from spawning. This gets resources away from cliffs.
    frequency = "5 * control:bm_balack_scrap:frequency", -- limited application
    size = "2 * control:bm_balack_scrap:size", -- Size also affects noise peak height so impacts richness as a sideeffect...
    linear_size = "slider_to_linear(size, -1, 1)", -- the intetion is to increase coverage (access & mining speed) without significantly affecting richness.
    richness = "control:bm_balack_scrap:richness"
  }
}
balack_scrap.infinite = true
balack_scrap.infinite_depletion_amount = 0
balack_scrap.normal = 200
balack_scrap.minimum = 50

data:extend({balack_scrap})



data:extend({
  {
    type = "resource",
    name = "bm-promethium-ore",
    icon = "__biological-machines-planet-balack__/graphics/promethium-ore-icon.png",
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
        filename = "__biological-machines-planet-balack__/graphics/promethium-ore-entity.png",
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
        filename = "__biological-machines-planet-balack__/graphics/promethium-ore-glow-entity.png",
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
      probability_expression = "bm_balack_promethium_probability - bm_bio_cube_scrap_buffer",
      --probability_expression = "bm_fulgora_promethium_probability",
      richness_expression = "bm_balack_promethium_richness",
      --richness_expression = "bm_fulgora_promethium_richness",
    },
  }
})
--]]
