local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local decorative_trigger_effects = require("__base__.prototypes.decorative.decorative-trigger-effects")



-------------------------------------------------------------------ENTITY
local unstable_promethium_astroid = util.table.deepcopy(data.raw["asteroid"]["huge-promethium-asteroid"])
unstable_promethium_astroid.name = "bm-unstable-promethium-asteroid"
unstable_promethium_astroid.resistances = {
  {type = "electric", decrease = 0, percent = 100},
  {type = "explosion", decrease = 100, percent = 10},
  {type = "fire", decrease = 0, percent = 100},
  {type = "laser", decrease = 20, percent = 50},
  {type = "physical", decrease = 3000, percent = 10},
}
unstable_promethium_astroid.collision_mask = {
  layers = {
    --object=true, is_object=true,
    --player=true, is_lower_object=true,
  },
  not_colliding_with_itself = true,
}
unstable_promethium_astroid.dying_trigger_effect = {
  {
    type = "create-explosion",
    entity_name = "promethium-asteroid-explosion-5",
    only_when_visible = true
  },
  {
    type = "create-explosion",
    entity_name = "massive-explosion",
    only_when_visible = true
  },
  {
    type = "nested-result",
    action = {
      type = "area",
      radius = 3,
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            damage = {amount = 1000, type = "explosion"},
            type = "damage",
          },
          {
            entity_name = "big-explosion",
            type = "create-entity",
          }
        },
      },
    },
  },
  {
    type = "nested-result",
    action = {
      type = "area",
      radius = 9,
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            damage = {amount = 100, type = "explosion"},
            type = "damage",
          },
          {
            entity_name = "explosion",
            type = "create-entity",
          }
        },
      },
    },
  },
}
data:extend({unstable_promethium_astroid})

--[[
local core_interface = util.table.deepcopy(data.raw["electric-energy-interface"]["hidden-electric-energy-interface"])
core_interface.name = "bm-core-energy"
core_interface.icon = data.raw["space-location"]["shattered-planet"].icon
core_interface.energy_source.buffer_capacity = "10TJ"
core_interface.energy_source.output_flow_limit = "500TW"
core_interface.energy_production = "500TW"
core_interface.collision_mask = {layers = {}}
core_interface.autoplace = {order = "a[rock]-a[huge]", probability_expression = "(x == 0) * (y == 5)"}
]]

data:extend({
  --core_interface,
  {
    type = "electric-pole",
    name = "bm-promethium-protrusion",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__biological-machines-planet-balack__/graphics/promethium-protrusion-icon.png",
    subgroup = "grass",
    order = "b[decorative]-l[rock]-e[aquilo]-b[lithium-iceberg-huge]",
    collision_mask = {
      layers=
      {
        item=true,
        object=true,
        player=true,
        water_tile=true
      },
    },
    collision_box = {{-1.85, -1.25}, {1.85, 1.25}},
    selection_box = {{-1.85, -1.25}, {1.85, 1.25}},
    drawing_box_vertical_extension = 2,
    --damaged_trigger_effect = hit_effects.rock(),
    render_layer = "object",
    max_health = 1500,
    autoplace = {order = "a[rock]-a[huge]", probability_expression = "(x == 0) * (y == 0)"},
    --dying_trigger_effect = decorative_trigger_effects.big_rock(),
    map_color = {0.9, 0.1, 0.1},
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = sound_variations("__space-age__/sound/mining/mined-iceberg", 4, 0.7),
    mining_sound = sound_variations("__space-age__/sound/mining/axe-mining-iceberg", 7, 0.5),
    impact_category = "stone",
    pictures = {
      filename = "__biological-machines-planet-balack__/graphics/promethium-protrusion-entity.png",
      width = 640,
      height = 310,
      scale = 0.5,
      shift = {0.65,-0.75},
      direction_count = 1,
    },
    maximum_wire_distance = 0,
    supply_area_distance = 50,
    connection_points = {
      {
        shadow = {
          --copper = util.by_pixel(136, 8),
          copper = util.by_pixel(122, 6),
          green = util.by_pixel(124, 8),
          --red = util.by_pixel(151, 9),
          red = util.by_pixel(126, 6),
        },
        wire = {
          --copper = util.by_pixel(0, -86),
          copper = util.by_pixel(-19, -84),
          green = util.by_pixel(-21, -82),
          --red = util.by_pixel(22, -81),
          red = util.by_pixel(-23, -84),
        }
      },
    },
  },
})

