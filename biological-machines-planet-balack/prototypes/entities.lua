local sounds = require("__base__.prototypes.entity.sounds")



local tank_t2 = util.table.deepcopy(data.raw["car"]["tank"])
tank_t2.name = "bm-tank-mk2"
tank_t2.icons = {
  {icon = "__base__/graphics/icons/tank.png"},
  {icon = "__biological-machines-k2-assets__/graphics/tier-2.png"},
}
tank_t2.icon = nil
tank_t2.minable.result = "bm-tank-mk2"
tank_t2.max_health = 4000
tank_t2.corpse = "bm-tank-mk2-remnants"
tank_t2.dying_explosion = "bm-tank-mk2-explosion"
tank_t2.alert_icon_shift = util.by_pixel(0, -13 * 1.5)
tank_t2.energy_per_hit_point = 0.25 --base 0.5
tank_t2.equipment_grid = "large-equipment-grid"
tank_t2.resistances = {
  {type = "fire", decrease = 15, percent = 80},
  {type = "physical", decrease = 15, percent = 80},
  {type = "impact", decrease = 50, percent = 98},
  {type = "explosion", decrease = 15, percent = 85},
  {type = "acid", decrease = 0, percent = 85}
}
tank_t2.collision_box = {{-0.9 * 1.5, -1.3 * 1.5}, {0.9 * 1.5, 1.3 * 1.5}}
tank_t2.selection_box = {{-0.9 * 1.5, -1.3 * 1.5}, {0.9 * 1.5, 1.3 * 1.5}}
tank_t2.energy_source = {type = "void"}
--tank_t2.effectivity = 0.9
tank_t2.braking_power = "40000kW" --base 800kW
tank_t2.consumption = "30000kW" --base 600kW
tank_t2.terrain_friction_modifier = 0.8 --base 0.2
tank_t2.friction = 0.008 --base 0.002
tank_t2.sound_no_fuel = nil
tank_t2.turret_rotation_speed = 0.50 / 60 --base 0.35 / 60
tank_t2.rotation_speed = 0.0060 --base 0.0035
tank_t2.weight = 40000
tank_t2.inventory_size = 120
tank_t2.guns = {
  "bm-tank-mk2-cannon", "bm-tank-mk2-machine-gun",
  "bm-tank-mk2-flamethrower", "bm-tank-mk2-railgun",
}
tank_t2.repair_speed_modifier = 2
tank_t2.water_reflection = car_reflection(1.2 * 1.5)

local scalable_tank_images = {
  tank_t2.light[1].picture,
  tank_t2.light[2].picture,
  tank_t2.light_animation,
  tank_t2.animation.layers[1],
  tank_t2.animation.layers[2],
  tank_t2.animation.layers[3],
  tank_t2.turret_animation.layers[1],
  tank_t2.turret_animation.layers[2],
  tank_t2.turret_animation.layers[3],
}
for _, scalable_tank_image in pairs(scalable_tank_images) do
  scalable_tank_image.scale = 1.5 * scalable_tank_image.scale
end

local tank_mk2_shift_y = 9
tank_t2.light[1].shift = {-0.1 * 1.5, (-14 + tank_mk2_shift_y / 32) * 1.5}
tank_t2.light[2].shift = {0.1 * 1.5, (-14 + tank_mk2_shift_y / 32) * 1.5}
tank_t2.light_animation.shift = util.by_pixel(-1 * 1.5, (-17 + 6) * 1.5)
tank_t2.animation.layers[1].shift = util.by_pixel(0, (-16 + tank_mk2_shift_y) * 1.5)
tank_t2.animation.layers[2].shift = util.by_pixel(0, (-27.5 + tank_mk2_shift_y) * 1.5)
tank_t2.animation.layers[3].shift = util.by_pixel(22.5 * 1.5, (1 + tank_mk2_shift_y) * 1.5)
tank_t2.turret_animation.layers[1].shift = util.by_pixel(0.25 * 1.5, (-40.5 + tank_mk2_shift_y) * 1.5)
tank_t2.turret_animation.layers[2].shift = util.by_pixel(0, (-41.5 + tank_mk2_shift_y) * 1.5)
tank_t2.turret_animation.layers[3].shift = util.by_pixel(56.25 * 1.5, (0.5 + tank_mk2_shift_y) * 1.5)

