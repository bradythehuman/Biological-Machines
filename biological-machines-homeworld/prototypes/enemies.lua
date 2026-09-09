local hit_effects = require("__base__.prototypes.entity.hit-effects")



--UPDATE SMALL BITERS
--prevents alerts when station bots kill biters
data.raw.unit["small-biter"].alert_when_damaged = false

data.raw.unit["small-biter"].autoplace = {
  order = "a",
  force = "player",
  probability_expression = "bm_station_biter",
}



--STATION BOT
local compilatron_animations = {
  walk = {
    width = 78,
    height = 104,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 32,
    shift = util.by_pixel(0.0, -14),
    scale = 0.5,
    stripes = {
      {
        filename = "__biological-machines-homeworld__/graphics/compilatron/compilatron-walk-1.png",
        width_in_frames = 2,
        height_in_frames = 16
      },
      {
        filename = "__biological-machines-homeworld__/graphics/compilatron/compilatron-walk-2.png",
        width_in_frames = 2,
        height_in_frames = 16
      }
    }
  },
  walk_shadow = {
    width = 142,
    height = 56,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 32,
    shift = util.by_pixel(15.5, -0.5),
    draw_as_shadow = true,
    scale = 0.5,
    stripes = util.multiplystripes(2, {
      {
        filename = "__biological-machines-homeworld__/graphics/compilatron/compilatron-walk-shadow.png",
        width_in_frames = 1,
        height_in_frames = 32
      }
    })
  }
}

data:extend({
  {
    type = "unit",
    name = "bm-station-bot",
    icon =  "__biological-machines-homeworld__/graphics/compilatron/compilatron.png",
    icon_size = 64,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "not-flammable"},
    map_color = {r = 0, g = 0.365, b = 0.58, a = 1},
    max_health = 3000,
    order = "z-z-z",
    subgroup = "enemies",
    has_belt_immunity = true,
    selectable_in_game = true,
    can_open_gates = true,
    healing_per_tick = 50 / 60,
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.8, -1.3}, {0.8, 0.5}},
    ---[[
    attack_parameters = {
      type = "projectile",
      damage_modifier = 1,
      range = 10,
      cooldown = 35,
      ammo_category = "melee",
      ammo_type = {
        category = "melee",
        target_type = "entity",
        action = {
          type = "direct",
          action_delivery = {
            type = "instant",
            target_effects = {
              type = "damage",
              damage = {
                amount = 0,
                type = "physical"
              }
            }
          }
        }
      },
      animation = {
        layers = {
          compilatron_animations.walk_shadow,
          compilatron_animations.walk
        }
      }
    },
    --]]
    --[[
    attack_parameters = {
      type = "projectile",
      damage_modifier = 1,
      range = 0.5,
      cooldown = 35,
      ammo_category = "melee",
      ammo_type = {
        category = "melee",
        target_type = "entity",
        action = {
          type = "direct",
          action_delivery = {
            type = "instant",
            target_effects = {
              type = "damage",
              damage = {
                amount = 10,
                type = "physical"
              }
            }
          }
        }
      },
      animation = {
        layers = {
          compilatron_animations.walk_shadow,
          compilatron_animations.walk
        }
      }
    },
    --]]
    vision_distance = 15,
    movement_speed = 0.1,
    distance_per_frame = 0.1,
    --absorptions_to_join_attack = { pollution = 1 },
    distraction_cooldown = 300,
    min_pursue_time = 5 * 60,
    max_pursue_distance = 25,
  	corpse = "small-remnants",
  	dying_explosion = "steel-chest-explosion",
    run_animation = {
      layers = {
        compilatron_animations.walk_shadow,
        compilatron_animations.walk
      }
    },
    water_reflection = {
      pictures = {
        filename = "__biological-machines-homeworld__/graphics/compilatron/compilatron-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 20,
        shift = util.by_pixel(0, 67 * 0.5),
        scale = 5,
        variation_count = 1
      },
      rotate = false,
      orientation_to_variation = false
    },
    loot = {{type = "item", name = "bm-energy-link-core", amount = 1}},
    autoplace = {
      order = "a",
      force = "enemy",
      probability_expression = "bm_station_bot",
    },
    damaged_trigger_effect = {
      type = "create-entity",
      entity_name = "distractor",
      as_enemy = true,
      probability = 0.1
    },
    dying_trigger_effect = {
      type = "create-entity",
      entity_name = "distractor",
      as_enemy = true,
      offsets = {
        {x = -1, y = -1},
        {x = -1, y = 0},
        {x = -1, y = 1},
        {x = 0, y = -1},
        {x = 0, y = 0},
        {x = 0, y = 1},
        {x = 1, y = -1},
        {x = 1, y = 0},
        {x = 1, y = 1},
      },
    },
  },
})



