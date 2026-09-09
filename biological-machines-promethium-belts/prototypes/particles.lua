local sounds = require("__base__.prototypes.entity.sounds")
local particle_animations = require("__space-age__/prototypes/particle-animations")

local default_smoke_trigger_effect = function()
  return
  {
    type = "create-trivial-smoke",
    smoke_name = "smoke-explosion-particle",
    starting_frame_deviation = 5,
    offset_deviation = {{-0.06, -0.06}, {0.06, 0.06}},
    speed_from_center = 0.007
  }
end

local small_smoke_trigger_effect = function()
  return
  {
    type = "create-trivial-smoke",
    smoke_name = "smoke-explosion-particle-small",
    starting_frame_deviation = 0,
    offset_deviation = {{-0.03, -0.03}, {0.03, 0.03}},
    speed_from_center = nil
  }
end

local small_grey_dust_smoke_trigger_effect = function()
  return
  {
    type = "create-trivial-smoke",
    smoke_name = "small-dust-particle-smoke",
    starting_frame_deviation = 0.5,
    offset_deviation = {{-0.03, -0.03}, {0.03, 0.03}},
    speed_from_center = 0.01,
    speed_from_center_deviation = 0.02
  }
end

local default_ended_in_water_trigger_effect = function()
  return
  {

    {
      type = "create-particle",
      probability = 1,
      affects_target = false,
      show_in_tooltip = false,
      particle_name = "tintable-water-particle",
      apply_tile_tint = "secondary",
      offset_deviation = { { -0.05, -0.05 }, { 0.05, 0.05 } },
      initial_height = 0,
      initial_height_deviation = 0.02,
      initial_vertical_speed = 0.05,
      initial_vertical_speed_deviation = 0.05,
      speed_from_center = 0.01,
      speed_from_center_deviation = 0.006,
      frame_speed = 1,
      frame_speed_deviation = 0,
      tail_length = 2,
      tail_length_deviation = 1,
      tail_width = 3,
      only_when_visible = true
    },
    {
      type = "create-particle",
      repeat_count = 10,
      repeat_count_deviation = 6,
      probability = 0.03,
      affects_target = false,
      show_in_tooltip = false,
      particle_name = "tintable-water-particle",
      apply_tile_tint = "primary",
      offsets =
      {
        { 0, 0 },
        { 0.01563, -0.09375 },
        { 0.0625, 0.09375 },
        { -0.1094, 0.0625 }
      },
      offset_deviation = { { -0.2969, -0.1992 }, { 0.2969, 0.1992 } },
      initial_height = 0,
      initial_height_deviation = 0.02,
      initial_vertical_speed = 0.053,
      initial_vertical_speed_deviation = 0.005,
      speed_from_center = 0.02,
      speed_from_center_deviation = 0.006,
      frame_speed = 1,
      frame_speed_deviation = 0,
      tail_length = 9,
      tail_length_deviation = 0,
      tail_width = 1,
      only_when_visible = true
    },
    {
      type = "play-sound",
      sound = sounds.small_splash
    }
  }

end

local make_particle = function(params)

  if not params then error("No params given to make_particle function") end
  local name = params.name or error("No name given")

  local ended_in_water_trigger_effect = params.ended_in_water_trigger_effect or default_ended_in_water_trigger_effect()
  if params.ended_in_water_trigger_effect == false then
    ended_in_water_trigger_effect = nil
  end

  local particle =
  {

    type = "optimized-particle",
    name = name,

    life_time = params.life_time or (60 * 15),
    fade_away_duration = params.fade_away_duration,

    render_layer = params.render_layer or "projectile",
    render_layer_when_on_ground = params.render_layer_when_on_ground or "corpse",

    regular_trigger_effect_frequency = params.regular_trigger_effect_frequency or 2,
    regular_trigger_effect = params.regular_trigger_effect,
    ended_in_water_trigger_effect = ended_in_water_trigger_effect,

    pictures = params.pictures,
    shadows = params.shadows,
    draw_shadow_when_on_ground = params.draw_shadow_when_on_ground,

    movement_modifier_when_on_ground = params.movement_modifier_when_on_ground,
    movement_modifier = params.movement_modifier,
    vertical_acceleration = params.vertical_acceleration,

    mining_particle_frame_speed = params.mining_particle_frame_speed,

  }

  return particle

end 
  
data:extend
{
  make_particle
  {
    name = "promethium-splitter-metal-particle-medium",
    pictures = particle_animations.get_metal_particle_medium_pictures ({tint = {0.454, 0.804, 0.298, 1}}),
    shadows = particle_animations.get_metal_particle_medium_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = small_smoke_trigger_effect(),
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer = "object"
  },
  make_particle
  {
    name = "promethium-splitter-metal-particle-big",
    pictures = particle_animations.get_metal_particle_big_pictures ({tint = {0.454, 0.804, 0.298, 1}}),
    shadows = particle_animations.get_metal_particle_big_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = default_smoke_trigger_effect(),
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer = "object"
  },
  make_particle
  {
    name = "promethium-underground-belt-metal-particle-small",
    pictures = particle_animations.get_metal_particle_small_pictures ({tint = {0.497, 0.827, 0.310, 1}}),
    shadows = particle_animations.get_metal_particle_small_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect()
  },
  make_particle
  {
    name = "promethium-underground-belt-metal-particle-medium-green",
    pictures = particle_animations.get_metal_particle_medium_pictures ({tint = {0.4235, 0.827, 0.310, 1}}),
    shadows = particle_animations.get_metal_particle_medium_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = small_grey_dust_smoke_trigger_effect(),
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect()
  },
  make_particle
  {
    name = "promethium-transport-belt-metal-particle-small",
    pictures = particle_animations.get_metal_particle_small_pictures ({tint = {0.2, 0.816, 0.24, 1}}),
    shadows = particle_animations.get_metal_particle_small_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect()
  },

  make_particle
  {
    name = "promethium-transport-belt-mechanical-component-particle-medium",
    pictures = particle_animations.get_mechanical_component_particle_medium_pictures({tint = {0.859, 0.766, 0.680, 1}}),
    shadows = particle_animations.get_mechanical_component_particle_medium_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = small_grey_dust_smoke_trigger_effect(),
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect()
  },
  make_particle
  {
    name = "promethium-transport-belt-metal-particle-medium",
    pictures = particle_animations.get_metal_particle_medium_pictures ({tint = {0.2, 0.816, 0.24, 1}}),
    shadows = particle_animations.get_metal_particle_medium_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = small_grey_dust_smoke_trigger_effect(),
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect()
  }
}