local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")



local cliff_color = {r=0.80, g=0.80, b=0.80}
local glass_color = {0.34, 0.77, 0.68}


--helium wisps (flying enemy)



--SURFACE CONDITIONS
local burner_entities = {
  data.raw["fluid-turret"]["flamethrower-turret"],
  data.raw["furnace"]["stone-furnace"],
  data.raw["mining-drill"]["burner-mining-drill"],
  data.raw["furnace"]["steel-furnace"],
  data.raw["boiler"]["boiler"],
  data.raw["inserter"]["burner-inserter"],
  data.raw["reactor"]["heating-tower"]
}
for i=1, #burner_entities do
  PlanetsLib.restrict_surface_conditions(burner_entities[i], {property = "pressure", min = 51})
end

data.raw["roboport"]["roboport"].surface_conditions = {{property = "gravity", min = 1}}



--DECOATIVES
local vulc_decoratives = {
  ["vulcanus-dune-decal"] = {"bm-wit-dune-decal", "wit_vulcanus_dune_decal"},
  ["crater-small"] = {"bm-wit-crater-small", "wit_crater_small"},
  ["crater-large"] = {"bm-wit-crater-large", "wit_crater_large"},
  ["waves-decal"] = {"bm-wit-waves-decal", "wit_waves_decal"}
}

for decor_name, decor_data in pairs(vulc_decoratives) do
  local decor = util.table.deepcopy(data.raw["optimized-decorative"][decor_name])
  decor.name = decor_data[1]
  decor.autoplace.probability_expression  = decor_data[2]
  data:extend({decor})
end



--ROCKS
local vulc_rocks = {
  ["tiny-rock-cluster"] = {"optimized-decorative", "bm-tiny-wit-rock-cluster", "wit_rock_cluster"},
  ["tiny-volcanic-rock"] = {"optimized-decorative", "bm-tiny-wit-rock", "wit_rock_tiny"},
  ["small-volcanic-rock"] = {"optimized-decorative", "bm-small-wit-rock", "wit_rock_small"},
  ["medium-volcanic-rock"] = {"optimized-decorative", "bm-medium-wit-rock", "wit_rock_medium"},
  ["big-volcanic-rock"] = {"simple-entity", "bm-big-wit-rock", "wit_rock_big"},
  ["huge-volcanic-rock"] = {"simple-entity", "bm-huge-wit-rock", "wit_rock_huge"}
}

local file_trim_len = #"__space-age__" + 1

for rock_name, rock_data in pairs(vulc_rocks) do
  local rock = util.table.deepcopy(data.raw[rock_data[1]][rock_name])
  rock.name = rock_data[2]
  rock.autoplace.probability_expression  = rock_data[3]
  for i=1, #rock.pictures do
    local file_tail = string.sub(rock.pictures[i].filename, file_trim_len)
    rock.pictures[i].filename = "__biological-machines-planet-wit__" .. file_tail
    rock.pictures[i].tint_as_overlay = false
    rock.pictures[i].tint = nil
  end
  data:extend({rock})
end

local big_rock = data.raw["simple-entity"]["bm-big-wit-rock"]
big_rock.icon = "__biological-machines-planet-wit__/graphics/big-wit-rock.png"
big_rock.map_color = cliff_color
big_rock.minable.results = {
  {type = "item", name = "iron-ore", amount_min = 6, amount_max = 15},
  {type = "item", name = "copper-ore", amount_min = 2, amount_max = 6},
  {type = "item", name = "carbon", amount_min = 3, amount_max = 9},
  {type = "item", name = "sulfur", amount_min = 1, amount_max = 2},
  {type = "item", name = "ice", amount_min = 2, amount_max = 7},
  {type = "item", name = "calcite", amount_min = 1, amount_max = 3},
}

