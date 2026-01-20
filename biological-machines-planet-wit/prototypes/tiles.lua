--local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")


local light_rock_color = {r=0.75, g=0.75, b=0.75}
local dark_rock_color = {r=0.65, g=0.65, b=0.65}



local function tile_variations_helper(tile_graphics)
  return tile_variations_template_with_transitions(
    tile_graphics,
    {
      max_size = 4,
      [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
      [2] = { probability = 1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
      [4] = { probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
    }
  )
end

local function wit_dust()
  return {layers = {
    bm_fluid = true,
    --water_tile = true,
    --item=true, -- allow egg items in water
    --resource = true,
    --object = true,
    --floor = true,
    --doodad=true
  }}
end

local wit_ash_light = util.table.deepcopy(data.raw["tile"]["volcanic-ash-light"])
wit_ash_light.name = "bm-wit-ash-light"
wit_ash_light.subgroup = "bm-wit-tiles"
wit_ash_light.autoplace = {probability_expression = "wit_ash_light_range"}
wit_ash_light.sprite_usage_surface = "any"
wit_ash_light.variants = tile_variations_helper("__biological-machines-planet-wit__/graphics/tiles/wit-ash-light.png")
wit_ash_light.walking_speed_modifier = 1.3
wit_ash_light.vehicle_friction_modifier = 0.8
wit_ash_light.map_color = light_rock_color

local wit_ash_flats = util.table.deepcopy(data.raw["tile"]["volcanic-ash-flats"])
wit_ash_flats.name = "bm-wit-ash-flats"
wit_ash_flats.subgroup = "bm-wit-tiles"
wit_ash_flats.autoplace = {probability_expression = "wit_ash_flats_range"}
wit_ash_flats.sprite_usage_surface = "any"
wit_ash_flats.variants = tile_variations_helper("__biological-machines-planet-wit__/graphics/tiles/wit-ash-flats.png")
wit_ash_flats.walking_speed_modifier = 1.3
wit_ash_flats.vehicle_friction_modifier = 0.8
wit_ash_flats.map_color = light_rock_color

local wit_ash_dark = util.table.deepcopy(data.raw["tile"]["volcanic-ash-flats"])
wit_ash_dark.name = "bm-wit-ash-dark"
wit_ash_dark.subgroup = "bm-wit-tiles"
wit_ash_dark.autoplace = {probability_expression = "wit_ash_dark_range"}
wit_ash_dark.sprite_usage_surface = "any"
wit_ash_dark.variants = tile_variations_helper("__biological-machines-planet-wit__/graphics/tiles/wit-ash-dark.png")
wit_ash_dark.walking_speed_modifier = 0.9
wit_ash_dark.vehicle_friction_modifier = 8
wit_ash_dark.fluid = "bm-glass-dust"
wit_ash_dark.default_cover_tile = "landfill"
wit_ash_dark.layer = 3
wit_ash_dark.layer_group = "water-overlay"
--wit_ash_dark.collision_mask = tile_collision_masks.ground()
wit_ash_dark.collision_mask = wit_dust()
wit_ash_dark.map_color = dark_rock_color

local wit_ash_cracks = util.table.deepcopy(data.raw["tile"]["volcanic-ash-flats"])
wit_ash_cracks.name = "bm-wit-ash-cracks"
wit_ash_cracks.subgroup = "bm-wit-tiles"
wit_ash_cracks.autoplace = {probability_expression = "wit_ash_cracks_range"}
wit_ash_cracks.sprite_usage_surface = "any"
wit_ash_cracks.variants = tile_variations_helper("__biological-machines-planet-wit__/graphics/tiles/wit-ash-cracks.png")
wit_ash_cracks.walking_speed_modifier = 0.9
wit_ash_cracks.vehicle_friction_modifier = 8
wit_ash_cracks.fluid = "bm-glass-dust"
wit_ash_cracks.default_cover_tile = "landfill"
wit_ash_cracks.layer = 3
wit_ash_cracks.layer_group = "water-overlay"
--wit_ash_cracks.collision_mask = tile_collision_masks.ground()
wit_ash_cracks.collision_mask = wit_dust()
wit_ash_cracks.map_color = dark_rock_color

data:extend({wit_ash_light, wit_ash_flats, wit_ash_dark, wit_ash_cracks})

table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "bm-wit-ash-dark")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "bm-wit-ash-cracks")
