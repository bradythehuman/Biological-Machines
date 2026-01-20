local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

local ch = require("__biological-machines-planet-balack__.color-helper")
local mp = require("__biological-machines-planet-balack__.prototypes.make-pentapods")



------------------------------------------------------------------WORM
local function balack_worm_integration_impl(scale, skip_frames, use_frames, skip_animation)
  local frame_sequence = {}
  for i = 1, use_frames do
    frame_sequence[i] = i + skip_frames
  end

  local params = {scale = scale * 0.5, multiply_shift = scale}
  if not skip_animation then
    params.variation_count = 1
    params.frame_count = 25
    params.frame_sequence = frame_sequence
  end
  params.surface = "any"
  params.usage = "enemy"
  params.allow_forced_downscale = true

  local result = util.sprite_load("__biological-machines-planet-balack__/graphics/decorative/worm-hole/worm-hole-collapse", params)
  if skip_animation then result.line_length = nil end
  return result;
end

local function balack_worm_integration(scale, skip_animation)
  return balack_worm_integration_impl(scale, 0, 1, skip_animation)
end

local function balack_worm_integration_decay(scale)
  return balack_worm_integration_impl(scale, 1, 24)
end

local balack_worm = util.table.deepcopy(data.raw["turret"]["behemoth-worm-turret"])
balack_worm.name = "bm-balack-behemoth-worm"
balack_worm.max_health = 6000
balack_worm.resistances = {
  {type = "physical", decrease = 16, percent = 0},
  {type = "explosion", decrease = 50, percent = 25},
  {type = "fire", decrease = 3, percent = 98},
  {type = "laser", decrease = 10, percent = 98},
  {type = "impact", decrease = 0, percent = 50},
  --{type = "acid", decrease = 0, percent = 0},
  {type = "poison", decrease = 3, percent = 50},
  {type = "electric", decrease = 20, percent = 90},
}
--balack_worm.collision_mask = {layers={}}
--balack_worm.collision_mask = {layers={player=true, train=true, is_object=true}, not_colliding_with_itself=true}
--balack_worm.collision_mask = {layers={player=true}}
--balack_worm.collision_mask = {layers={item=true, object=true, player=true, is_object=true, is_lower_object=true}, not_colliding_with_itself=true}
balack_worm.collision_mask = {layers={item=true, object=true, player=true, is_object=true, is_lower_object=true, ghost=true}}
balack_worm.integration = balack_worm_integration(1.2, true)
balack_worm.corpse = "bm-balack-behemoth-worm-corpse"
balack_worm.folded_state_corpse = "bm-balack-behemoth-worm-corpse-burrowed"
balack_worm.spawn_decoration = nil
balack_worm.autoplace = {
  probability_expression = "spot_noise{\z
    x = x,\z
    y = y,\z
    seed0 = map_seed,\z
    seed1 = 2323,\z
    candidate_spot_count = 4,\z
    suggested_minimum_candidate_point_spacing = 100,\z
    skip_span = 3,\z
    skip_offset = 2,\z
    region_size = 150,\z
    density_expression = 1,\z
    spot_quantity_expression = 1,\z
    spot_radius_expression = 1,\z
    hard_region_target_quantity = 0,\z
    spot_favorability_expression = 1,\z
    basement_value = -1,\z
    maximum_spot_basement_radius = 128\z
  } - bm_bio_cube_enemy_buffer - 1000 * bm_balack_oil_ocean_deep_mask",
  restriction = {"bm-balack-n-rock", "bm-balack-n-sand", "bm-balack-n-dunes", "bm-balack-oil-shallow"},
  force = "enemy",
  order = "a",
}

local balack_worm_corpse = util.table.deepcopy(data.raw["corpse"]["behemoth-worm-corpse"])
balack_worm_corpse.name = "bm-balack-behemoth-worm-corpse"
balack_worm_corpse.ground_patch = {sheet = balack_worm_integration(1.2)}
balack_worm_corpse.ground_patch_decay = {sheet = balack_worm_integration_decay(1.2)}