local huge_rock = data.raw["simple-entity"]["bm-huge-wit-rock"]
huge_rock.icon = "__biological-machines-planet-wit__/graphics/huge-wit-rock.png"
huge_rock.map_color = cliff_color
huge_rock.minable.results = {
  {type = "item", name = "iron-ore", amount_min = 12, amount_max = 30},
  {type = "item", name = "copper-ore", amount_min = 4, amount_max = 12},
  {type = "item", name = "carbon", amount_min = 6, amount_max = 18},
  {type = "item", name = "sulfur", amount_min = 1, amount_max = 3},
  {type = "item", name = "ice", amount_min = 3, amount_max = 15},
  {type = "item", name = "calcite", amount_min = 2, amount_max = 4},
}



--GLASSBERGS
local icebergs = {
  ["lithium-iceberg-small"] = {"optimized-decorative", "bm-glassberg-small", "glassberg_small"},
  ["lithium-iceberg-medium"] = {"optimized-decorative", "bm-glassberg-medium", "glassberg_medium"},
  ["lithium-iceberg-big"] = {"simple-entity", "bm-glassberg-big", "glassberg_big"},
  ["lithium-iceberg-huge"] = {"simple-entity", "bm-glassberg-huge", "glassberg_huge"}
}

local file_trim_len = #"__space-age__" + 1

for berg_name, berg_data in pairs(icebergs) do
  local berg = util.table.deepcopy(data.raw[berg_data[1]][berg_name])
  berg.name = berg_data[2]
  berg.autoplace.probability_expression  = berg_data[3]
  for i=1, #berg.pictures do
    local file_tail = string.sub(berg.pictures[i].filename, file_trim_len)
    berg.pictures[i].filename = "__biological-machines-planet-wit__" .. file_tail
  end
  data:extend({berg})
end

local big_berg = data.raw["simple-entity"]["bm-glassberg-big"]
big_berg.icon = "__biological-machines-planet-wit__/graphics/glassberg-big.png"
big_berg.map_color = glass_color
big_berg.minable.results = {
  {type = "item", name = "bm-glass-shard", amount_min = 20, amount_max = 40}
}

local huge_berg = data.raw["simple-entity"]["bm-glassberg-huge"]
huge_berg.icon = "__biological-machines-planet-wit__/graphics/glassberg-huge.png"
huge_berg.map_color = glass_color
huge_berg.minable.results = {
  {type = "item", name = "bm-glass-shard", amount_min = 30, amount_max = 60}
}



--CLIFFS
data:extend({
  scaled_cliff({
    mod_name = "__biological-machines-planet-wit__",
    name = "bm-cliff-wit",
    map_color = cliff_color,
    suffix = "wit",
    subfolder = "wit",
    scale = 1.0,
    has_lower_layer = true,
    sprite_size_multiplier = 2,
    factoriopedia_simulation = nil
  }),
  scaled_cliff_crater({
    mod_name = "__biological-machines-planet-wit__",
    name = "bm-wit-crater-cliff",
    icon = "__biological-machines-planet-wit__/graphics/icons/wit-crater-cliff.png",
    map_color = cliff_color,
    subfolder = "wit",
    prefix = "vulcanus-crater-section",
    scale = 1.0,
    collision_mask = {layers = {
      item = true, object = true, player = true, water_tile = true
    }},
    has_lower_layer = true,
    sprite_size_multiplier = 2,
    flags = { "placeable-off-grid", "placeable-neutral" },
    factoriopedia_simulation = simulations.factoriopedia_crater_cliff,

    crater_radius = 7, --3.5,
    crater_edge_thickness = 5,
    crater_segment_orientation_offset = 0, --1 / 16,
    --segment_probability = 1,
    autoplace =
    {
      order = "a[landscape]-a[cliff]-b[crater]",
      probability_expression = "wit_crater_cliff"
    }
  })
})



--BUILDINGS
local function get_stripes(s)
  local stripes = {}

  for i = 1, 8 do
    stripes[i] = {
      filename = string.format(s, i),
      width_in_frames = 10,
      height_in_frames = 1,
      y = (i - 1) * 640,
    }
  end

  return stripes
end



local function aa_picture()
  return
  {
    layers =
    {
      {
        filename = "__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-picture.png",
        priority = "high",
        width = 590,
        height = 640,
        shift = util.by_pixel(0, -25),
        scale = 0.5
      },
      {
        filename = "__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-hr-shadow.png",
        priority = "high",
        width = 1200,
        height = 700,
        shift = util.by_pixel(29, 6),
        draw_as_shadow = true,
        scale = 0.5
      }
    }
  }