table.insert(bm_add_full_resistences, data.raw["electric-pole"]["bm-promethium-protrusion"])



--------------------------------------------------------------RECIPE
data.raw.recipe["promethium-science-pack"].surface_conditions = {
  {property = "gravity", min = 0, max = 1},
  {property = "magnetic-field", min = 0, max = 0},
}



--------------------------------------------------------------NOISE EXPRESSION
data:extend({
  {
    type = "noise-expression",
    name = "bm_promethium_core",
    expression = "(50 ^ 2) - (x * x + y * y)",
  },
})



---------------------------------------------------------------PLANET
local shattered_core_map_gen = {
  property_expression_names = {
    ["entity:bm-promethium-ore:richness"] = 1000000,
    ["entity:bm-promethium-ore:probability"] = "bm_promethium_core",
  },
  cliff_settings = nil,
  autoplace_settings = {
    ["tile"] = {
      settings = {
        ["bm-promethium-rock"] = {},
        --["empty-space"] = {},
        ["bm-empty-space-2"] = {},
      }
    },
    ["entity"] = {
      settings = {
        ["bm-promethium-ore"] = {},
        --["bm-core-energy"] = {},
        ["bm-promethium-protrusion"] = {},
      }
    }
  }
}

local fulgora_planet = data.raw["planet"]["fulgora"]
local shattered_core_planet = data.raw["space-location"]["shattered-planet"]
shattered_core_planet.type = "planet"
shattered_core_planet.gravity_pull = 10
shattered_core_planet.map_gen_settings = shattered_core_map_gen
shattered_core_planet.platform_procession_set = {
  arrival = {"planet-to-platform-b"},
  departure = {"platform-to-planet-a"},
}
shattered_core_planet.planet_procession_set = {
  arrival = {"platform-to-planet-b"},
  departure = {"planet-to-platform-a"},
}
shattered_core_planet.procession_graphic_catalogue = planet_catalogue_fulgora
shattered_core_planet.surface_properties = {
  ["day-night-cycle"] = 1 * minute,
  ["magnetic-field"] = 0,
  ["solar-power"] = 1,
  pressure = 20,
  gravity = 1,
}
shattered_core_planet.lightning_properties = {
  lightnings_per_chunk_per_tick = 5 / (60 * 10), --cca once per chunk every 10 seconds (600 ticks)
  search_radius = 10.0,
  --lightning_types = {"bm-shattered-lightning"},
  lightning_types = {"lightning"},
  priority_rules = util.table.deepcopy(fulgora_planet.lightning_properties.priority_rules)
}
shattered_core_planet.surface_render_parameters = util.table.deepcopy(fulgora_planet.surface_render_parameters)
shattered_core_planet.persistent_ambient_sounds = util.table.deepcopy(fulgora_planet.persistent_ambient_sounds)

--add explosion sounds in distance

data:extend({shattered_core_planet})
data.raw["space-location"]["shattered-planet"] = nil



-------------------------------------------------------------------TILES
local promethium_rock_tile = util.table.deepcopy(data.raw.tile["fulgoran-rock"])
promethium_rock_tile.name = "bm-promethium-rock"
promethium_rock_tile.tint = {1, 0, 0}
promethium_rock_tile.map_color = {1, 0.2, 0.2}
promethium_rock_tile.autoplace.probability_expression = "bm_promethium_core"
promethium_rock_tile.sprite_usage_surface = "any"
promethium_rock_tile.absorptions_per_second = {pollution = 0}

data:extend({promethium_rock_tile})
