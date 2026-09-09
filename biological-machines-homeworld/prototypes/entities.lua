local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")



--CLUTTER
data.raw["pipe"]["pipe"].autoplace = {
  order = "a",
  force = "player",
  probability_expression = "bm_station_pipe",
}

data.raw["heat-pipe"]["heat-pipe"].autoplace = {
--data.raw["transport-belt"]["turbo-transport-belt"].autoplace = {
  order = "a",
  force = "player",
  probability_expression = "bm_station_heat_pipe",
}

--[[
data.raw["container"]["iron-chest"].autoplace = {
  order = "b-e",
  force = "player",
  probability_expression = "bm_station_iron_chest",
}

data.raw["container"]["steel-chest"].autoplace = {
  order = "b-d",
  force = "player",
  probability_expression = "bm_station_steel_chest",
}
]]

data.raw["assembling-machine"]["assembling-machine-3"].autoplace = {
  order = "b-c",
  force = "player",
  probability_expression = "bm_station_assembler",
}

data.raw["furnace"]["recycler"].autoplace = {
  order = "b-b",
  force = "player",
  probability_expression = "bm_station_recycler",
}



data:extend({
  {
    type = "simple-entity",
    name = "bm-loot-chest",
    icon = "__base__/graphics/icons/steel-chest.png",
    flags = {"placeable-neutral", "player-creation"},
    --minable = {mining_time = 0.2, result = "steel-chest"},
    max_health = 350,
    corpse = "steel-chest-remnants",
    dying_explosion = "steel-chest-explosion",
    open_sound = sounds.metallic_chest_open,
    close_sound = sounds.metallic_chest_close,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    --fast_replaceable_group = "container",
    --inventory_size = 48,
    impact_category = "metal",
    --icon_draw_specification = {scale = 0.7},
    pictures = {
      {
        filename = "__base__/graphics/entity/steel-chest/steel-chest.png",
        priority = "extra-high",
        width = 64,
        height = 80,
        shift = util.by_pixel(-0.25, -0.5),
        scale = 0.5
      },
      {
        filename = "__biological-machines-homeworld__/graphics/loot-chest-alt.png",
        priority = "extra-high",
        width = 68,
        height = 84,
        shift = util.by_pixel(0, -3),
        scale = 0.5
      },
      {
        filename = "__base__/graphics/entity/steel-chest/remnants/steel-chest-remnants.png",
        line_length = 1,
        width = 150,
        height = 88,
        direction_count = 1,
        shift = util.by_pixel(15, -1),
        scale = 0.5
      },
    },
    --circuit_connector = circuit_connector_definitions["chest"],
    --circuit_wire_max_distance = default_circuit_wire_max_distance,
    --water_reflection = chest_reflection()
    autoplace = {
      order = "b-d",
      force = "player",
      probability_expression = "bm_station_steel_chest",
    },
    minable = {
      mining_time = 1,
      transfer_entity_health_to_products = false,
      results = {
        {type = "item", name = "steel-plate", amount = 8, independent_probability = 0.25},
        {type = "item", name = "iron-plate", amount_min = 1, amount_max = 20, independent_probability = 0.1},
        {type = "item", name = "copper-cable", amount_min = 1, amount_max = 20, independent_probability = 0.1},
        --{type = "item", name = "piercing-rounds-magazine", amount_min = 1, amount_max = 100, independent_probability = 0.01},
        {type = "item", name = "bm-credit", amount_min = 1, amount_max = 100, independent_probability = 0.1},
        --{type = "item", name = "bm-super-credit", amount = 1, independent_probability = 0.005},
      }
    },
  },
  {
    type = "simple-entity",
    name = "bm-crash-spaceship",
    icon = "__base__/graphics/icons/crash-site-spaceship.png",
    flags = {"placeable-player", "player-creation"},
    hidden = true,
    map_color = {r = 0, g = 0.365, b = 0.58, a = 1},
    max_health = 600,
    alert_when_damaged = false,
    allow_copy_paste = false,
    default_status = "broken",
    open_sound = sounds.metal_large_open,
    close_sound = sounds.metal_large_close,
    resistances = {
      {type = "fire", percent = 100}
    },
    collision_box = {{-8.7, -3.3}, {6.9, 4.5}},
    selection_box = {{-8.7, -3.3}, {6.9, 4.5}},
    dying_explosion = "nuke-explosion",
    integration_patch_render_layer = "decals",
    integration_patch = {
      filename = "__biological-machines-homeworld__/graphics/spaceship-ground-platform.png",
      priority = "very-low",
      width = 1330,
      height = 786,
      shift = util.by_pixel(-50, 61),
      dice_x = 4,
      dice_y = 3,
      scale = 0.5
    },
    picture = {
      layers = {
        {
          filename = "__base__/graphics/entity/crash-site-spaceship/spaceship.png",
          priority = "very-low",
          width = 1228,
          height = 790,
          shift = util.by_pixel(-13, 34),
          dice_x = 4,
          dice_y = 3,
          scale = 0.5
        },
        {
          filename = "__base__/graphics/entity/crash-site-spaceship/spaceship-shadow.png",
          priority = "very-low",
          width = 1340,
          height = 842,
          shift = util.by_pixel(-23, 50),
          scale = 0.5,
          dice_x = 5,
          dice_y = 4,
          draw_as_shadow = true
        }
      }
    },
    autoplace = {
      order = "b-f",
      force = "player",
      probability_expression = "bm_station_crash",
    },
    minable = {
      mining_time = 10,
      transfer_entity_health_to_products = false,
      results = {
        {type = "item", name = "processing-unit", amount_min = 0, amount_max = 100},
        {type = "item", name = "low-density-structure", amount_min = 0, amount_max = 100},
        {type = "item", name = "rocket-fuel", amount_min = 0, amount_max = 25},
      }
    },
  },
})

---[[
if mods["quality"] then
  local quality_results = {
    {type = "item", name = "bm-super-credit", amount = 1, independent_probability = 0.004, quality_min = "uncommon"},
    {type = "item", name = "bm-super-credit", amount = 1, independent_probability = 0.003, quality_min = "rare"},
    {type = "item", name = "bm-super-credit", amount = 1, independent_probability = 0.002, quality_min = "epic"},
    {type = "item", name = "bm-super-credit", amount = 1, independent_probability = 0.001, quality_min = "legendary"},
  }

  local chest_results = data.raw["simple-entity"]["bm-loot-chest"].minable.results
  for _, quality_result in pairs(quality_results) do
    table.insert(chest_results, quality_result)
  end
else
  table.insert(data.raw["simple-entity"]["bm-loot-chest"].minable.results,
    {type = "item", name = "bm-super-credit", amount = 1, independent_probability = 0.01}
  )
end
--]]



--WALL
local station_wall
if mods["snouz_space_platform_hull"] then
  station_wall = util.table.deepcopy(data.raw["wall"]["snouz_wall_hull"])
else
  station_wall = util.table.deepcopy(data.raw["wall"]["stone-wall"])
end
--local station_wall = util.table.deepcopy(data.raw["wall"]["stone-wall"])
station_wall.name = "bm-station-wall"
station_wall.minable = nil
station_wall.autoplace = {
  order = "a",
  probability_expression = "bm_station_wall",
  force = "player",
}

data:extend({station_wall})
table.insert(bm_add_full_resistences, station_wall)



--INPUT/OUTPUT
local station_input = util.table.deepcopy(data.raw["container"]["iron-chest"])
station_input.name = "bm-station-input"
station_input.minable = nil
station_input.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
station_input.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
station_input.picture = {
  layers =
  {
    {
      filename = "__biological-machines-homeworld__/graphics/station-input.png",
      width = 212,
      height = 192,
      scale = 0.5,
      shift = util.by_pixel(0.5, 1)
    },
    {
      filename = "__biological-machines-homeworld__/graphics/station-input-shadow.png",
      width = 244,
      height = 176,
      scale = 0.5,
      draw_as_shadow = true,
      shift = util.by_pixel(12.5, 0.5)
    }
  }
}
--station_input.picture.layers[1].tint = {r = 0, g = 1, b = 0}

local station_output = util.table.deepcopy(data.raw["container"]["iron-chest"])
station_output.name = "bm-station-output"
station_output.minable = nil
station_output.collision_box = {{ -0.7, -0.7}, {0.7, 0.7}}
station_output.selection_box = {{ -1, -1}, {1, 1}}
station_output.stateless_visualisation = {
  {
    animation = {
      filename = "__biological-machines-homeworld__/graphics/station-output-animation.png",
      width = 114,
      height = 100,
      scale = 0.5,
      frame_count = 20,
      animation_speed = 0.15,
    },
    shadow = {
      filename = "__biological-machines-homeworld__/graphics/station-output-shadow.png",
      width = 130,
      height = 96,
      scale = 0.5,
      draw_as_shadow = true,
      shift = util.by_pixel(33.75, 0.5),
    },
    light = {intensity = 0.5, size = 6, color = {r = 1.0, g = 1.0, b = 1.0}},
  },
  {
    animation = {
      filename = "__biological-machines-homeworld__/graphics/station-output-details.png",
      width = 114,
      height = 120,
      scale = 0.5,
      shift = util.by_pixel(0, -5),
    },
  },
  {
    animation = {
      filename = "__base__/graphics/entity/roboport/roboport-base-animation.png",
      --priority = "medium",
      width = 83,
      height = 59,
      frame_count = 8,
      animation_speed = 0.5,
      shift = util.by_pixel(-11.5, -33),
      scale = 0.5
    }
  },
}
--[[
station_output.picture = {
  layers =
  {
    {
      filename = "__biological-machines-homeworld__/graphics/station-output.png",
      width = 114,
      height = 100,
      scale = 0.5,
    },
    {
      filename = "__biological-machines-homeworld__/graphics/station-output-shadow.png",
      width = 130,
      height = 96,
      scale = 0.5,
      draw_as_shadow = true,
      shift = util.by_pixel(33.75, 0.5)
    }
  }
}
]]
--station_output.picture.layers[1].tint = {r = 1, g = 1, b = 0}

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
    corpse = "big-remnants",
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
      order = "b-a",
      probability_expression = "bm_station_market",
      force = "player",
    },
    surface_conditions = {
      {property = "magnetic-field", min = 10, max = 10},
      {property = "gravity", min = 1, max = 1},
    },
  },
})
--table.insert(bm_add_full_resistences, data.raw["assembling-machine"]["bm-homeworld-market"])



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
    placeable_by = {item = "bm-interstellar-energy-link", count = 1},
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