local balack_worm_corpse_burried = util.table.deepcopy(data.raw["corpse"]["behemoth-worm-corpse"])
balack_worm_corpse_burried.name = "bm-balack-behemoth-worm-corpse-burrowed"
balack_worm_corpse_burried.ground_patch = {sheet = balack_worm_integration(1.2)}
balack_worm_corpse_burried.ground_patch_decay = {sheet = balack_worm_integration_decay(1.2)}

data:extend({balack_worm, balack_worm_corpse, balack_worm_corpse_burried})



------------------------------------------------------------PENTAPODS
--[[
--local balack_stomper = util.table.deepcopy(data.raw["spider-unit"]["big-stomper-pentapod"])
local balack_stomper = util.table.deepcopy(data.raw["spider-unit"]["small-stomper-pentapod"])
balack_stomper.name = "bm-balack-big-stomper"
balack_stomper.max_health = 15000
]]
--local big_stomper = data.raw["spider-unit"]["big-stomper-pentapod"]
--local big_stomper_corpse = data.raw["corpse"]["big-stomper-corpse"]
--local gleba_big_mask_tint  = {100, 0, 100, 255}
local gleba_big_mask_tint  = {75, 10, 75, 255}
--local gleba_big_mask2_tint  = {100, 75, 100, 255}
local gleba_big_mask2_tint  = {75, 60, 75, 255}
--local gleba_big_body_tint = {117, 90, 104, 255}
local gleba_big_body_tint = {85, 70, 80, 255}
mp.make_balack_stomper("bm-balack-", 0.9, 15000, 1.6, 1.8, {
  --mask = ch.fade({216,0,35,255}, 0.4),
  mask = ch.fade(gleba_big_mask_tint, 0.4),
  --mask_thigh = ch.fade({216,100,35,255}, 0.3),
  mask_thigh = ch.fade(gleba_big_mask2_tint, 0.3),
  body = ch.grey_overlay(gleba_big_body_tint, 0.1),
  --body_thigh = ch.lerp_color({117,116,104,255}, ch.grey_overlay({250,108,0,255}, 0.7), 0.1) -- more orange/yellow
  body_thigh = ch.lerp_color(gleba_big_body_tint, ch.grey_overlay({150, 75, 150, 255}, 0.7), 0.1) -- more orange/yellow
}, simulations.factoriopedia_gleba_enemy_big_stomper, space_age_sounds.stomper_pentapod.big)
--local balack_stomper = util.table.deepcopy(data.raw["spider-unit"]["big-stomper-pentapod"])
balack_stomper = data.raw["spider-unit"]["bm-balack-stomper-pentapod"]
--local balack_stomper_corpse = util.table.deepcopy(data.raw["corpse"]["big-stomper-corpse"])
--data.raw["spider-unit"]["big-stomper-pentapod"] = big_stomper
--data.raw["corpse"]["big-stomper-corpse"] = big_stomper_corpse

--balack_stomper.name = "bm-balack-stomper-pentapod"
--balack_stomper.corpse = "bm-balack-stomper-pentapod-corpse"
balack_stomper.absorptions_to_join_attack = {pollution = 400}
balack_stomper.resistances = {
  {type = "physical", decrease = 16, percent = 25},
  {type = "explosion", decrease = 50, percent = 0},
  {type = "fire", decrease = 3, percent = 50},
  {type = "laser", decrease = 10, percent = 98},
  {type = "impact", decrease = 0, percent = 98},
  --{type = "acid", decrease = 0, percent = 0},
  {type = "poison", decrease = 3, percent = 90},
  {type = "electric", decrease = 20, percent = 50},
}
balack_stomper.ai_settings.join_attacks = true
balack_stomper.ai_settings.allow_try_return_to_spawner = false
balack_stomper.dying_trigger_effect = {{
  type = "create-entity",
  --entity_name = "big-wriggler-pentapod-premature",
  entity_name = "bm-balack-wriggler-pentapod-premature",
  find_non_colliding_position = true,
  as_enemy = true,
  offsets = {
    util.rotate_position({0,1}, 0.1),
    util.rotate_position({0,1}, 0.3),
    util.rotate_position({0,1}, 0.5),
    util.rotate_position({0,1}, 0.7),
    util.rotate_position({0,1}, 0.9),
    util.rotate_position({0,2}, 0.0),
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
    util.rotate_position({0,2}, 0.95),
  }
}}
balack_stomper.spawning_time_modifier = 10
--balack_stomper_corpse.name = "bm-balack-stomper-pentapod-corpse"

