local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")



local aam_entity_path = "__biological-machines-k2-assets__/graphics/aam-entity/"

function assemblerkpipepictures()
  return {
    north = {
      filename = aam_entity_path .. "advanced-assembling-machine-k-pipe-N.png",
      priority = "extra-high",
      width = 71,
      height = 38,
      shift = util.by_pixel(2.25, 13.5),
      scale = 0.5,
    },
    east = {
      filename = aam_entity_path .. "advanced-assembling-machine-k-pipe-E.png",
      priority = "extra-high",
      width = 42,
      height = 76,
      shift = util.by_pixel(-24.5, 1),
      scale = 0.5,
    },
    south = {
      filename = aam_entity_path .. "advanced-assembling-machine-k-pipe-S.png",
      priority = "extra-high",
      width = 88,
      height = 61,
      shift = util.by_pixel(0, -31.25),
      scale = 0.5,
    },
    west = {
      filename = aam_entity_path .. "advanced-assembling-machine-k-pipe-W.png",
      priority = "extra-high",
      width = 39,
      height = 73,
      shift = util.by_pixel(25.75, 1.25),
      scale = 0.5,
    },
  }
end

return {
  type = "assembling-machine",
  icon = "__biological-machines-k2-assets__/graphics/aam-icon.png",
  icon_size = 64,
  flags = { "placeable-neutral", "placeable-player", "player-creation" },
  max_health = 800,
  dying_explosion = "big-explosion",
  resistances = {
    { type = "physical", percent = 50 },
    { type = "fire",     percent = 95 },
    { type = "impact",   percent = 80 },
  },
  collision_box = { { -2.25, -2.25 }, { 2.25, 2.25 } },
  selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
  damaged_trigger_effect = hit_effects.entity(),
  fluid_boxes_off_when_no_fluid_recipe = true,
  fluid_boxes = {
    {

      production_type = "input",
      pipe_picture = assemblerkpipepictures(),
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = { {
        direction = 0,
        flow_direction = "input",
        position = { 0, -2 }
      } },
      secondary_draw_orders = { north = -1 },
    },
    {
      production_type = "output",
      pipe_picture = assemblerkpipepictures(),
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = { {
        direction = 8,
        flow_direction = "output",
        position = { 0, 2 }
      } },
      secondary_draw_orders = { north = -1 },
    },
  },
  perceived_performance = {
    maximum = 20,
    minimum = 0.25,
    performance_to_activity_rate = 2
  },
  graphics_set = {
    animation = {
      layers = {
        {
          filename = aam_entity_path .. "advanced-assembling-machine.png",
          priority = "high",
          width = 320,
          height = 320,
          frame_count = 1,
          repeat_count = 32,
          animation_speed = 0.25,
          shift = { 0, 0 },
          scale = 0.5,
        },
        {
          filename = aam_entity_path .. "advanced-assembling-machine-w1.png",
          priority = "high",
          width = 128,
          height = 144,
          shift = { -1.02, 0.29 },
          frame_count = 32,
          line_length = 8,
          animation_speed = 0.1,
          scale = 0.5,
        },
        {
          filename = aam_entity_path .. "advanced-assembling-machine-steam.png",
          priority = "high",
          width = 80,
          height = 81,
          shift = { -1.2, -2.1 },
          frame_count = 32,
          line_length = 8,
          animation_speed = 1.5,
          scale = 0.5,
        },
        {
          filename = aam_entity_path .. "advanced-assembling-machine-sh.png",
          priority = "high",
          width = 346,
          height = 302,
          shift = { 0.32, 0.12 },
          frame_count = 1,
          repeat_count = 32,
          animation_speed = 0.1,
          draw_as_shadow = true,
          scale = 0.5,
        },
        {
          filename = aam_entity_path .. "advanced-assembling-machine-w2.png",
          priority = "high",
          width = 37,
          height = 25,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.17, -1.445 },
          scale = 0.5,
        },
        {
          filename = aam_entity_path .. "advanced-assembling-machine-w3.png",
          priority = "high",
          width = 23,
          height = 15,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.93, -2.05 },
          scale = 0.5,
        },
        {
          filename = aam_entity_path .. "advanced-assembling-machine-w3.png",
          priority = "high",
          width = 23,
          height = 15,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.868, -0.082 },
          scale = 0.5,
        },
        {
          filename = aam_entity_path .. "advanced-assembling-machine-w3.png",
          priority = "high",
          width = 23,
          height = 15,
          frame_count = 8,
          line_length = 4,
          repeat_count = 4,
          animation_speed = 0.1,
          shift = { 0.868, 0.552 },
          scale = 0.5,
        },
      },
    },
  },
  vehicle_impact_sound = sounds.generic_impact,
  working_sound = {
    sound = {
      {
        filename = "__biological-machines-k2-assets__/sounds/advanced-assembling-machine/advanced-assembling-machine.ogg",
        volume = 0.8,
      },
    },
    idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
    apparent_volume = 1.5,
    max_sounds_per_type = 3,
    fade_in_ticks = 10,
    fade_out_ticks = 30,
  },

  water_reflection = {
    pictures = {
      filename = aam_entity_path .. "advanced-assembling-machine-reflection.png",
      priority = "extra-high",
      width = 70,
      height = 50,
      shift = util.by_pixel(0, 40),
      variation_count = 1,
      scale = 5,
    },
    rotate = false,
    orientation_to_variation = false,
  },

  energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = { pollution = 5 },
  },

  circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
  circuit_connector = circuit_connector_definitions.create_vector(
    universal_connector_template,
    {
      { variation = 18, main_offset = util.by_pixel(46, 48), shadow_offset = util.by_pixel(57, 54), show_shadow = true },
      { variation = 18, main_offset = util.by_pixel(46, 48), shadow_offset = util.by_pixel(57, 54), show_shadow = true },
      { variation = 18, main_offset = util.by_pixel(46, 48), shadow_offset = util.by_pixel(57, 54), show_shadow = true },
      { variation = 18, main_offset = util.by_pixel(46, 48), shadow_offset = util.by_pixel(57, 54), show_shadow = true }
    }
  ),
  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close
}
