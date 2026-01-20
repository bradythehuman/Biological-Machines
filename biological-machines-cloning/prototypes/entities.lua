--require ("util")
--require ("__base__.prototypes.entity.pipecovers")
--require ("circuit-connector-sprites")
--require ("__base__.prototypes.entity.assemblerpipes")
local hit_effects = require("__base__.prototypes.entity.hit-effects")



local shared_tank_data = {
  --surface_conditions = {{property = "gravity", min = 1}},
  flags = {"placeable-neutral","placeable-player", "player-creation"},
  minable = {mining_time = 0.1, result = "bm-suspension-tank"},
  max_health = 300,
  icon_draw_specification = {shift = {0, 0}},
  circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
  circuit_connector = circuit_connector_definitions.create_vector
  (
    universal_connector_template,
    {
      { variation = 18, main_offset = util.by_pixel(0, 20), shadow_offset = util.by_pixel(11, 26), show_shadow = true },
      { variation = 18, main_offset = util.by_pixel(0, 20), shadow_offset = util.by_pixel(11, 26), show_shadow = true },
      { variation = 18, main_offset = util.by_pixel(0, 20), shadow_offset = util.by_pixel(11, 26), show_shadow = true },
      { variation = 18, main_offset = util.by_pixel(0, 20), shadow_offset = util.by_pixel(11, 26), show_shadow = true }
    }
  ),
  alert_icon_shift = util.by_pixel(0, -12),
  --create_ghost_on_death = false,
  resistances =
  {
    {
      type = "fire",
      percent = 70
    }
  },
  fluid_boxes =
  {
    {
      production_type = "input",
      pipe_picture = assembler3pipepictures(),
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -1} }},
      secondary_draw_orders = { north = -1 }
    },
    {
      production_type = "output",
      pipe_picture = assembler3pipepictures(),
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {0, 1} }},
      secondary_draw_orders = { north = -1 }
    }
  },
  fluid_boxes_off_when_no_fluid_recipe = true,
  impact_category = "metal",
  open_sound = {filename = "__base__/sound/open-close/fluid-open.ogg", volume = 0.55},
  close_sound = {filename = "__base__/sound/open-close/fluid-close.ogg", volume = 0.54},
  working_sound =
  {
    sound = {filename = "__space-age__/sound/entity/biochamber/biochamber-loop.ogg", volume = 0.4},
    max_sounds_per_prototype = 3,
    fade_in_ticks = 4,
    fade_out_ticks = 20
  },
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  damaged_trigger_effect = hit_effects.entity(),
  drawing_box_vertical_extension = 0.2,
  fast_replaceable_group = "bm-suspension-tank",
  graphics_set =
  {
    animation_progress = 0.15,
    animation =
    {
      layers =
      {
        {
          filename = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-base.png",
          priority = "high",
          width = 256,
          height = 256,
          scale = 0.5,
        },
        {
          filename = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-shadow.png",
          priority = "high",
          width = 320,
          height = 256,
          scale = 0.5,
          draw_as_shadow = true,
        },
        {
          filename = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-glow.png",
          priority = "high",
          width = 256,
          height = 256,
          scale = 0.5,
          draw_as_glow = true,
          blend_mode = "additive-soft"
        },
      }
    },
    working_visualisations =
    {
      {
        fadeout = true,
        effect = "flicker",
        animation =
        {
          layers =
          {
            {

              filename = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-water-anim.png",
              priority = "high",
              width = 256,
              height = 256,
              frame_count = 32,
              line_length = 8,
              scale = 0.5,
              blend_mode = "additive"
            },
            {
              filename = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-screens-anim.png",
              priority = "high",
              width = 256,
              height = 256,
              frame_count = 32,
              line_length = 8,
              scale = 0.5,
              draw_as_glow = true,
              --blend_mode = "additive"
            },
            {
              filename = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-glow.png",
              priority = "high",
              width = 256,
              height = 256,
              repeat_count = 32,
              line_length = 1,
              scale = 0.5,
              draw_as_light = true,
              blend_mode = "additive",
              apply_runtime_tint = true,
            },
          }
        }
      },
    },
    frozen_patch =
    {
      filename = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-frozen.png",
      width = 256,
      height = 256,
      line_length = 1,
      scale = 0.5,
    },
    reset_animation_when_frozen = true,
  },
  water_reflection =
  {
    pictures =
    {
      filename = "__base__/graphics/entity/chemical-plant/chemical-plant-reflection.png",
      priority = "extra-high",
      width = 28,
      height = 36,
      shift = util.by_pixel(5, 60),
      variation_count = 4,
      scale = 5
    },
    rotate = false,
    orientation_to_variation = true
  },
  crafting_speed = 1,
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = { pollution = 2 },
    light_flicker =
    {
      color = {0,0,0},
      minimum_intensity = 0.6,
      maximum_intensity = 0.95
    },
  },
  energy_usage = "375kW",
  module_slots = 0,
  allowed_effects = {},
  heating_energy = "150kW",
}