local balack_stomper_shell = data.raw["simple-entity"]["bm-balack-stomper-shell"]
balack_stomper_shell.created_effect = nil
balack_stomper_shell.autoplace = {
  probability_expression = "spot_noise{\z
    x = x,\z
    y = y,\z
    seed0 = map_seed,\z
    seed1 = 4321,\z
    candidate_spot_count = 12,\z
    suggested_minimum_candidate_point_spacing = 100,\z
    skip_span = 3,\z
    skip_offset = 2,\z
    region_size = 150,\z
    density_expression = 1,\z
    spot_quantity_expression = 1,\z
    spot_radius_expression = 1,\z
    hard_region_target_quantity = 0,\z
    spot_favorability_expression = bm_balack_natural_and_mesa_mask > 0.01,\z
    basement_value = -1,\z
    maximum_spot_basement_radius = 128\z
  } - 1000 * bm_balack_oil_mask",
  restriction = {"bm-balack-n-rock", "bm-balack-n-sand", "bm-balack-n-dunes", "bm-balack-n-dust"},
  force = "enemy",
  order = "a",
}
balack_stomper_shell.minable.results = nil
balack_stomper_shell.dying_trigger_effect = util.table.deepcopy(balack_stomper.dying_trigger_effect)



--local big_wriggler = data.raw["unit"]["big-wriggler-pentapod"]
--local big_wriggler_premature = data.raw["unit"]["big-wriggler-pentapod-premature"]
--local big_wriggler_corpse = data.raw["corpse"]["big-wriggler-pentapod-corpse"]
mp.make_balack_wriggler("bm-balack-", 1.0, 1000, 1.8, {
    --mask = ch.fade({216,0,35,255}, 0.5),
    mask = ch.fade(gleba_big_mask_tint, 0.5),
    --body = {117,116,104,255},
    body = gleba_big_body_tint,
  },
  simulations.factoriopedia_gleba_enemy_big_wriggler,
  simulations.factoriopedia_gleba_enemy_big_wriggler_premature,
  space_age_sounds.wriggler_pentapod.big
)
--local balack_wriggler = util.table.deepcopy(data.raw["unit"]["big-wriggler-pentapod-premature"])
data.raw["unit"]["bm-balack-wriggler-pentapod"] = nil
data.raw["unit"]["bm-balack-wriggler-pentapod-premature"].resistances = {
  {type = "physical", decrease = 16, percent = 25},
  {type = "explosion", decrease = 50, percent = 0},
  {type = "fire", decrease = 3, percent = 50},
  {type = "laser", decrease = 10, percent = 98},
  {type = "impact", decrease = 0, percent = 98},
  --{type = "acid", decrease = 0, percent = 0},
  {type = "poison", decrease = 3, percent = 90},
  {type = "electric", decrease = 20, percent = 50},
}
--local balack_wriggler = data.raw["unit"]["bm-balack-wriggler-pentapod-premature"]
--local balack_wriggler_corpse = util.table.deepcopy(data.raw["corpse"]["big-wriggler-pentapod-corpse"])
--data.raw["unit"]["big-wriggler-pentapod"] = big_wriggler
--data.raw["unit"]["big-wriggler-pentapod-premature"] = big_wriggler_premature
--data.raw["corpse"]["big-wriggler-pentapod-corpse"] = big_wriggler_corpse

--balack_wriggler.name = "bm-balack-wriggler-pentapod-premature"
--balack_wriggler.corpse = "bm-balack-wriggler-pentapod-corpse"
--balack_wriggler_corpse.name = "bm-balack-wriggler-pentapod-corpse"