--MARKET SPAWNER
data:extend({
  {
    type = "unit-spawner",
    name = "bm-market-spawner",
    icon = "__base__/graphics/icons/market.png",
    flags = {"placeable-player", "placeable-enemy", "not-repairable"},
    max_health = 1000,
    order="b-d-a",
    subgroup="enemies",
    --[[
    resistances =
    {
      {
        type = "physical",
        decrease = 2,
        percent = 15
      },
      {
        type = "explosion",
        decrease = 5
      },
      {
        type = "fire",
        decrease = 3,
        percent = 60
      }
    },
    ]]
    working_sound = {
      sound = {category = "enemy", filename = "__base__/sound/creatures/spawner.ogg", volume = 0.6, modifiers = volume_multiplier("main-menu", 0.7) },
      max_sounds_per_prototype = 3
    },
    dying_sound = {
      variations = sound_variations("__base__/sound/creatures/spawner-death", 5, 0.7, volume_multiplier("main-menu", 0.55) ),
      aggregation = { max_count = 2, remove = true, count_already_playing = true }
    },
    healing_per_tick = 0.02,
    --collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    --map_generator_bounding_box = {{-3.7, -3.2}, {3.7, 3.2}},
    --selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.biter(),
    --impact_category = "organic",
    -- in ticks per 1 pu
    absorptions_per_second = { pollution = { absolute = 20, proportional = 0.01 } },
    corpse = "biter-spawner-corpse",
    dying_explosion = "biter-spawner-die",
    max_count_of_owned_units = 7,
    max_friends_around_to_spawn = 5,
    --[[
    graphics_set = {
      animations = {
        sheet = {
          filename = "__base__/graphics/entity/character/footprints.png",
          line_length = 1,
          frame_count = 1,
          width = 30,
          height = 22,
          shift = util.by_pixel(0.25, 0.25),
          scale = 0.5,
          variation_count = 1
        }
      }
    },
    ]]
    result_units = {{"small-biter", {{0, 1}, {1, 1}}}},
    spawning_cooldown = {360, 360},
    spawning_radius = 2,
    spawning_spacing = 1,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    autoplace = {
      order = "b",
      probability_expression = "bm_station_market_spawner",
      force = "player",
    },
    call_for_help_radius = 50,
    time_to_capture = 60 * 20,
    --spawn_blocked_trigger = spawn_blocked_trigger,

    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    selection_box = {{-2, -2}, {2, 2}},
    graphics_set = {
      animations = {
        sheet = {
          filename = "__biological-machines-homeworld__/graphics/market-spawner.png",
          width = 184, --156
          height = 137, --127
          shift = {0.45, 0.2},
          line_length = 1,
          frame_count = 1,
          variation_count = 1,
        },
      },
    },
    corpse = "big-remnants",
    impact_category = "metal",
    alert_when_damaged = false,
    minable = {
      mining_time = 5,
      transfer_entity_health_to_products = false,
      results = {
        {type = "item", name = "steel-plate", amount = 5, independent_probability = 0.25},
        {type = "item", name = "iron-plate", amount = 20, independent_probability = 0.25},
      },
    },
    --[[
    loot = {
      {type = "item", name = "steel-plate", amount = 5, independent_probability = 0.25},
      {type = "item", name = "iron-plate", amount = 20, independent_probability = 0.25},
    },
    ]]
  },
})
