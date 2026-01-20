local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local particle_animations = require("__space-age__/prototypes/particle-animations")
local base_sounds = require("__base__.prototypes.entity.sounds")



local ch = require("__biological-machines-planet-balack__.color-helper")



local pentapod_upper_leg_dying_trigger_effect_positions = { 0.2, 0.4, 0.6, 0.8, 1.0 }
local pentapod_lower_leg_dying_trigger_effect_positions = { 0.25, 0.5, 0.75, 1.0 }

local stomper_leg_part_template_layers =
{
  top_end =
  {
    { key = "top_end", row = 1 },
    { key = "top_end_shadow", row = 1, draw_as_shadow = true },
    { key = "top_end_tint", row = 1},
    --{ key = "top_end", row = 3, apply_runtime_tint = true },
    { key = "reflection_top_end", row = 1, draw_as_water_reflection = true }
  },
  middle =
  {
    { key = "middle", row = 1 },
    { key = "middle_shadow", row = 1, draw_as_shadow = true },
    { key = "middle_tint", row = 1},
    { key = "reflection_middle", row = 1, draw_as_water_reflection = true }
  },

  bottom_end =
  {
    { key = "bottom_end", row = 1 },
    { key = "bottom_end_shadow", row = 1, draw_as_shadow = true },
    { key = "bottom_end_tint", row = 1},
    --{ key = "bottom_end", row = 3, apply_runtime_tint = true },
    { key = "reflection_bottom_end", row = 1, draw_as_water_reflection = true }
  }
}

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
      tail_width = 3
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
      tail_width = 1
    },
    {
      type = "play-sound",
      sound = base_sounds.small_splash
    }
  }

end