----------------------------------------------------------SNAPPER
local balack_big_snapper = util.table.deepcopy(data.raw["unit"]["big-armoured-biter"])
balack_big_snapper.name = "bm-balack-big-snapper"
balack_big_snapper.max_health = 6000
balack_big_snapper.absorptions_to_join_attack = {pollution = 20}
balack_big_snapper.resistances = {
  {type = "physical", decrease = 16, percent = 0},
  {type = "explosion", decrease = 50, percent = 25},
  {type = "fire", decrease = 3, percent = 90},
  {type = "laser", decrease = 10, percent = 98},
  {type = "impact", decrease = 0, percent = 50},
  --{type = "acid", decrease = 0, percent = 0},
  {type = "poison", decrease = 3, percent = 50},
  {type = "electric", decrease = 20, percent = 96},
}
balack_big_snapper.spawning_time_modifier = 1
--balack_big_snapper.movement_speed = 0.3

--local balack_behemoth_snapper_scale = 1.25
local balack_behemoth_snapper_scale = 1.5
--local balack_behemoth_snapper_tint1 = {0.9, 0.23, 0.23, 0.95}
local balack_behemoth_snapper_tint1 = {0.4, 0.55, 0.4, 0.95}
--local balack_behemoth_snapper_tint2 = {0.78, 0.84, 0, 0.9}
local balack_behemoth_snapper_tint2 = {0.35, 0.95, 0.45, 0.9}
local balack_behemoth_snapper = util.table.deepcopy(data.raw["unit"]["behemoth-armoured-biter"])
balack_behemoth_snapper.name = "bm-balack-behemoth-snapper"
balack_behemoth_snapper.max_health = 15000
balack_behemoth_snapper.absorptions_to_join_attack = {pollution = 200}
balack_behemoth_snapper.resistances = {
  {type = "physical", decrease = 16, percent = 0},
  {type = "explosion", decrease = 50, percent = 25},
  {type = "fire", decrease = 3, percent = 90},
  {type = "laser", decrease = 10, percent = 98},
  {type = "impact", decrease = 0, percent = 50},
  --{type = "acid", decrease = 0, percent = 0},
  {type = "poison", decrease = 3, percent = 50},
  {type = "electric", decrease = 20, percent = 96},
}
--balack_behemoth_snapper.movement_speed = 0.33
balack_behemoth_snapper.dying_trigger_effect = {
  type = "create-entity",
  entity_name = "bm-balack-behemoth-worm",
  as_enemy = true,
  find_non_colliding_position = true,
}
balack_behemoth_snapper.spawning_time_modifier = 5
balack_behemoth_snapper.damaged_trigger_effect = table.deepcopy(data.raw["unit"]["behemoth-biter"].damaged_trigger_effect)
balack_behemoth_snapper.corpse = "bm-balack-behemoth-snapper-corpse"
balack_behemoth_snapper.run_animation = armoredRunBiter(
  balack_behemoth_snapper_scale,
  balack_behemoth_snapper_tint1,
  balack_behemoth_snapper_tint2
)
balack_behemoth_snapper.attack_parameters = {
  type = "projectile",
  range = 2.2,
  cooldown = 60,
  sound = sounds.biter_roars_behemoth(1),
  animation = armoredAttackBiter(
    balack_behemoth_snapper_scale,
    balack_behemoth_snapper_tint1,
    balack_behemoth_snapper_tint2
  ),
  ammo_category = "melee",
  ammo_type = {
    target_type = "entity",
    action = {
      {
        action_delivery = {
          target_effects = {
            damage = {
                amount = (350),
                type = "physical"
            },
            type = "damage",
            show_in_tooltip = true
          },
          type = "instant"
        },
        type = "direct"
      },
      {
        type = "area",
        radius = 2,
        force = "enemy",
        ignore_collision_condition = true,
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "damage",
              damage = {amount = 100, type = "physical"}
            },
            {
              type = "create-particle",
              repeat_count = 5,
              particle_name = "explosion-remnants-particle",
              initial_height = 0.5,
              speed_from_center = 0.08,
              speed_from_center_deviation = 0.15,
              initial_vertical_speed = 0.08,
              initial_vertical_speed_deviation = 0.15,
              offset_deviation = {{-0.2, -0.2}, {0.2, 0.2}},
            }
          }
        }
      }
    }
  }
}

