data:extend({
  {
    type = "assembling-machine",
    name = "bm-warp-drive",
    icon = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-icon.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "bm-warp-drive"},
    max_health = 300,
    show_recipe_icon = false,
    corpse = "medium-remnants",
    impact_category = "metal",
    working_sound = {
      sound = {filename = "__space-age__/sound/entity/electromagnetic-plant/electromagnetic-plant-loop.ogg", volume = 0.7 },
      sound_accents = {
        {sound = {variations = sound_variations("__space-age__/sound/entity/electromagnetic-plant/emp-coil", 2, 0.4)}, frame = 14, audible_distance_modifier = 0.2},
        {sound = {variations = sound_variations("__space-age__/sound/entity/electromagnetic-plant/emp-electric", 5, 0.4)}, frame = 60, audible_distance_modifier = 0.2}
      },
      max_sounds_per_type = 2,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    resistances = {{type = "fire", percent = 80}},
    collision_box = {{-2.9, -2.9}, {2.9, 2.9}},
    selection_box = {{-3, -3}, {3, 3}},
    crafting_categories = {"bm-warp-drive"},
    fixed_recipe = "bm-warp",
    energy_usage = "500MW",
    crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
    },
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["electromagnetic-plant"],
    icon_draw_specification = {shift = {0, -0.55}},
    module_slots = 4,
    allowed_effects = {"consumption", "speed"},
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-hr-shadow.png",
            priority = "high",
            width = 900,
            height = 420,
            frame_count = 1,
            line_length = 1,
            repeat_count = 100,
            animation_speed = 1.5,
            shift = util.by_pixel_hr(0, -16),
            draw_as_shadow = true,
            scale = 0.5,
          },
          {
            priority = "high",
            width = 410,
            height = 410,
            frame_count = 100,
            shift = util.by_pixel_hr(0, -16),
            animation_speed = 1.5,
            scale = 0.5,
            stripes = {
              {
                filename = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-hr-animation-1.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
              {
                filename = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-hr-animation-2.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
            },
          },
        },
      },
      working_visualisations = {
        {
          fadeout = true,
          secondary_draw_order = 1,
          animation = {
            priority = "high",
            size = {410, 410},
            shift = util.by_pixel_hr(0, -16),
            frame_count = 100,
            draw_as_glow = true,
            scale = 0.5,
            animation_speed = 1.5,
            blend_mode = "additive",
            stripes = {
              {
                filename = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-hr-animation-emission-1.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
              {
                filename = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-hr-animation-emission-2.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
            },
          },
          apply_recipe_tint = "none",
        }
      },
      reset_animation_when_frozen = true,
    },
    --show_recipe_icon = true,
    surface_conditions = {{property = "pressure", min = 0, max = 0}},
  },
  {
    type = "projectile",
    name = "bm-warp",
    acceleration = 0,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "script",
          effect_id = "bm-warp"
        }
      }
    }
  },
})
