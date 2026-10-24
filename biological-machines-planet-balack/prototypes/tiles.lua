local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_sounds = require("__space-age__/prototypes/tile/tile-sounds")
local base_tile_sounds = require("__base__/prototypes/tile/tile-sounds")
--local tile_trigger_effects = require("prototypes.tile.tile-trigger-effects")

local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_spritesheet_layout = tile_graphics.tile_spritesheet_layout



--TODO
--add back transitions for tiles other than deep oil
--lighten deep oil transition



table.insert(water_tile_type_names, "bm-balack-oil-shallow")
table.insert(water_tile_type_names, "bm-balack-oil-deep")



local balack_oil_transitions =
{
  {
    to_tiles = water_tile_type_names,
    transition_group = water_transition_group_id,

    background_layer_group = "water",
    background_layer_offset = -5,
    masked_background_layer_offset = 1,
    offset_background_layer_by_tile_layer = false,
    spritesheet = "__biological-machines-planet-balack__/graphics/water-transitions/balack-oil-sand.png",
    layout = tile_spritesheet_layout.transition_16_16_16_4_8_short,
    background_enabled = false,
    background_mask_layout = tile_spritesheet_layout.simple_white_mask
  },
  {
    to_tiles = out_of_map_tile_type_names,
    transition_group = out_of_map_transition_group_id,

    background_layer_offset = 1,
    background_layer_group = "zero",
    offset_background_layer_by_tile_layer = true,

    spritesheet = "__biological-machines-planet-balack__/graphics/out-of-map-transition/balack-oil-out-of-map-transition.png",
    layout = tile_spritesheet_layout.transition_4_4_8_1_1,
    overlay_enabled = false
  }
}
local balack_oil_transitions_between_transitions =
{
  {
    transition_group1 = water_transition_group_id,
    transition_group2 = out_of_map_transition_group_id,

    background_layer_offset = 1,
    background_layer_group = "zero",
    offset_background_layer_by_tile_layer = true,

    spritesheet = "__biological-machines-planet-balack__/graphics/out-of-map-transition/balack-oil-out-of-map-transition-b.png",
    layout = tile_spritesheet_layout.transition_3_3_3_1_0,
    background_enabled = true,
    background_mask_layout = tile_spritesheet_layout.simple_3_3_3_1_0_three_way_edge_mask,
  }
}



local balack_tile_data = {
  ["oil-ocean-shallow"] = {
    name = "bm-balack-oil-shallow",
    probability = "bm_balack_oil_ocean_shallow",
    color = {25, 21, 21},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-oil-sand-8x.png",
    transitions = balack_oil_transitions,
    tbt = balack_oil_transitions_between_transitions,
  },
  ["oil-ocean-deep"] = {
    name = "bm-balack-oil-deep",
    probability = "bm_balack_oil_ocean_deep",
    color = {8, 4, 4},
  },
  ["fulgoran-rock"] = {
    name = "bm-balack-n-rock",
    probability = "0.8 + bm_balack_rock * 2 - max(0, bm_balack_mix_oil) * 6 - bm_bio_cube_pool",
    color = {38, 35, 35},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-rock.png",
  },
  ["fulgoran-dust"] = {
    name = "bm-balack-n-dust",
    probability = "bm_balack_scrap_medium + max(0, bm_balack_natural, 2 * bm_balack_mesa * bm_balack_pyramids) * 2 - 0.9 + bm_balack_rock + bm_balack_road_dust * bm_balack_sprawl - bm_bio_cube_pool",
    color = {30, 27, 27},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-dust.png",
  },
  ["fulgoran-sand"] = {
    name = "bm-balack-n-sand",
    probability = "1 - bm_balack_dunes - bm_bio_cube_pool",
    color = {26, 23, 23},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-sand.png",
  },
  ["fulgoran-dunes"] = {
    name = "bm-balack-n-dunes",
    probability = "1 + bm_balack_dunes - bm_bio_cube_pool",
    color = {34, 31, 31},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-dunes.png",
  },
  ["fulgoran-walls"] = {
    name = "bm-balack-n-walls",
    probability = "bm_balack_tile_ruin_walls - bm_bio_cube_pool",
    color = {54, 45, 45},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-walls.png",
  },
  ["fulgoran-paving"] = {
    name = "bm-balack-n-paving",
    probability = "bm_balack_tile_ruin_paving - bm_bio_cube_pool",
    color = {63, 45, 45},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-paving.png",
  },
  ["fulgoran-conduit"] = {
    name = "bm-balack-n-conduit",
    probability = "bm_balack_tile_ruin_conduit - bm_bio_cube_pool",
    color = {50, 41, 41},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-conduit.png",
  },
  ["fulgoran-machinery"] = {
    name = "bm-balack-n-machinery",
    probability = "bm_balack_tile_ruin_machinery - bm_bio_cube_pool",
    color = {46, 37, 37},
    picture = "__biological-machines-planet-balack__/graphics/tiles/balack-n-machinery.png",
  },
}
for key, tile_data in pairs(balack_tile_data) do
  local new_tile = util.table.deepcopy(data.raw["tile"][key])
  new_tile.name = tile_data.name
  new_tile.autoplace.probability_expression = tile_data.probability
  new_tile.sprite_usage_surface = "any"
  new_tile.map_color = tile_data.color
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
    --new_tile.collision_mask = tile_collision_masks.oil_ocean_shallow()
  else
    new_tile.absorptions_per_second = { pollution = 0 } --default 0.000030
    new_tile.variants.material_background.picture = tile_data.picture
    if key == "oil-ocean-shallow" then
      new_tile.fluid = "bm-oil-sludge"
    end
  end
  new_tile.transitions = tile_data.transitions
  new_tile.transitions_between_transitions = tile_data.tbt
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

      --[[
      textures = {
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
      ]]

      noise_textures =
      {
        {
          filename = "__space-age__/graphics/terrain/oilNoise.png",
          size = 512,
          color_channels = 3
        },
        --gradient map for thin film effect
        {
          filename = "__space-age__/graphics/terrain/oilGradient.png",
          width = 512,
          height = 32,
          color_channels = 3
        }
      },
      image_textures =
      {
        {
          filename = "__biological-machines-planet-balack__/graphics/tiles/balack-oil-ocean-deep-shader.png"
        },
        --specular highligts
        {
          filename = "__biological-machines-planet-balack__/graphics/tiles/balack-oil-ocean-deep-spec.png"
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