end

local function aa_charge()
  return
  {
    layers =
    {
      {
        priority = "high",
        width = 590,
        height = 640,
        frame_count = 80,
        --draw_as_glow = true,
        stripes = get_stripes("__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-animation.png"),
        shift = util.by_pixel(0, -25),
        scale = 0.5,
        animation_speed = 1,
      },
      {
        priority = "high",
        width = 590,
        height = 640,
        frame_count = 80,
        draw_as_glow = true,
        blend_mode = "additive",
        stripes = get_stripes("__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-emission1.png"),
        shift = util.by_pixel(0, -25),
        scale = 0.5,
        animation_speed = 1,
      },
    }
  }
end

local function aa_discharge()
  return
  {
    layers =
    {
      {
        priority = "high",
        width = 590,
        height = 640,
        frame_count = 80,
        --draw_as_glow = true,
        stripes = get_stripes("__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-animation.png"),
        shift = util.by_pixel(0, -25),
        scale = 0.5,
        animation_speed = 1,
      },
      {
        priority = "high",
        width = 590,
        height = 640,
        frame_count = 80,
        draw_as_glow = true,
        blend_mode = "additive",
        stripes = get_stripes("__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-emission1.png"),
        shift = util.by_pixel(0, -25),
        scale = 0.5,
        animation_speed = 1,
      },
      {
        priority = "high",
        width = 590,
        height = 640,
        frame_count = 80,
        draw_as_glow = true,
        blend_mode = "additive",
        stripes = get_stripes("__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-emission2.png"),
        shift = util.by_pixel(0, -25),
        scale = 0.5,
        animation_speed = 1,
      },
    }
  }
end

data:extend({
  {
    type = "accumulator",
    name = "bm-advanced-accumulator",
    icon = "__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-icon.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "bm-advanced-accumulator"},
    max_health = 150,
    corpse = "accumulator-remnants",
    dying_explosion = "accumulator-explosion",
    collision_box = {{-4.4, -4.4}, {4.4, 4.4}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box_vertical_extension = 0.5,
    energy_source = {
      type = "electric",
      buffer_capacity = "5GJ",
      usage_priority = "tertiary",
      input_flow_limit = "3GW",
      output_flow_limit = "3GW",
      drain = "3MW"
    },
    chargable_graphics = {
      picture = aa_picture(),
      charge_animation = aa_charge(),
      charge_cooldown = 30,
      discharge_animation = aa_discharge(),
      discharge_cooldown = 60
      --discharge_light = {intensity = 0.7, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
    },
    --water_reflection = aa_reflection(),
    impact_category = "metal",
    open_sound = sounds.electric_large_open,
    close_sound = sounds.electric_large_close,
    working_sound = {
      main_sounds = {
        {
          sound = {
            filename = "__base__/sound/accumulator-working.ogg",
            volume = 0.4,
            modifiers = volume_multiplier("main-menu", 1.44),
            audible_distance_modifier = 0.5
          },
          match_volume_to_activity = true,
          activity_to_volume_modifiers = {offset = 2, inverted = true},
          fade_in_ticks = 4,
          fade_out_ticks = 20
        },
        {
          sound = {
            filename = "__base__/sound/accumulator-discharging.ogg",
            volume = 0.4,
            modifiers = volume_multiplier("main-menu", 1.44),
            audible_distance_modifier = 0.5
          },
          match_volume_to_activity = true,
          activity_to_volume_modifiers = {offset = 1},
          fade_in_ticks = 4,
          fade_out_ticks = 20
        }
      },
      idle_sound = {filename = "__base__/sound/accumulator-idle.ogg", volume = 0.35, audible_distance_modifier = 0.5},
      max_sounds_per_prototype = 3,
    },

    circuit_connector = circuit_connector_definitions["accumulator"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_output_signal = {type = "virtual", name = "signal-A"}
  },
})
