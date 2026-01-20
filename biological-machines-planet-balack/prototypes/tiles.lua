local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_sounds = require("__space-age__/prototypes/tile/tile-sounds")
local base_tile_sounds = require("__base__/prototypes/tile/tile-sounds")
--local tile_trigger_effects = require("prototypes.tile.tile-trigger-effects")



local balack_tile_data = {
  ["oil-ocean-shallow"] = {
    "bm-balack-oil-shallow",
    "bm_balack_oil_ocean_shallow",
    {25, 21, 21},
    "__biological-machines-planet-balack__/graphics/tiles/balack-oil-sand-8x.png",
  },
  ["oil-ocean-deep"] = {
    "bm-balack-oil-deep",
    "bm_balack_oil_ocean_deep",
    {8, 4, 4},
  },
  ["fulgoran-rock"] = {
    "bm-balack-n-rock",
    "0.8 + bm_balack_rock * 2 - max(0, bm_balack_mix_oil) * 6 - bm_bio_cube_pool",
    {38, 35, 35},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-rock.png",
  },
  ["fulgoran-dust"] = {
    "bm-balack-n-dust",
    "bm_balack_scrap_medium + max(0, bm_balack_natural, 2 * bm_balack_mesa * bm_balack_pyramids) * 2 - 0.9 + bm_balack_rock + bm_balack_road_dust * bm_balack_sprawl - bm_bio_cube_pool",
    {30, 27, 27},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-dust.png",
  },
  ["fulgoran-sand"] = {
    "bm-balack-n-sand",
    "1 - bm_balack_dunes - bm_bio_cube_pool",
    {26, 23, 23},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-sand.png",
  },
  ["fulgoran-dunes"] = {
    "bm-balack-n-dunes",
    "1 + bm_balack_dunes - bm_bio_cube_pool",
    {34, 31, 31},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-dunes.png",
  },
  ["fulgoran-walls"] = {
    "bm-balack-n-walls",
    "bm_balack_tile_ruin_walls - bm_bio_cube_pool",
    {54, 45, 45},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-walls.png",
  },
  ["fulgoran-paving"] = {
    "bm-balack-n-paving",
    "bm_balack_tile_ruin_paving - bm_bio_cube_pool",
    {63, 45, 45},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-paving.png",
  },
  ["fulgoran-conduit"] = {
    "bm-balack-n-conduit",
    "bm_balack_tile_ruin_conduit - bm_bio_cube_pool",
    {50, 41, 41},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-conduit.png",
  },
  ["fulgoran-machinery"] = {
    "bm-balack-n-machinery",
    "bm_balack_tile_ruin_machinery - bm_bio_cube_pool",
    {46, 37, 37},
    "__biological-machines-planet-balack__/graphics/tiles/balack-n-machinery.png",
  },
}
for key, tile_data in pairs(balack_tile_data) do
  local new_tile = util.table.deepcopy(data.raw["tile"][key])
  new_tile.name = tile_data[1]
  new_tile.autoplace.probability_expression = tile_data[2]
  new_tile.sprite_usage_surface = "any"
  new_tile.map_color = tile_data[3]
  new_tile.absorptions_per_second = {pollution = 0} --default 0.000030

  if key == "oil-ocean-deep" then
    new_tile.absorptions_per_second = {pollution = 0.000030} --default 0.000030
    new_tile.variants = tile_variations_template_with_transitions(
      "__biological-machines-planet-balack__/graphics/tiles/balack-oil-ocean-deep.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
        [4] = { probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
      }
    )
    new_tile.fluid = "bm-oil-sludge"
    new_tile.effect = "balack-oil-deep"
    new_tile.collision_mask = tile_collision_masks.oil_ocean_shallow()
  else
    new_tile.absorptions_per_second = { pollution = 0 } --default 0.000030
    new_tile.variants.material_background.picture = tile_data[4]
    if key == "oil-ocean-shallow" then
      new_tile.fluid = "bm-oil-sludge"
    end
  end
  data:extend({new_tile})
end



data:extend({
  {
    type = "tile-effect",
    name = "balack-oil-deep",
    shader = "water",
    water =
    {
      shader_variation = "oil",
      textures =
      {
        {
          filename = "__space-age__/graphics/terrain/oilNoise.png",
          width = 512,
          height = 512
        },
        {
          filename = "__biological-machines-planet-balack__/graphics/tiles/balack-oil-ocean-deep-shader.png",
          width = 512 * 4,
          height = 512 * 2
        },
        --gradient map for thin film effect
        {
          filename = "__space-age__/graphics/terrain/oilGradient.png",
          width = 512,
          height = 32
        },
        --specular highligts
        {
          filename = "__biological-machines-planet-balack__/graphics/tiles/balack-oil-ocean-deep-spec.png",
          width = 512 * 4,
          height = 512 * 2
        },
      },
      texture_variations_columns = 1,
      texture_variations_rows = 1,
      secondary_texture_variations_columns = 4,
      secondary_texture_variations_rows = 2,

      specular_lightness = { 3, 3, 3 },
      --foam_color = {140,60,60}, -- #4e3838ff,
      foam_color = {80,60,60}, -- #4e3838ff,
      foam_color_multiplier = 0.1,

      animation_speed = 1.500,
      animation_scale = {3, 3},

      dark_threshold = {2.000, 2.000},
      reflection_threshold = {5.00, 5.00},
      specular_threshold = {0.000, 0.000},
      tick_scale = 1.000,

      near_zoom = 0.063,
      far_zoom = 0.063,
    }
  },
  {
    type = "tile",
    name = "bm-bio-cube-pool",
    order = "d[yumako]-c[natural-yumako-soil]",
    subgroup = "gleba-tiles",
    --collision_mask = {layers = {ground_tile = true, bm_bio_cube_pool = true}},
    collision_mask = {layers = {bm_bio_cube_pool = true}},
    --autoplace = {probability_expression = "1000 * (abs(bm_balack_ox) < 3) * (abs(bm_balack_oy) < 3)"},
    autoplace = {probability_expression = "bm_bio_cube_pool"},
    --autoplace = {probability_expression = "0"},
    --layer_group = "ground-natural",
    layer_group = "ground-artificial",
    --layer = 85,
    layer = 185,
    searchable = true,

    transitions = lava_stone_transitions,
    transitions_between_transitions = data.raw["tile"]["landfill"].transitions_between_transitions,
    --trigger_effect = tile_trigger_effects.landfill_trigger_effect(),

    sprite_usage_surface = "any",
    variants = tile_variations_template_with_transitions_and_effect_map(
      "__biological-machines-planet-balack__/graphics/tiles/bio-cube-pool.png",
      "__space-age__/graphics/terrain/effect-maps/water-gleba-mask.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
        [4] = { probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
      }
    ),

    walking_sound = tile_sounds.walking.semi_wet,
    landing_steps_sound = tile_sounds.landing.semi_wet,
    build_sound = base_tile_sounds.building.landfill,
    map_color = {185, 166, 5},
    scorch_mark_color = {r = 0.329, g = 0.242*2, b = 0.177, a = 1.000},
  },
})