local function make_tank_entity(unique_tank_data)
  local tank_entity = {}
  for k, v in pairs(shared_tank_data) do tank_entity[k] = v end
  for k, v in pairs(unique_tank_data) do tank_entity[k] = v end
  return tank_entity
end

data:extend({
  make_tank_entity({
    type = "assembling-machine",
    name = "bm-suspension-tank",
    icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
    localised_description = {
      "", {"entity-description.bm-suspension-tank"}, " ",
      {"entity-description.bm-suspension-tank-warning"}
    },
    crafting_categories = {"bm-suspension-tank"},
    corpse = "biochamber-remnants",
    dying_explosion = "biochamber-explosion",
  }),
  make_tank_entity({
    type = "assembling-machine",
    name = "bm-suspension-tank-filled",
    icons = {
      {
        icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
      },
      {
        icon = "__core__/graphics/icons/entity/character.png",
        scale = 0.30,
        shift = {-7, 7},
      }
    },
    localised_description = {
      "", {"entity-description.bm-suspension-tank-filled"}, " ",
      {"entity-description.bm-suspension-tank-warning"}
    },
    crafting_categories = {"bm-suspension-tank-filled"},
    fixed_recipe = "bm-clone-life-support",
    production_health_effect = {
      not_producing = -2.5 / 60, -- 5 hp per second
      producing = 2.5 / 60 -- 5 hp per second
    },
    dying_trigger_effect = {
      {
        type = "script",
        effect_id = "bm-suspended-clone-died"
      }
    },
    crafting_speed_quality_multiplier = {
      ["normal"] = 1,
      ["uncommon"] = 0.8,
      ["rare"] = 0.65,
      ["epic"] = 0.55,
      ["legendary"] = 0.4
    },
    enable_logistic_control_behavior = false,
    --placeable_by = {item = "bm-suspension-tank", count = 1},
    create_ghost_on_death = false,
    --hidden = true,
  }),
  make_tank_entity({
    type = "assembling-machine",
    name = "bm-suspension-tank-prepared",
    icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
    localised_description = {
      "", {"entity-description.bm-suspension-tank-prepared"}, " ",
      {"entity-description.bm-suspension-tank-warning"}
    },
    crafting_categories = {"bm-suspension-tank-prepared"},
    fixed_recipe = "bm-prepared-tank-maintenance",
    production_health_effect = {
      not_producing = -2.5 / 60, -- 5 hp per second
      producing = 2.5 / 60 -- 5 hp per second
    },
    dying_trigger_effect = {
      {
        type = "script",
        effect_id = "bm-prepared-tank-died"
      }
    },
    enable_logistic_control_behavior = false,
    --placeable_by = {item = "bm-suspension-tank", count = 1},
    create_ghost_on_death = false,
    hidden = true,
  }),
  {
    type = "projectile",
    name = "bm-clone-suspended",
    acceleration = 0,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "script",
          effect_id = "bm-clone-suspended"
        }
      }
    }
  },
  {
    type = "projectile",
    name = "bm-tank-prepared",
    acceleration = 0,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "script",
          effect_id = "bm-tank-prepared"
        }
      }
    }
  },
})
