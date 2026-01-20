local resource_autoplace = require("resource-autoplace")



------------------------------------------------------------SAND
resource_autoplace.initialize_patch_set("sand", false)

data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["bm-sand"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["bm-sand"] = {}

local sand_resource = {
  type = "resource",
  name = "bm-sand",
  icon = "__biological-machines-industry__/graphics/sand.png",
  icon_size = 64,
  icon_mipmaps = 4,
  flags = {"placeable-neutral"},
  order="a-b-e",
  tree_removal_probability = 0.2,
  tree_removal_max_distance = 32 * 32,
  walking_sound = dirt_sounds,
	resource_patch_search_radius = 10,
  minable =
  {
    mining_particle = "sand-3-dust-particle",
    mining_time = 0.4,
    result = "bm-sand"
  },
  collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  autoplace = resource_autoplace.resource_autoplace_settings{
    name = "bm-sand",
    order = "c",
    base_density = 15, --6
    --base_spots_per_km2 = 6, --1.5
    has_starting_area_placement = true,
    random_spot_size_minimum = 1,
    random_spot_size_maximum = 3,
    --regular_blob_amplitude_multiplier =  1, -- 1 or 17
    regular_rq_factor_multiplier = 1.1,
    starting_rq_factor_multiplier = 1.5,
    --richness_post_multiplier = 0.01,
  },
  stage_counts = {12000, 8000, 4000, 2000, 1200, 600, 300, 100},
  stages = {
    sheet = {
      filename = "__biological-machines-industry__/graphics/sand-ore.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      frame_count = 8,
      variation_count = 8,
	scale = 0.5,
    }
  },
  effect_animation_period = 5,
  effect_animation_period_deviation = 1,
  mining_visualisation_tint = {r = 0.86, g = 0.67, b = 0.31, a = 1.000}, -- #cfff7fff
  map_color = {0.86, 0.67, 0.31}
}
sand_resource.autoplace.tile_restriction = {
  "red-desert-0", "red-desert-1", "red-desert-2", "red-desert-3",
  "dirt-1", "sand-1", "sand-2", "sand-3"
}

data:extend({sand_resource})



--------------------------------------------------------------POTASH
--resource_autoplace.initialize_patch_set("potash", true)

data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_settings["entity"].settings["bm-potash"] = {}
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_controls["bm-potash"] = {}

data.raw["planet"]["vulcanus"].map_gen_settings.property_expression_names["entity:potash:probability"] = "potash_probability"
data.raw["planet"]["vulcanus"].map_gen_settings.property_expression_names["entity:potash:richness"] = "potash_richness"

local potash_resource = {
  type = "resource",
  name = "bm-potash",
  icon = "__biological-machines-industry__/graphics/potash.png",
  icon_size = 64,
  icon_mipmaps = 4,
  flags = {"placeable-neutral"},
  order="a-b-f",
  tree_removal_probability = 0.2,
  tree_removal_max_distance = 32 * 32,
  walking_sound = dirt_sounds,
	resource_patch_search_radius = 10,
  minable =
  {
    mining_particle = "sand-3-dust-particle",
    mining_time = 0.4,
    result = "bm-potash"
  },
  collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  autoplace = {
    order = "b",
    probability_expression = 0
  },
  stage_counts = {12000, 8000, 4000, 2000, 1200, 600, 300, 100},
  stages = {
    sheet = {
      filename = "__biological-machines-industry__/graphics/potash-ore.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      frame_count = 8,
      variation_count = 8,
	scale = 0.5,
    }
  },
  effect_animation_period = 5,
  effect_animation_period_deviation = 1,
  mining_visualisation_tint = {r = 0.33, g = 0.34, b = 0.35, a = 1.000}, -- #cfff7fff
  map_color = {0.33, 0.34, 0.35}
}

--[[
potash_resource.autoplace.tile_restriction = {
  "volcanic-ash-cracks", "volcanic-ash-dark", "volcanic-ash-flats",
  "volcanic-ash-light", "volcanic-ash-soil"
}
]]

data:extend({potash_resource})