local function make_balack_stomper(prefix, scale, health, damage, speed, tints, factoriopedia_simulation, sounds)
  local tint_mask = tints.mask
  local tint_mask_thigh = tints.mask_thigh or tint_mask
  local tint_mask_head = tints.mask_head or tint_mask
  local tint_body = tints.body
  local tint_body_thigh = tints.body_thigh or tint_body
  local tint_body_head = tints.body_head or tint_body

  local stomper_scale = 1.1 * scale
  local stomper_head_size = 0.75
  local stomper_head_render_layer = "under-elevated"
  local stomper_leg_thickness = 2
  local stomper_leg_ground_position = {0, -7 * scale} -- foot natural position
  local stomper_leg_mount_position = {0, -1.1 * scale} -- hip
  local stomper_hip_flexibility = 0.75
  local stomper_knee_distance_factor = 0.55
  local stomper_knee_height = 0.5 -- tiles, in screen space, above the straight line between the leg's mount point and leg position
  local stomper_ankle_height = 0.65
  local stomper_leg_orientations = {0.90, 0.70, 0.50, 0.30, 0.10}
  local stomper_speed = speed
  local stomper_stomp_radius = 4.5 * scale
  local stomper_stomp_damage_multiplier = 3.5
  local stomper_parts_offset_upper = -0.25
  local stomper_parts_offset_lower = -0.33
  local stomper_resistances =
  {
    {
      type = "physical",
      decrease = 2,
      percent = 50
    },
    {
      type = "laser",
      percent = 80
    },
    {
      type = "impact",
      percent = 80
    }
  }

  local stomper_spit_tint1 = {0.3, 0.2, 0.06, 1}
  local stomper_spit_tint2= {0.7, 0.12, 0.45, 0.75}

  stream_tint_stomper = {0.6, 0.582, 0.517, 1}
  splash_tint_stomper = {0.6, 0.512, 0.592, 1}
  sticker_tint_stomper = {r = 0.314, g =  0.291, b =0.269, a = 0.745}
  data:extend(
  {
    acid_stream({
      name = prefix .. "acid-stream-stomper",
      scale = scale_spitter_behemoth * scale,
      tint = stream_tint_stomper,
      corpse_name = prefix .. "acid-splash-stomper",
      spit_radius = stream_radius_spitter_behemoth * scale,
      particle_spawn_interval = 1,
      particle_spawn_timeout = 6,
      splash_fire_name = prefix .. "acid-splash-fire-stomper",
      sticker_name = prefix .. "acid-sticker-stomper"
    }),
    acid_splash_fire({
      name = prefix .. "acid-splash-fire-stomper",
      scale = scale_spitter_behemoth * scale,
      tint = splash_tint_stomper,
      ground_patch_scale = scale_spitter_behemoth * ground_patch_scale_modifier * scale,
      patch_tint_multiplier = patch_opacity,
      splash_damage_per_tick = damage_splash_spitter_behemoth * damage,
      sticker_name = prefix .. "acid-sticker-stomper"
    }),
    acid_sticker({
      name = prefix .. "acid-sticker-stomper",
      tint = sticker_tint_stomper,
      slow_player_movement = 0.6,
      slow_vehicle_speed = 0.3,
      slow_vehicle_friction = 1.5,
      damage_interval = 10,
      damage_per_tick = 10,
      slow_seconds = 2
    })
  })

  local stomper_graphics_definitions =
  {
    icon = "__biological-machines-planet-balack__/graphics/" .. prefix .. "stomper.png",
    body =
    {
      base_animation = nil, -- intentionally undefined so that stomper orientations are based on animation's orientations
      shadow_base_animation = nil,
      animation =
      {
        layers =
        {
          util.sprite_load("__space-age__/graphics/entity/stomper/torso/head-main",
          {
            scale=0.5*stomper_head_size*stomper_scale,
            direction_count=64,
            --multiply_shift=0.0,
            shift = util.by_pixel( 0, -32.0),
            tint_as_overlay = true,
            tint = tint_body,
            surface = "gleba",
            usage = "enemy"
          }),
          util.sprite_load("__space-age__/graphics/entity/stomper/torso/head-mask",
          {
            scale=0.5*stomper_head_size*stomper_scale,
            direction_count=64,
            --multiply_shift=0.0,
            shift = util.by_pixel( 0, -32.0),
            tint_as_overlay = true,
            tint = tint_mask,
            surface = "gleba",
            usage = "enemy"
          }),
        }
      },
      shadow_animation =
      {
      layers =
        {
          util.sprite_load("__space-age__/graphics/entity/stomper/torso/head-shadow",
          {
            scale=0.5*stomper_head_size*stomper_scale,
            direction_count=64,
            --multiply_shift=0.0,
            shift = util.by_pixel( 0, -22.0),
            surface = "gleba",
            usage = "enemy"
          }),
        }
      },
      water_reflection =
      {
        pictures =
        {
          filename = "__space-age__/graphics/entity/stomper/torso/stomper-body-water-reflection.png",
          width = 448,
          height = 448,
          variation_count = 1,
          scale = 0.5 * stomper_scale,
          shift = util.by_pixel(0 * stomper_scale, 0 * stomper_scale)
        }
      },
      render_layer = stomper_head_render_layer,
      base_render_layer = "higher-object-above",
    },
    leg_lower_part =
    {
      layers = stomper_leg_part_template_layers,

      graphics_properties =
      {
        middle_offset_from_top = stomper_parts_offset_upper, -- offset length in tiles (= px / 32)
        middle_offset_from_bottom = stomper_parts_offset_upper,
        top_end_offset = 0,
        bottom_end_offset = -0.5,
        -- if sum of top_end_length and bottom_end_length is greater than length of leg segment, sprites will start to get squashed
        top_end_length = 0.3,
        bottom_end_length = 0.1
      },

      top_end =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-shin-knee",
      {
        scale=0.0,
        direction_count=16,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_body,
        surface = "gleba",
        usage = "enemy"
      }),

      middle =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-shin",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_body,
        surface = "gleba",
        usage = "enemy"
      }),

      middle_shadow =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-shin-shadow",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        surface = "gleba",
        usage = "enemy"
      }),

      middle_tint =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-shin-mask",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay=true,
        tint = tint_mask,
        surface = "gleba",
        usage = "enemy"
      }),

      bottom_end =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-shin-foot",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_body,
        surface = "gleba",
        usage = "enemy"
      }),
      bottom_end_tint =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-shin-foot-mask",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_mask,
        surface = "gleba",
        usage = "enemy"
      }),

      reflection_top_end =
      {
        filename = "__space-age__/graphics/entity/stomper/legs/stomper-legs-lower-end-A-water-reflection.png",
        width = 56,
        height = 110,
        line_length = 1,
        direction_count = 1,
        scale = 0.0,
        shift = util.by_pixel(1 * 0.5, 34 * 0.5),
        surface = "gleba",
        usage = "enemy"
      },

      reflection_middle =
      {
        filename = "__space-age__/graphics/entity/stomper/legs/stomper-legs-lower-stretchable-water-reflection.png",
        width = 144,
        height = 384,
        line_length = 1,
        direction_count = 1,
        scale = 0.25,
        shift = util.by_pixel(1 * 0.5, 0),
        surface = "gleba",
        usage = "enemy"
      },

      reflection_bottom_end =
      {
        filename = "__space-age__/graphics/entity/stomper/legs/stomper-legs-lower-end-B-water-reflection.png",
        width = 52,
        height = 104,
        line_length = 1,
        direction_count = 1,
        scale = 0.0,
        shift = util.by_pixel(0, -38 * 0.5),
        surface = "gleba",
        usage = "enemy"
      }
    },
    leg_upper_part =
    {
      layers = stomper_leg_part_template_layers,

      graphics_properties =
      {
        middle_offset_from_top = stomper_parts_offset_lower, -- offset length in tiles (= px / 32)
        middle_offset_from_bottom = stomper_parts_offset_lower,
        top_end_offset = -0.5,
        bottom_end_offset = 0,
        -- if sum of top_end_length and bottom_end_length is greater than length of leg segment, sprites will start to get squashed
        top_end_length = 0.4,
        bottom_end_length = 0.1
      },

      top_end =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-thigh-body",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_body_thigh,
        surface = "gleba",
        usage = "enemy"
      }),
      top_end_shadow =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-thigh-body-shadow",
      {
        scale=0.0,
        direction_count=32,
        multiply_shift=0,
        surface = "gleba",
        usage = "enemy"
      }),
      top_end_tint =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-thigh-body-mask",
      {
        scale=0.0,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_mask_thigh,
        surface = "gleba",
        usage = "enemy"
      }),

      middle =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-thigh",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_body_thigh,
        surface = "gleba",
        usage = "enemy"
      }),

      middle_shadow =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-thigh-shadow",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        surface = "gleba",
        usage = "enemy"
      }),

      middle_tint =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-thigh-mask",
      {
        scale=0.25,
        direction_count=32,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_mask_thigh,
        surface = "gleba",
        usage = "enemy"
      }),

      bottom_end =
      util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-thigh-knee",
      {
        scale=0.0,
        direction_count=16,
        multiply_shift=0,
        tint_as_overlay = true,
        tint = tint_body,
        surface = "gleba",
        usage = "enemy"
      }),

      reflection_top_end =
      {
        filename = "__space-age__/graphics/entity/stomper/legs/stomper-legs-upper-end-A-water-reflection.png",
        width = 64,
        height = 96,
        line_length = 1,
        direction_count = 1,
        scale = 0.0,
        shift = util.by_pixel(1 * 0.5, 31 * 0.5),
        surface = "gleba",
        usage = "enemy"
      },

      reflection_middle =
      {
        filename = "__space-age__/graphics/entity/stomper/legs/stomper-legs-upper-stretchable-water-reflection.png",
        width = 146,
        height = 359,
        line_length = 1,
        direction_count = 1,
        scale = 0.25,
        shift = util.by_pixel(-4 * 0.5, 0),
        surface = "gleba",
        usage = "enemy"
      },

      reflection_bottom_end =
      {
        filename = "__space-age__/graphics/entity/stomper/legs/stomper-legs-upper-end-B-water-reflection.png",
        width = 56,
        height = 74,
        line_length = 1,
        direction_count = 1,
        scale = 0.0,
        shift = util.by_pixel(1 * 0.5, -14 * 0.5),
        surface = "gleba",
        usage = "enemy"
      }
    },

    joint_render_layer = stomper_head_render_layer,
    -- these have some nuts function for a defenition which makes it very hard to add extra layers or change the rendering behaviour - I will leave as is for now
    leg_joint =
    util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-knee",
    {
      scale=0.25,
      direction_count=32,
      multiply_shift=0,
      tint_as_overlay = true,
      tint = tint_body,
      surface = "gleba",
      usage = "enemy"
    }),
    leg_joint_tint =
    util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-knee-mask",
    {
      scale=0.25,
      direction_count=32,
      multiply_shift=0,
      tint_as_overlay = true,
      tint = tint_mask,
      surface = "gleba",
      usage = "enemy"
    }),
    leg_joint_shadow =
    util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-knee",
    {
      scale=0.25,
      direction_count=32,
      multiply_shift=0,
      surface = "gleba",
      usage = "enemy"
    }),

    foot =
    util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-foot",
    {
      scale=0.25,
      direction_count=32,
      multiply_shift=0,
      --shift = util.by_pixel(0, 4),
      tint_as_overlay = true,
      tint = tint_body,
      surface = "gleba",
      usage = "enemy"
    }),
    foot_tint =
    util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-foot-mask",
    {
      scale=0.25,
      direction_count=32,
      multiply_shift=0,
      --shift = util.by_pixel(0, 4),
      tint_as_overlay = true,
      tint = tint_mask,
      surface = "gleba",
      usage = "enemy"
    }),
    foot_shadow =
    util.sprite_load("__space-age__/graphics/entity/stomper/legs/leg-foot-shadow",
    {
      scale=0.25,
      direction_count=32,
      multiply_shift=0,
      surface = "gleba",
      usage = "enemy"
    })
  }

  data:extend{
    {
      type = "spider-unit",
      name = prefix .. "stomper-pentapod",
      icon = stomper_graphics_definitions.icon,
      collision_box = {{-1.5 * scale, -1.5 * scale}, {1.5 * scale, 1.5 * scale}},
      sticker_box = {{-1.5 * scale, -1.5 * scale}, {1.5 * scale, 1.5 * scale}},
      selection_box = {{-2.5 * scale, -2.5 * scale}, {2.5 * scale, 2.5 * scale}},
      drawing_box_vertical_extension = 3,
      torso_bob_speed = 0.15,
      flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
      max_health = health,
      factoriopedia_simulation = factoriopedia_simulation,
      order = "gleba-c-stomper-"..tostring(scale),
      subgroup = "enemies",
      impact_category = "organic",
      resistances = util.table.deepcopy(stomper_resistances),
      healing_per_tick = health/500/60,
      distraction_cooldown = 300,
      min_pursue_time = 10 * 60,
      --max_pursue_time = 60 * 60,
      max_pursue_distance = 50,
      attack_parameters = spitter_behemoth_attack_parameters(
      {
        acid_stream_name = prefix .. "acid-stream-stomper",
        range = 6.5 * scale, -- similar to leg reach for stomp + radius
        min_attack_distance = 4 * scale,
        cooldown = 60,
        cooldown_deviation = 0.15,
        damage_modifier = damage,
        scale = scale_spitter_behemoth,
        tint1 = tint_body,
        tint2 = tint_mask,
        roarvolume = 0.8,
        range_mode = "bounding-box-to-bounding-box"
      }),
      vision_distance = 30,
      ai_settings = util.merge(
      {
        gleba_ai_settings,
        {
          strafe_settings =
          {
            max_distance = math.abs(stomper_leg_ground_position[2]) + 3,
            ideal_distance = math.abs(stomper_leg_ground_position[2]),
            ideal_distance_tolerance = 1,
            ideal_distance_variance = 1,
            ideal_distance_importance = 0.5,
            ideal_distance_importance_variance = 0.1,
            face_target = true
          },
          size_in_group = 10
        }
      }),
      absorptions_to_join_attack = { spores = 25 },
      corpse = prefix .. "stomper-corpse",
      dying_explosion = prefix .. "stomper-pentapod-die",
      dying_trigger_effect =
      {
        {
          type = "create-entity",
          check_buildability = true,
          entity_name = prefix .. "stomper-shell",
          offsets = {{0, -0.94}}
        },
        {
          type = "create-entity",
          entity_name = prefix .. "wriggler-pentapod-premature",
          find_non_colliding_position = true,
          offsets =
          {
            util.rotate_position({0,1}, 0.1),
            util.rotate_position({0,1}, 0.3),
            util.rotate_position({0,1}, 0.5),
            util.rotate_position({0,1}, 0.7),
            util.rotate_position({0,1}, 0.9),
            --[[util.rotate_position({0,2}, 0.0),
            util.rotate_position({0,2}, 0.05),
            util.rotate_position({0,2}, 0.1),
            util.rotate_position({0,2}, 0.15),
            util.rotate_position({0,2}, 0.2),
            util.rotate_position({0,2}, 0.25),
            util.rotate_position({0,2}, 0.3),
            util.rotate_position({0,2}, 0.35),
            util.rotate_position({0,2}, 0.4),
            util.rotate_position({0,2}, 0.45),
            util.rotate_position({0,2}, 0.5),
            util.rotate_position({0,2}, 0.55),
            util.rotate_position({0,2}, 0.6),
            util.rotate_position({0,2}, 0.65),
            util.rotate_position({0,2}, 0.7),
            util.rotate_position({0,2}, 0.75),
            util.rotate_position({0,2}, 0.8),
            util.rotate_position({0,2}, 0.85),
            util.rotate_position({0,2}, 0.9),
            util.rotate_position({0,2}, 0.95),]]
          }
        },
      },
      dying_sound = sounds.dying_sound,
      damaged_trigger_effect = gleba_hit_effects(),
      is_military_target = true,
      working_sound = sounds.working_sound,
      warcry = sounds.warcry,
      height = 0.7,
      torso_rotation_speed = 0.01,
      graphics_set = stomper_graphics_definitions.body,
      spider_engine =
      {
        walking_group_overlap = 0.6,
        legs =
        {
          {
            leg = prefix .. "stomper-pentapod-leg",
            mount_position = util.rotate_position(stomper_leg_mount_position, stomper_leg_orientations[1]),
            ground_position = util.rotate_position(stomper_leg_ground_position, stomper_leg_orientations[1]),
            walking_group = 1,
            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger(),
            leg_hit_the_ground_when_attacking_trigger = get_leg_hit_the_ground_when_attacking_trigger(stomper_stomp_radius, stomper_stomp_damage_multiplier * damage, sounds.stomp),
          },
          {
            leg = prefix .. "stomper-pentapod-leg",
            mount_position = util.rotate_position(stomper_leg_mount_position, stomper_leg_orientations[2]),
            ground_position = util.rotate_position(stomper_leg_ground_position, stomper_leg_orientations[2]),
            walking_group = 3,
            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger(),
            leg_hit_the_ground_when_attacking_trigger = get_leg_hit_the_ground_when_attacking_trigger(stomper_stomp_radius, stomper_stomp_damage_multiplier * damage, sounds.stomp),
          },
          {
            leg = prefix .. "stomper-pentapod-leg",
            mount_position = util.rotate_position(stomper_leg_mount_position, stomper_leg_orientations[3]),
            ground_position = util.rotate_position(stomper_leg_ground_position, stomper_leg_orientations[3]),
            walking_group = 5,
            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger(),
            leg_hit_the_ground_when_attacking_trigger = get_leg_hit_the_ground_when_attacking_trigger(stomper_stomp_radius, stomper_stomp_damage_multiplier * damage, sounds.stomp),
          },
          {
            leg = prefix .. "stomper-pentapod-leg",
            mount_position = util.rotate_position(stomper_leg_mount_position, stomper_leg_orientations[4]),
            ground_position = util.rotate_position(stomper_leg_ground_position, stomper_leg_orientations[4]),
            walking_group = 2,
            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger(),
            leg_hit_the_ground_when_attacking_trigger = get_leg_hit_the_ground_when_attacking_trigger(stomper_stomp_radius, stomper_stomp_damage_multiplier * damage, sounds.stomp),
          },
          {
            leg = prefix .. "stomper-pentapod-leg",
            mount_position = util.rotate_position(stomper_leg_mount_position, stomper_leg_orientations[5]),
            ground_position = util.rotate_position(stomper_leg_ground_position, stomper_leg_orientations[5]),
            walking_group = 4,
            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger(),
            leg_hit_the_ground_when_attacking_trigger = get_leg_hit_the_ground_when_attacking_trigger(stomper_stomp_radius, stomper_stomp_damage_multiplier * damage, sounds.stomp),
          },
        },
      }
    },
    {
      type = "corpse",
      name = prefix .. "stomper-corpse",
      icon = stomper_graphics_definitions.icon,
      flags = {"placeable-neutral", "not-on-map"},
      hidden_in_factoriopedia = true,
      subgroup = "corpses",
      final_render_layer = "corpse",
      --animation_render_layer = "entity",
      order = "a-l-a",
      selection_box = {{-3, -3}, {3, 3}},
      collision_box = {{-2, -2}, {2, 2}},
      tile_width = 3,
      tile_height = 3,
      selectable_in_game = false,
      time_before_removed = 60 * 60,
      remove_on_tile_placement = true,
      decay_frame_transition_duration = 50,
      use_decay_layer = true,
      water_reflection =
      {
        pictures =
        --for some reason these load only the 2nd variant of corpses, so that variant is prioritised for water reflections
        {
          {
            filename = "__space-age__/graphics/entity/stomper/stomper-corpse-effect-map-2.png",
            width = 189,
            height = 134,
            shift = util.by_pixel(-5,0),
            --frame_count = 1,
            scale = 0.4 * 4 * stomper_scale,
            usage = "player"
          },
          {
            filename = "__space-age__/graphics/entity/stomper/stomper-corpse-effect-map-1.png",
            width = 189,
            height = 134,
            shift = util.by_pixel(0,0),
            --frame_count = 1,
            scale = 0.4 * 4 * stomper_scale,
            usage = "player"
          },

        }
      },
      animation =
      {
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-1",
            {
              frame_count = 1,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              surface = "gleba",
              usage = "enemy"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-1-mask",
            {
              frame_count = 1,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              tint = tint_mask,
              tint_as_overlay = true,
              surface = "gleba",
              usage = "enemy"
            }),
          },
        },
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-2",
            {
              frame_count = 1,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              surface = "gleba",
              usage = "enemy"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-2-mask",
            {
              frame_count = 1,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              tint = tint_mask,
              tint_as_overlay = true,
              surface = "gleba",
              usage = "enemy"
            }),
          },
        },
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-3",
            {
              frame_count = 1,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              surface = "gleba",
              usage = "enemy"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-3-mask",
            {
              frame_count = 1,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              tint = tint_mask,
              tint_as_overlay = true,
              surface = "gleba",
              usage = "enemy"
            }),
          }
        }
      },
      decay_animation =
      {
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-1",
            {
              frame_count = 16,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              flags = {"corpse-decay"},
              surface = "gleba",
              usage = "corpse-decay"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-1-mask",
            {
              frame_count = 16,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              tint = tint_mask,
              tint_as_overlay = true,
              flags = {"corpse-decay"},
              surface = "gleba",
              usage = "corpse-decay"
            }),
          },
        },
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-2",
            {
              frame_count = 16,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              flags = {"corpse-decay"},
              surface = "gleba",
              usage = "corpse-decay"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-2-mask",
            {
              frame_count = 16,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              tint = tint_mask,
              tint_as_overlay = true,
              flags = {"corpse-decay"},
              surface = "gleba",
              usage = "corpse-decay"
            }),
          }
        },
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-3",
            {
              frame_count = 16,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              flags = {"corpse-decay"},
              surface = "gleba",
              usage = "corpse-decay"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-3-mask",
            {
              frame_count = 16,
              scale = 0.4 * stomper_scale,
              shift = util.by_pixel(0, 0),
              direction_count = 1,
              tint = tint_mask,
              tint_as_overlay = true,
              flags = {"corpse-decay"},
              surface = "gleba",
              usage = "corpse-decay"
            }),
          }
        }
      }
    },
    {
      type = "simple-entity",
      name = prefix .. "stomper-shell",
      flags = {"placeable-neutral", "placeable-off-grid"},
      icon = stomper_graphics_definitions.icon,
      subgroup = "grass",
      order = "b[decorative]-l[rock]-c[gleba]-c[stomper-shell]",
      collision_mask = {layers = {item=true, object=true, player=true, is_object=true, is_lower_object=true, ghost=true}},
      collision_box = {{-1.8 * stomper_scale, -1.45 * stomper_scale}, {1.8 * stomper_scale, 1.45 * stomper_scale}},
      selection_box = {{-1.85 * stomper_scale, -1.5 * stomper_scale}, {1.85 * stomper_scale, 1.5 * stomper_scale}},
      damaged_trigger_effect = hit_effects.rock(),
      render_layer = "object",
      max_health = health/10,
      resistances =
      {
        {
          type = "poison",
          percent = 100
        },
        {
          type = "fire",
          percent = 100
        }
      },
      created_effect =
      { -- If the shell is created then the original corpse gets removed by entity creation. Put it back.
        type = "direct",
        action_delivery = {
          type = "instant",
          source_effects = {
            {
              type = "create-entity",
              check_buildability = false,
              entity_name = prefix .. "stomper-corpse",
              offsets = {{0, 0}}
            }
          }
        }
      },
      minable =
      {
        mining_particle = "stone-particle",
        mining_time = 2,
        results =
        {
          {type = "item", name = "stone", amount_min = 1, amount_max = 10},
          {type = "item", name = "spoilage", amount_min = 1, amount_max = 10},
          {type = "item", name = "pentapod-egg", amount_min = 0, amount_max = 1, percent_spoiled = 0.5},
        }
      },
      map_color = {129, 105, 78},
      count_as_rock_for_filtered_deconstruction = true,
      mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
      impact_category = "stone",
      pictures =
      {
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              surface = "gleba",
              usage = "enemy"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-mask",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              tint = tint_mask,
              tint_as_overlay = true,
              surface = "gleba",
              usage = "enemy"
            })
          }
        },
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              y = 332,
              surface = "gleba",
              usage = "enemy"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-mask",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              tint = tint_mask,
              tint_as_overlay = true,
              y = 330,
              surface = "gleba",
              usage = "enemy"
            })
          }
        },
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              y = 332 * 2,
              surface = "gleba",
              usage = "enemy"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-mask",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              tint = tint_mask,
              tint_as_overlay = true,
              y = 330 * 2,
              surface = "gleba",
              usage = "enemy"
            })
          }
        },
        {
          layers =
          {
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              y = 332 * 3,
              surface = "gleba",
              usage = "enemy"
            }),
            util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-mask",
            {
              scale = 0.5 * stomper_scale,
              shift = util.by_pixel(0,0),
              tint = tint_mask,
              tint_as_overlay = true,
              y = 330 * 3,
              surface = "gleba",
              usage = "enemy"
            })
          }
        },
      },
      water_reflection =
      {
        pictures = {
        {
          filename = "__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map-1.png",
          width = 78,
          height = 63,
          shift = util.by_pixel(-4,10),
          scale = 2  * stomper_scale
        },
        {
          filename = "__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map-2.png",
          width = 79,
          height = 59,
          shift = util.by_pixel(3,10),
          scale = 2  * stomper_scale
        },
        {
          filename = "__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map-3.png",
          width = 86,
          height = 68,
          shift = util.by_pixel(0,15),
          scale = 2  * stomper_scale
        },
        {
          filename = "__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map-4.png",
          width = 82,
          height = 77,
          shift = util.by_pixel(-4,10),
          scale = 2  * stomper_scale
        }
      }
        --[[
        pictures =
          {
            {
                util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map",
                {
                  scale = 0.5 * stomper_scale,
                  shift = util.by_pixel(0,0),
                  surface = "gleba",
                  usage = "enemy"
                }),
            },
            {
                util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map",
                {
                  scale = 0.5 * stomper_scale,
                  shift = util.by_pixel(0,0),
                  y = 332,
                  surface = "gleba",
                  usage = "enemy"
                }),
            },
            {
                util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map",
                {
                  scale = 0.5 * stomper_scale,
                  shift = util.by_pixel(0,0),
                  y = 332 * 2,
                  surface = "gleba",
                  usage = "enemy"
                }),
            },
            {
                util.sprite_load("__space-age__/graphics/entity/stomper/stomper-corpse-head-effect-map",
                {
                  scale = 0.5 * stomper_scale,
                  shift = util.by_pixel(0,0),
                  y = 332 * 3,
                  surface = "gleba",
                  usage = "enemy"
                }),
            }
          },
          ]]
      },
    },
    make_leg(prefix .. "stomper-pentapod-leg", stomper_scale, stomper_leg_thickness, stomper_speed, stomper_graphics_definitions, sounds,
    {
      hip_flexibility = stomper_hip_flexibility,
      knee_height = stomper_knee_height, -- distance from torso, as multiplier of leg length
      knee_distance_factor = stomper_knee_distance_factor, -- tiles, in screen space, above the ground that the knee naturally rests at
      ankle_height = stomper_ankle_height, -- tiles, in screen space, above the ground, the point at which the leg connects to the foot
      upper_leg_dying_trigger_effects = make_pentapod_leg_dying_trigger_effects(prefix .. "stomper-pentapod-leg-die", pentapod_upper_leg_dying_trigger_effect_positions),
      lower_leg_dying_trigger_effects = make_pentapod_leg_dying_trigger_effects(prefix .. "stomper-pentapod-leg-die", pentapod_lower_leg_dying_trigger_effect_positions),
      resistances = util.table.deepcopy(stomper_resistances)
    }),
    make_particle
    {
      name = prefix .. "stomper-skin-particle-extra-small",
      life_time = 200,
      pictures = particle_animations.get_pentpod_skin_particles_small({ tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.7) }),
      shadows = particle_animations.get_pentpod_skin_particles_small({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
    make_particle
    {
      name = prefix .. "stomper-skin-particle-small",
      life_time = 250,
      pictures = particle_animations.get_pentpod_skin_particles_small({ scale = 1 * stomper_scale, tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.7) }),
      shadows = particle_animations.get_pentpod_skin_particles_small({ scale = 1 * stomper_scale, tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
    make_particle
    {
      name = prefix .. "stomper-skin-particle-medium",
      life_time = 230,
      pictures = particle_animations.get_pentpod_skin_particles_medium({ scale = 1 * stomper_scale, tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.7)}),
      shadows = particle_animations.get_pentpod_skin_particles_medium({ scale = 1 * stomper_scale, tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
    make_particle
    {
      name = prefix .. "stomper-skin-particle-big",
      life_time = 200,
      pictures = particle_animations.get_pentpod_skin_particles_big({ scale = 1.2 * stomper_scale, tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.7)}),
      shadows = particle_animations.get_pentpod_skin_particles_big({ scale = 1.2 * stomper_scale, tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
    make_particle
    {
      name = prefix .. "stomper-shell-particle-small",
      life_time = 200,
      pictures = particle_animations.get_pentpod_shell_particles_small({ tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.9)}),
      shadows = particle_animations.get_pentpod_shell_particles_small({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
    make_particle
    {
      name = prefix .. "stomper-shell-particle-medium",
      life_time = 200,
      pictures = particle_animations.get_pentpod_shell_particles_small({ scale = 1 * stomper_scale, tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.9)}),
      shadows = particle_animations.get_pentpod_shell_particles_small({ scale = 1 * stomper_scale, tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
    make_particle
    {
      name = prefix .. "stomper-shell-particle-big",
      life_time = 200,
      pictures = particle_animations.get_pentpod_shell_particles_big({ scale = 1 * stomper_scale, tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.9)}),
      shadows = particle_animations.get_pentpod_shell_particles_big({ scale = 1 * stomper_scale, tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
    {
      type = "explosion",
      name = prefix.."stomper-pentapod-die",
      created_effect = {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-trivial-smoke",
              repeat_count = 12,
              smoke_name = "stomper-steamy-gas",
              offset_deviation = { { -1.4, -1.4 }, { 1.4, 1.4 } },
              initial_height = 0.8,
              speed_from_center = 0.03,
              speed_from_center_deviation = 0.04
            },
            {
              type = "create-particle",
              repeat_count = 22,
              repeat_count_deviation = 3,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = "gleba-blood-particle-small",
              offsets =
              {
                { 0, -0.4 },
                { 0, 0.5 },
                { 0, 0.6 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.1,
              initial_vertical_speed_deviation = 0.1,
              speed_from_center = 0.15,
              speed_from_center_deviation = 0.15,
              frame_speed = 1,
              frame_speed_deviation = 0,
              tail_length = 52,
              tail_length_deviation = 25,
              tail_width = 3,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 5,
              repeat_count_deviation = 0,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = "pentapod-entrails-particle-medium",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.07,
              initial_vertical_speed_deviation = 0.05,
              speed_from_center = 0.07,
              speed_from_center_deviation = 0,
              frame_speed = 0.5,
              frame_speed_deviation = 0,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 6,
              repeat_count_deviation = 0,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = "pentapod-entrails-particle-big",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.07,
              initial_vertical_speed_deviation = 0.05,
              speed_from_center = 0.07,
              speed_from_center_deviation = 0,
              frame_speed = 0.5,
              frame_speed_deviation = 0,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 10,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-extra-small",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 1.2,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.07,
              speed_from_center_deviation = 0.1,
              frame_speed = 1,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 6,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-small",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 1.3,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.07,
              speed_from_center_deviation = 0,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 4,
              repeat_count_deviation = 0,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-medium",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 1.4,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.078,
              initial_vertical_speed_deviation = 0.05,
              speed_from_center = 0.07,
              speed_from_center_deviation = 0.1,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 3,
              repeat_count_deviation = 0,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-big",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 1.5,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.078,
              initial_vertical_speed_deviation = 0.05,
              speed_from_center = 0.07,
              speed_from_center_deviation = 0.1,
              frame_speed = 1,
              frame_speed_deviation = 0.1,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 15,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-shell-particle-small",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.6, -0.6 }, { 0.6, 0.6 } },
              initial_height = 1.6,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.078,
              initial_vertical_speed_deviation = 0.05,
              speed_from_center = 0.06,
              speed_from_center_deviation = 0.2,
              frame_speed = 1,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 12,
              repeat_count_deviation = 0,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-shell-particle-medium",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 1.5,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.078,
              initial_vertical_speed_deviation = 0.05,
              speed_from_center = 0.07,
              speed_from_center_deviation = 0,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 6,
              repeat_count_deviation = 0,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-shell-particle-big",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
              initial_height = 1.5,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.07,
              initial_vertical_speed_deviation = 0.05,
              speed_from_center = 0.05,
              speed_from_center_deviation = 0.1,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "play-sound",
              sound = base_sounds.behemoth_gore
            }
          }
        }
      },
      icon = "__base__/graphics/icons/biter-spawner-corpse.png",
      order = "a[corpse]-b[biter-spawner]",
      flags = {"not-on-map"},
      hidden = true,
      subgroup = "enemy-death-explosions",
      animations = util.empty_sprite(),
    },
    {
      type = "explosion",
      name = prefix.."stomper-pentapod-leg-die",
      created_effect = {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-particle",
              repeat_count = 4,
              repeat_count_deviation = 3,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = "gleba-blood-particle-small",
              offsets =
              {
                { 0, -0.4 },
                { 0, 0.5 },
                { 0, 0.6 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0.1,
              initial_vertical_speed = 0.02,
              initial_vertical_speed_deviation = 0.015,
              speed_from_center = 0.05,
              speed_from_center_deviation = 0.05,
              frame_speed = 1,
              frame_speed_deviation = 0,
              tail_length = 52,
              tail_length_deviation = 25,
              tail_width = 3,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 8,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-extra-small",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.02,
              speed_from_center_deviation = 0.01,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 5,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-small",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.02,
              speed_from_center_deviation = 0.01,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 2,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-medium",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.01,
              speed_from_center_deviation = 0.01,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 1,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-skin-particle-big",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.01,
              speed_from_center_deviation = 0.01,
              frame_speed = 0.5,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 2,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-shell-particle-small",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.01,
              speed_from_center_deviation = 0.01,
              frame_speed = 1,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            },
            {
              type = "create-particle",
              repeat_count = 1,
              repeat_count_deviation = 1,
              probability = 1,
              affects_target = false,
              show_in_tooltip = false,
              particle_name = prefix .. "stomper-shell-particle-medium",
              offsets =
              {
                { 0, -0.4 }
              },
              offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              initial_height = 0.5,
              initial_height_deviation = 0,
              initial_vertical_speed = 0.01,
              initial_vertical_speed_deviation = 0.01,
              speed_from_center = 0.01,
              speed_from_center_deviation = 0.01,
              frame_speed = 1,
              frame_speed_deviation = 0.2,
              rotate_offsets = false
            }
          }
        }
      },
      icon = "__base__/graphics/icons/biter-spawner-corpse.png",
      order = "a[corpse]-b[biter-spawner]",
      flags = {"not-on-map"},
      hidden = true,
      subgroup = "enemy-death-explosions",
      animations = util.empty_sprite(),
    }
  }
end



local function make_balack_wriggler(prefix, scale, health, damage, tints, factoriopedia_simulation, factoriopedia_simulation_premature, sounds)
  -- Premature version loses health so that the swarm will get removed (more efficient).
  -- Spawner-spawned versions are stable so that the area is not full of corpses.
  local tint_mask = tints.mask
  local tint_body = tints.body

  local function attack_parameters(lifesteal)
    local cooldown = 26
    return {
      ammo_category = "melee",
      ammo_type =
      {
        target_type = "entity",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
              lifesteal and {
              {
                type = "damage",
                damage = { amount = -health/50/60*cooldown * 1.1, type = "poison"} -- offsets negative regeneration when attacking
              }
            } or nil,
            target_effects =
            {
              {
                type = "damage",
                damage = { amount = 5 * damage, type = "physical"}
              },
              {
                type = "damage",
                damage = { amount = 5 * damage, type = "poison"}
              }
            }
          }
        }
      },
      animation =
      {
        layers=
        {
          wriggler_spritesheet("attack", 19, 0.48, scale, tint_body),
          wriggler_spritesheet("attack-tint", 19, 0.48, scale, tint_mask),
          wriggler_spritesheet("attack-shadow", 19, 0.48, scale),
        }
      },
      cooldown = cooldown,
      cooldown_deviation = 0.1,
      range = 1.8 * scale,
      range_mode = "bounding-box-to-bounding-box",
      sound = sounds.attack_sound,
      type = "projectile"
    }
  end

  local wriggler = {
    type = "unit",
    name = prefix .. "wriggler-pentapod-premature",
    icon = "__biological-machines-planet-balack__/graphics/".. prefix .."wriggler-premature.png",
    subgroup = "enemies",
    order = "gleba-a-wriggler-"..tostring(scale),
    factoriopedia_simulation = factoriopedia_simulation_premature,
    collision_box = {{-0.2 * scale, -0.2 * scale} , {0.2 * scale, 0.2 * scale}},
    sticker_box = {{-0.5 * scale, -0.5 * scale} , {0.5 * scale, 0.5 * scale}},
    selection_box = {{-0.9 * scale, -0.9 * scale} , {0.9 * scale, 0.9 * scale}},
    collision_mask = {layers={player=true, train=true, is_object=true}, not_colliding_with_itself=true},
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    absorptions_to_join_attack = { spores = 0 },
    ai_settings = {
      allow_try_return_to_spawner = true,
      destroy_when_commands_fail = true,
      join_attacks = false
    },
    attack_parameters = attack_parameters(true),
    corpse = prefix .. "wriggler-pentapod-corpse",
    damaged_trigger_effect = gleba_hit_effects(),
    distance_per_frame = 0.125,
    distraction_cooldown = 300,
    dying_explosion = prefix .. "wriggler-die",
    dying_sound = sounds.dying_sound,
    healing_per_tick = -health/50/60,
    impact_category = "organic",
    max_health = health,
    max_pursue_distance = 50,
    min_pursue_time = 600,
    movement_speed = 0.2 * (1 + (scale - 1) / 2),
    resistances =
    {
      {
        percent = 50,
        type = "laser"
      }
    },
    run_animation =
    {
      layers =
      {
        wriggler_spritesheet("run", 21, 0.48, scale, tint_body),
        wriggler_spritesheet("run-tint", 21, 0.48, scale, tint_mask),
        wriggler_spritesheet("run-shadow", 21, 0.48, scale),
      }
    },
    running_sound_animation_positions = {2},
    vision_distance = 20,
    water_reflection =
    {
      pictures =
      {
        filename = "__space-age__/graphics/entity/wriggler/wriggler-effect-map.png",
        height = 21,
        width= 32,
        scale = 2.5 * scale,
        variation_count = 1,
      }
    },
    walking_sound = sounds.walking_sound,
    working_sound = sounds.working_sound,
    warcry = sounds.warcry,
  }

  local wriggler_stable = table.deepcopy(wriggler)
  wriggler_stable.name = prefix .. "wriggler-pentapod"
  wriggler_stable.icon = "__biological-machines-planet-balack__/graphics/".. prefix .."wriggler.png"
  wriggler_stable.factoriopedia_simulation = factoriopedia_simulation
  wriggler_stable.healing_per_tick = health/500/60
  wriggler_stable.absorptions_to_join_attack = { spores = 2 }
  wriggler_stable.attack_parameters = attack_parameters(false)

  local wriggler_corpse =
  {
    type = "corpse",
    name = prefix .. "wriggler-pentapod-corpse",
    icon = "__biological-machines-planet-balack__/graphics/" .. prefix .. "wriggler-corpse.png",
    subgroup = "corpses",
    order = "c[corpse]-d[gleba-enemies-corpses]-d[wriggler]"..tostring(scale),
    hidden_in_factoriopedia = true,
    selection_box = {{-0.8,-0.8},{0.8,0.8}},
    selectable_in_game = false,
    animation =
    {
      layers=
      {
        wriggler_corpse_spritesheet("death", 17, 0.48, scale, tint_body),
        wriggler_corpse_spritesheet("death-tint", 17, 0.48, scale, tint_mask),
        wriggler_corpse_spritesheet("death-shadow", 17, 0.48, scale),
      }
    },
    decay_animation =
    {
      layers=
      {
        wriggler_corpse_spritesheet("decay", 9, nil, scale, tint_body),
        wriggler_corpse_spritesheet("decay-tint", 9, nil, scale, tint_mask),
        wriggler_corpse_spritesheet("decay-shadow", 9, nil, scale),
      }
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__space-age__/graphics/entity/wriggler/wriggler-effect-map.png",
        height = 21,
        width= 32,
        shift = util.by_pixel(5,-3),
        scale = 2.5 * scale,
        variation_count = 1,
      }
    },
    dying_speed = 0.015 / scale,
    decay_frame_transition_duration = 150,
    time_before_removed = 1 * 60 * 60, -- 1 minute
    use_decay_layer = true,

    direction_shuffle = {{1,2,3,16},{4,5,6,7},{8,9,10,11},{12,13,14,15}},
    shuffle_directions_at_frame = 0,
    final_render_layer = "lower-object-above-shadow",
    flags = {
      "placeable-neutral",
      "placeable-off-grid",
      "building-direction-8-way",
      "not-repairable",
      "not-on-map"
    },
    ground_patch =
    {
      sheet =
        util.sprite_load("__space-age__/graphics/entity/wriggler/blood-puddle-var-main",
          {
            flags = { "low-object" },
            variation_count = 4,
            scale = 0.4 * scale,
            multiply_shift = 0.125,
          }
        )
    },
    ground_patch_fade_in_delay = 20,
    ground_patch_fade_in_speed = 0.002,
    ground_patch_fade_out_duration = 50 * 60 / 7.5,
    ground_patch_fade_out_start = 50 * 60 / 7.5,
    ground_patch_render_layer = "decals"
  }

  local wrigger_explosion =
  {
    type = "explosion",
    name = prefix .. "wriggler-die",
    scale = 0.25,
    icon = "__space-age__/graphics/icons/medium-wriggler-corpse.png",
    order = "a[corpse]-f[wriggler]",
    flags = {"not-on-map"},
    hidden = true,
    subgroup = "enemy-death-explosions",
    animations = util.empty_sprite(),
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-particle",
            repeat_count = 13,
            repeat_count_deviation = 1,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "gleba-blood-particle-small",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            initial_height = 0.1,
            initial_height_deviation = 0.1,
            initial_vertical_speed = 0.009,
            initial_vertical_speed_deviation = 0.009,
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.05,
            frame_speed = 1,
            frame_speed_deviation = 0,
            tail_length = 5,
            tail_length_deviation = 5,
            tail_width = 3,
            rotate_offsets = false
          },
          {
            type = "create-particle",
            repeat_count = 12,
            repeat_count_deviation = 3,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "gleba-blood-particle-small",
            offsets =
            {
              { 0, -0.4 },
              { 0, 0.5 },
              { 0, 0.6 }
            },
            offset_deviation = { { -0.25, -0.25 }, { 0.25, 0.25 } },
            initial_height = 0.1,
            initial_height_deviation = 0.1,
            initial_vertical_speed = 0.055,
            initial_vertical_speed_deviation = 0.075,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.03,
            frame_speed = 1,
            frame_speed_deviation = 0,
            tail_length = 52,
            tail_length_deviation = 25,
            tail_width = 3,
            rotate_offsets = false
          },
          {
            type = "create-particle",
            repeat_count = 2,
            repeat_count_deviation = 0,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "pentapod-entrails-particle-small",
            offsets =
            {
              { 0, -0.4 }
            },
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            initial_height = 0.1,
            initial_height_deviation = 0.1,
            initial_vertical_speed = 0.06,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.07,
            speed_from_center_deviation = 0,
            frame_speed = 1,
            frame_speed_deviation = 0,
            rotate_offsets = false
          },
          {
            type = "create-particle",
            repeat_count = 10,
            repeat_count_deviation = 0,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = prefix .. "wriggler-skin-particle",
            offsets =
            {
              { 0, -0.4 }
            },
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            initial_height = 0.1,
            initial_height_deviation = 0.1,
            initial_vertical_speed = 0.05,
            initial_vertical_speed_deviation = 0.02,
            speed_from_center = 0.02,
            speed_from_center_deviation = 0.1,
            frame_speed = 1,
            frame_speed_deviation = 0,
            rotate_offsets = false
          },
          {
            type = "play-sound",
            sound = base_sounds.medium_gore
          },
        }
      }
    }
  }

  data:extend{
    wriggler,
    wriggler_stable,
    wriggler_corpse,
    wrigger_explosion,
    make_particle
    {
      name = prefix .. "wriggler-skin-particle",
      life_time = 300,
      pictures = particle_animations.get_pentpod_skin_particles_small({ scale = 1 * scale, tint = ch.lerp_color(tint_mask, {255,255,255,255}, 0.7) }),
      shadows = particle_animations.get_pentpod_skin_particles_small({ scale = 1 * scale, tint = shadowtint(), shift = util.by_pixel (1,0)}),
      ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
      render_layer_when_on_ground = "lower-object-above-shadow"
    },
  }
end



return {
  make_balack_stomper = make_balack_stomper,
  make_balack_wriggler = make_balack_wriggler,
}
