local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")



--WALL
local station_wall = util.table.deepcopy(data.raw["wall"]["stone-wall"])
station_wall.name = "bm-station-wall"
station_wall.minable = nil
station_wall.autoplace = {
  order = "a",
  probability_expression = "bm_station_wall",
  force = "neutral",
}

data:extend({station_wall})
table.insert(bm_add_full_resistences, station_wall)



local station_input = util.table.deepcopy(data.raw["container"]["iron-chest"])
station_input.name = "bm-station-input"
station_input.minable = nil
station_input.picture.layers[1].tint = {r = 0, g = 1, b = 0}

local station_output = util.table.deepcopy(data.raw["container"]["iron-chest"])
station_output.name = "bm-station-output"
station_output.minable = nil
station_output.picture.layers[1].tint = {r = 1, g = 1, b = 0}

data:extend({station_input, station_output})
table.insert(bm_add_full_resistences, station_input)
table.insert(bm_add_full_resistences, station_output)



--MARKET
data:extend({
  {
    type = "assembling-machine",
    name = "bm-homeworld-market",
    icon = "__base__/graphics/icons/market.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "bm-homeworld-market"},
    max_health = 300,
    --corpse = "assembling-machine-1-remnants",
    --dying_explosion = "assembling-machine-1-explosion",
    icon_draw_specification = {shift = {0, -0.3}},
    --resistances ={{type = "fire", percent = 70}},
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["assembling-machine"],
    alert_icon_shift = util.by_pixel(0, -12),
    graphics_set = {
      animation = {
        filename = "__base__/graphics/entity/market/market.png",
        width = 156,
        height = 127,
        shift = {0.95, 0.2},
      }
    },
    crafting_categories = {"bm-market"},
    crafting_speed = 1,
    energy_source = {
      type = "void",
      usage_priority = "secondary-input",
    },
    energy_usage = "75kW",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    allowed_effects = {"speed", "consumption", "pollution"},
    effect_receiver = {uses_module_effects = false, uses_beacon_effects = false, uses_surface_effects = true},
    impact_category = "metal",
    working_sound =
    {
      sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5},
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    autoplace = {
      order = "a",
      probability_expression = "bm_station_markets",
      force = "player",
    },
    surface_conditions = {
      {property = "magnetic-field", min = 10, max = 10},
      {property = "gravity", min = 1, max = 1},
    },
  },
})
table.insert(bm_add_full_resistences, data.raw["assembling-machine"]["bm-homeworld-market"])



--INTERSTELLAR ENERGY mechanical_inventory_pickuplocal picture = {
local link_entity = require("__biological-machines-k2-assets__/prototypes/intergalactic-transceiver.lua")
link_entity.name = "bm-interstellar-energy-link"
link_entity.minable = {mining_time = 1, result = "bm-interstellar-energy-link"}
link_entity.corpse = "bm-big-random-pipes-remnants"

local link_remnant = require("__biological-machines-k2-assets__/prototypes/intergalactic-transceiver-remnants.lua")
link_remnant.name = "bm-big-random-pipes-remnants"

data:extend({
  link_entity, link_remnant,
  {
    type = "simple-entity-with-owner",
    name = "bm-inactive-interstellar-energy-link",
    icon = link_entity.icon,
    map_color = link_entity.map_color,
    collision_box = link_entity.collision_box,
    selection_box = link_entity.selection_box,
    drawing_box_vertical_extension = link_entity.drawing_box_vertical_extension,
    max_health = link_entity.max_health,
    dying_explosion = link_entity.dying_explosion,
    damaged_trigger_effect = link_entity.damaged_trigger_effect,
    resistances = link_entity.resistances,
    minable = link_entity.minable,
    corpse = link_entity.corpse,
    flags = {"not-on-map"},
    hidden = true,
    picture = {
      layers = {
        {
          filename = "__biological-machines-k2-assets__/graphics/intergalactic-transceiver/intergalactic-transceiver-light.png",
          width = 800,
          height = 800,
          scale = 0.5,
          frame_count = 1,
          shift = { 0, -0.8 },
          draw_as_light = true,
        },
        {
          filename = "__biological-machines-k2-assets__/graphics/intergalactic-transceiver/intergalactic-transceiver.png",
          width = 800,
          height = 800,
          scale = 0.5,
          frame_count = 1,
          shift = { 0, -0.8 },
        },
        {
          filename = "__biological-machines-k2-assets__/graphics/intergalactic-transceiver/intergalactic-transceiver-sh.png",
          width = 867,
          height = 626,
          scale = 0.5,
          frame_count = 1,
          draw_as_shadow = true,
          shift = { 0.52, 0.5 },
        },
      },
    },
  },
})