local tank_t2_remnents = util.table.deepcopy(data.raw["corpse"]["tank-remnants"])
tank_t2_remnents.name = "bm-tank-mk2-remnants"
tank_t2_remnents.selection_box = {{-1.5 * 1.5, -2.5 * 1.5}, {1.5 * 1.5, 2.5 * 1.5}}
tank_t2_remnents.tile_width = 3 * 1.5
tank_t2_remnents.tile_height = 5 * 1.5
tank_t2_remnents.animation.layers[1].scale = 0.75
tank_t2_remnents.animation.layers[1].shift = util.by_pixel(4 * 1.5, 0.5 * 1.5)
tank_t2_remnents.animation.layers[2].scale = 0.75
tank_t2_remnents.animation.layers[2].shift = util.by_pixel(6.5 * 1.5, -1.5 * 1.5)

local tank_t2_explosion = util.table.deepcopy(data.raw["explosion"]["tank-explosion"])
tank_t2_explosion.name = "bm-tank-mk2-explosion"
tank_t2_explosion.scale = 1.5

data:extend({tank_t2, tank_t2_remnents, tank_t2_explosion})



data:extend({
  {
    type = "assembling-machine",
    name = "bm-bio-cube",
    icon = "__biological-machines-planet-balack__/graphics/bio_cube/pathogen-lab-icon.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "bm-bio-cube"},
    max_health = 5000,
    --corpse = "big-remnants",
    --dying_explosion = "medium-explosion",
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["electromagnetic-plant"],
    --heating_energy = "100kW",
    --[[
    effect_receiver = {
      base_effect = {
        productivity = 0.5
      }
    },
    ]]
    icon_draw_specification = {
      shift = {0, -0.6},
      scale = 1.8,
      scale_for_many = 1,
      render_layer = "entity-info-icon"
    },
    icons_positioning = {
      {
        inventory_index = defines.inventory.assembling_machine_modules, shift = {0, 1}
      },
    },
    vehicle_impact_sound =  {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t3-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = {
        filename = "__base__/sound/idle1.ogg", volume = 0.6
      },
      apparent_volume = 1.5,
    },
    collision_box = {{-3.2, -3.2}, {3.2, 3.2}},
    selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
    drawing_box = {{-3.5, -3.5}, {3.5, 3.5}},
    fluid_boxes = {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 50,
        pipe_connections = {
          {flow_direction = "input", direction = defines.direction.north, position = {0, -3.199}},
          {flow_direction = "input", direction = defines.direction.east, position = {3.199, 0}},
          {flow_direction = "input", direction = defines.direction.south, position = {0, 3.199}},
          {flow_direction = "input", direction = defines.direction.west, position = {-3.199, 0}},
        },
        secondary_draw_orders = {north = -1}
      }
    },
    graphics_set = {
      animation = {
        layers = {
          {
            draw_as_shadow = true,
            filename = "__biological-machines-planet-balack__/graphics/bio_cube/pathogen-lab-hr-shadow.png",
            priority = "high",
            width = 900,
            height = 700,
            frame_count = 1,
            line_length = 1,
            repeat_count = 60,
            animation_speed = 0.5,
            shift = util.by_pixel_hr(0, -16),
            scale = 0.5,
          },
          {
            priority = "high",
            width = 500,
            height = 500,
            frame_count = 60,
            shift = util.by_pixel_hr(0, -16),
            animation_speed = 0.5,
            scale = 0.5,
            stripes = {
              {
                filename = "__biological-machines-planet-balack__/graphics/bio_cube/pathogen-lab-hr-animation-1.png",
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
            layers = {
              {
                size = {500, 500},
                shift = util.by_pixel_hr(0, -16),
                scale = 0.5,
                frame_count = 60,
                draw_as_glow = true,
                blend_mode = "additive",
                animation_speed = 0.5,
                stripes = {
                  {
                    filename = "__biological-machines-planet-balack__/graphics/bio_cube/pathogen-lab-hr-emission-1.png",
                    width_in_frames = 8,
                    height_in_frames = 8,
                  },
                },
              },
            },
          },
        }
      },
    },
    crafting_categories = {"bm-bio-cube"},
    crafting_speed = settings.startup["bm-cube-speed"].value,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution = settings.startup["bm-cube-pollution"].value},
    },
    energy_usage = "10MW",
    module_slots = 8,
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    match_animation_speed_to_activity = true,
    --fluid_boxes_off_when_no_fluid_recipe = true,
    tile_buildability_rules = {{
      area = {{-3, -3}, {3, 3}},
      required_tiles = {layers = {bm_bio_cube_pool = true}},
      --colliding_tiles = {layers = {ground_tile = true, water_tile = true, empty_space = true}},
    }},
    healing_per_tick = 1,
    is_military_target = true,
    damaged_trigger_effect = {
      type = "create-smoke",
      entity_name = "poison-cloud",
      probability = 0.05,
    },
    dying_trigger_effect = {
      type = "create-smoke",
      entity_name = "poison-cloud",
    },
  },
})