local balack_behemoth_snapper_corpse = add_biter_armoured_die_animation(
  balack_behemoth_snapper_scale,
  balack_behemoth_snapper_tint1,
  balack_behemoth_snapper_tint2,
  {
    type = "corpse",
    name = "bm-balack-behemoth-snapper-corpse",
    icon = "__ArmouredBiters__/graphics/icons/leviathan-armoured-biter.png",
    icon_size = 64,
    --selection_box = {{-2.5, -1.8}, {2.5, 1.8}},
    selection_box = {{-3, -2.1}, {3, 2.1}},
    selectable_in_game = false,
    subgroup = "corpses",
    order = "c[corpse]-a[biter]-a[small]",
    flags = {
      "placeable-neutral",
      "placeable-off-grid",
      "building-direction-8-way",
      "not-repairable",
      "not-on-map"
    }
  }
)

data:extend({
  balack_big_snapper, balack_behemoth_snapper, balack_behemoth_snapper_corpse,
})



----------------------------------------------------------SPAWNER
data:extend({
  {
    type = "unit-spawner",
    name = "bm-balack-ruin-vault",
    icon = "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-vault.png",
    flags = {"placeable-player", "placeable-enemy", "not-repairable", "placeable-off-grid"},
    --flags = {"placeable-player", "not-repairable", "placeable-off-grid"},
    order = "s-d-b",
    subgroup = "enemies",

    --HEALTH
    max_health = 100,
    impact_category = "stone",
    --healing_per_tick = 10/60,

    --GRAPHICS
    collision_box = {{-6.88, -4}, {6.88, 4}},
    --collision_mask = {layers={player=true, object=true, ground_tile=true, is_object=true, is_lower_object=true}}, -- can go in shallow water
    selection_box = {{-6.88, -4}, {6.88, 4}},
    --hit_visualization_box = {{-1, -0.75}, {1, 0.75}},
    graphics_set = {
      animations = {
        filenames = {"__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-vault.png"},
        lines_per_file = 1,
        slice = 1,
        frame_count = 1,
        scale = 0.5,
        width = 960,
        height = 640,
      },
    },

    --SOUND
    working_sound = {
      sound = {category = "enemy", filename = "__base__/sound/creatures/spawner-spitter.ogg", volume = 0.6, modifiers = volume_multiplier("main-menu", 0.7) },
      max_sounds_per_prototype = 3,
    },

    --UNIT SPAWNING
    absorptions_per_second = { pollution = { absolute = 10000, proportional = 1 } }, --gleba 20, 0.01
    max_count_of_owned_units = 25,
    max_count_of_owned_defensive_units = 1,
    max_friends_around_to_spawn = 25,
    max_defensive_friends_around_to_spawn = 2,
    result_units = {
      {"bm-balack-big-snapper", {{0, 0.5}, {0.5, 0.5}, {1, 0.5}}},
      {"bm-balack-behemoth-snapper", {{0, 0.1}, {0.5, 0.1}, {1, 0.1}}},
      {"bm-balack-stomper-pentapod", {{0, 0.05}, {0.5, 0.05}, {1, 0.05}}},
    },
    -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
    spawning_cooldown = {6, 6}, --gleba {360, 150}
    spawning_radius = 25, --gleba 10
    spawning_spacing = 3,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    call_for_help_radius = 50,

    --AUTOPLACE
    autoplace = {
      probability_expression = "(min(bm_balack_spots, (1 - bm_balack_starting_vault_cone) / 2) < 0.015) * min(bm_balack_vaults_and_starting_vault, x * x + y * y - (375 ^ 2))",
      force = "enemy",
      --order = "b[enemy]-a[spawner]",
      --richness_expression = 1,
    },
  },
})

table.insert(bm_add_full_resistences, data.raw["unit-spawner"]["bm-balack-ruin-vault"])
