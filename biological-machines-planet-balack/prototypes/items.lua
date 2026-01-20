local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


--[[
-greasy sludge
-new scrap
-ai control unit. direct module (no beacons)
  -increases speed/polution, decreases energy consumption/quality
-radiation sheilding
-hyperspace drive
-hyperspace power cell
-mech armor mk2
]]


local foundation_placable = data.raw["item"]["foundation"].place_as_tile.tile_condition
table.insert(foundation_placable, "bm-balack-oil-shallow")
table.insert(foundation_placable, "bm-balack-oil-deep")



local warp_cell = data.raw["item"]["bm-warp-power-cell"]
warp_cell.default_import_location = "bm-balack"
warp_cell.subgroup = "bm-balack-processes"
warp_cell.order = "e-b"



data:extend({
  {
    type = "item",
    name = "bm-balack-scrap",
    icon = "__biological-machines-planet-balack__/graphics/balack-scrap.png",
    pictures =
    {
      { size = 64, filename = "__biological-machines-planet-balack__/graphics/balack-scrap.png",   scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__biological-machines-planet-balack__/graphics/balack-scrap-1.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__biological-machines-planet-balack__/graphics/balack-scrap-2.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__biological-machines-planet-balack__/graphics/balack-scrap-3.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__biological-machines-planet-balack__/graphics/balack-scrap-4.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__biological-machines-planet-balack__/graphics/balack-scrap-5.png", scale = 0.5, mipmap_count = 4 }
    },
    subgroup = "bm-balack-processes",
    order = "a",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    default_import_location = "bm-balack",
    weight = 2*kg
  },
  {
    type = "fluid",
    name = "bm-oil-sludge",
    icon = "__biological-machines-k2-assets__/graphics/oil-sludge.png",
    subgroup = "fluid",
    order = "z",
    default_temperature = 15,
    max_temperature = 100,
    heat_capacity = "0.2kJ",
    base_color = {0, 0.15, 0.4},
    flow_color = {0, 0.35, 0.7},
    auto_barrel = false
  },
  {
    type = "item",
    name = "bm-bio-cube",
    icon = "__biological-machines-planet-balack__/graphics/bio_cube/pathogen-lab-icon.png",
    icon_size = 64,
    subgroup = "agriculture",
    order = "z[biter-nest]-a",
    place_result = "bm-bio-cube",
    stack_size = 1,
    weight = 10000 * kg,
  },
  {
    type = "item",
    name = "bm-radiation-sheilding",
    icon = "__biological-machines-k2-assets__/graphics/radiation-sheilding.png",
    pictures = {
      layers = {
        {
          size = 64,
          filename = "__biological-machines-k2-assets__/graphics/radiation-sheilding.png",
          scale = 0.5,
          mipmap_count = 4
        },
        {
          draw_as_light = true,
          size = 64,
          filename = "__biological-machines-k2-assets__/graphics/radiation-sheilding-light.png",
          scale = 0.5
        }
      }
    },
    subgroup = "bm-balack-processes",
    order = "c-a",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 50,
    default_import_location = "bm-balack",
    weight = 10*kg
  },
  {
    type = "item",
    name = "bm-bio-cube-ooze",
    icon = "__biological-machines-planet-balack__/graphics/bio-cube-ooze.png",
    subgroup = "bm-balack-processes",
    order = "c-b",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    fuel_category = "chemical",
    fuel_value = "1MJ",
    stack_size = 100,
    default_import_location = "bm-balack",
    spoil_ticks = 15 * minute,
    spoil_result = "spoilage",
    weight = 0.5 * kg,
  },
  {
    type = "module",
    name = "bm-ai-control-unit",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-dark.png",
    subgroup = "module",
    color_hint = { text = "S" },
    category = "bm-ai",
    tier = 3,
    order = "z[ai-control-unit]",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    stack_size = 10,
    weight = 100 * kg,
    effect = {
      productivity = -0.2,
      consumption = 1,
      pollution = 0.2,
      speed = 1,
      quality = -0.5,
    },
    default_import_location = "bm-balack",
    art_style = "vanilla",
    requires_beacon_alt_mode = false,
    beacon_tint = {
      primary = {0.761, 0, 1, 1.000},
      secondary = {0, 0.3, 0},
    },
  },
  {
    type = "module",
    name = "bm-ai-control-unit-active",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-light.png",
    subgroup = "module",
    color_hint = { text = "S" },
    category = "bm-ai",
    tier = 4,
    order = "z[ai-control-unit]-a",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    stack_size = 10,
    weight = 100 * kg,
    effect = {
      productivity = -0.2,
      consumption = 1,
      pollution = 1,
      speed = 1,
      quality = 2.5,
    },
    default_import_location = "bm-balack",
    spoil_ticks = 15 * minute,
    spoil_result = "bm-ai-control-unit"
  },
  {
    type = "item",
    name = "bm-warp-drive-part",
    icons = {
      {
        icon = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-icon.png",
      },
      {
        icon = "__base__/graphics/icons/iron-gear-wheel.png",
        scale = 0.25,
        shift = {8, -8},
      },
    },
    subgroup = "bm-balack-processes",
    order = "e-a",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    default_import_location = "bm-balack",
    stack_size = 10,
    weight = 100 * kg,
  },
  {
    type = "item-with-entity-data",
    name = "bm-tank-mk2",
    icons = {
      {icon = "__base__/graphics/icons/tank.png"},
      {icon = "__biological-machines-k2-assets__/graphics/tier-2.png"},
    },
    subgroup = "transport",
    order = "b[personal-transport]-b[tank]-a",
    inventory_move_sound = item_sounds.vehicle_inventory_move,
    pick_sound = item_sounds.vehicle_inventory_pickup,
    drop_sound = item_sounds.vehicle_inventory_move,
    place_result = "bm-tank-mk2",
    default_import_location = "bm-balack",
    stack_size = 1,
    weight = 1000 * kg,
  },
  {
    type = "gun",
    name = "bm-tank-mk2-cannon",
    icon = "__base__/graphics/icons/tank-cannon.png",
    hidden = true,
    auto_recycle = false,
    subgroup = "gun",
    order = "z[tank]-a[cannon]",
    inventory_move_sound = item_sounds.ammo_large_inventory_move,
    pick_sound = item_sounds.ammo_large_inventory_pickup,
    drop_sound = item_sounds.ammo_large_inventory_move,
    attack_parameters = {
      type = "projectile",
      ammo_category = "cannon-shell",
      cooldown = 60,
      movement_slow_down_factor = 0,
      projectile_creation_distance = 1.6 * 1.5,
      projectile_center = {-0.15625 * 1.5, -0.07812 * 1.5},
      range = 30,
      sound = sounds.tank_gunshot
    },
    stack_size = 1
  },
  {
    type = "gun",
    name = "bm-tank-mk2-machine-gun",
    icon = "__base__/graphics/icons/submachine-gun.png",
    hidden = true,
    auto_recycle = false,
    subgroup = "gun",
    order = "a[basic-clips]-b[tank-machine-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 2,
      movement_slow_down_factor = 0.7,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -0.6875,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_center = {-0.15625, -0.07812},
      projectile_creation_distance = 1,
      range = 20,
      sound = sounds.heavy_gunshot
    },
    stack_size = 1
  },
  {
    type = "gun",
    name = "bm-tank-mk2-flamethrower",
    icon = "__base__/graphics/icons/flamethrower.png",
    hidden = true,
    auto_recycle = false,
    subgroup = "gun",
    order = "b[flamethrower]-b[tank-flamethrower]",
    attack_parameters = {
      type = "stream",
      ammo_category = "flamethrower",
      cooldown = 0.5,
      gun_barrel_length = 1.4 * 1.5,
      gun_center_shift = {-0.17 * 1.5, -1.15 * 1.5},
      range = 15, --base 9
      min_range = 3,
      cyclic_sound =
      {
        begin_sound = {filename = "__base__/sound/fight/flamethrower-start.ogg", volume = 1},
        middle_sound = {filename = "__base__/sound/fight/flamethrower-mid.ogg", volume = 1},
        end_sound = {filename = "__base__/sound/fight/flamethrower-end.ogg", volume = 1}
      }
    },
    stack_size = 1
  },
  --[[
  {
    type = "gun",
    name = "bm-tank-mk2-teslagun",
    icon = "__space-age__/graphics/icons/teslagun.png",
    subgroup = "gun",
    order = "a[basic-clips]-h[teslagun]",
    inventory_move_sound = item_sounds.weapon_large_inventory_move,
    pick_sound = item_sounds.weapon_large_inventory_pickup,
    drop_sound = item_sounds.weapon_large_inventory_move,
    attack_parameters = {
      type = "beam",
      ammo_category = "tesla",
      cooldown = 60,
      movement_slow_down_factor = 0,
      --source_offset = {0, -10},
      source_direction_count = 8,
      range = 24
    },
    default_import_location = "fulgora",
    stack_size = 5
  },
  ]]
  {
    type = "gun",
    name = "bm-tank-mk2-railgun",
    icon = "__space-age__/graphics/icons/railgun.png",
    subgroup = "gun",
    order = "a[basic-clips]-h[railgun]",
    hidden = true,
    inventory_move_sound = item_sounds.weapon_large_inventory_move,
    pick_sound = item_sounds.weapon_large_inventory_pickup,
    drop_sound = item_sounds.weapon_large_inventory_move,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "railgun",
      cooldown = 120,
      movement_slow_down_factor = 0,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        projectile_creation_distance = 1.6 * 1.5,
        projectile_center = {-0.15625 * 1.5, -0.07812 * 1.5},
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = 40,
      sound = space_age_sounds.railgun_gunshot
    },
    stack_size = 1
  },
  {
    type = "armor",
    name = "bm-mech-armor-mk2",
    icons = {
      {icon = "__space-age__/graphics/icons/mech-armor.png"},
      {icon = "__biological-machines-k2-assets__/graphics/tier-2.png"},
    },
    resistances = {
      {type = "physical", decrease = 10, percent = 60},
      {type = "acid", decrease = 0, percent = 80},
      {type = "explosion", decrease = 60, percent = 60},
      {type = "fire", decrease = 10, percent = 80},
      {type = "poison", decrease = 0, percent = 100},
    },
    subgroup = "armor",
    order = "f[mech-armor]-a",
    --factoriopedia_simulation = simulations.factoriopedia_mech_armor,
    inventory_move_sound = item_sounds.armor_large_inventory_move,
    pick_sound = item_sounds.armor_large_inventory_pickup,
    drop_sound = item_sounds.armor_large_inventory_move,
    infinite = true,
    equipment_grid = "bm-colossal-equipment-grid",
    inventory_size_bonus = 100,
    provides_flight = true,
    takeoff_sound = {filename = "__space-age__/sound/entity/mech-armor/mech-armor-takeoff.ogg", volume = 0.2, aggregation = {max_count = 2, remove = true, count_already_playing = true}},
    landing_sound = {filename = "__space-age__/sound/entity/mech-armor/mech-armor-land.ogg", volume = 0.3, aggregation = {max_count = 2, remove = true, count_already_playing = true}},
    flight_sound = {sound={filename = "__space-age__/sound/entity/mech-armor/mech-armor-flight.ogg", volume = 0.2}},
    steps_sound = sound_variations("__space-age__/sound/entity/mech-armor/mech-armor-steps-metallic", 5, 0.2),
    moving_sound = sound_variations("__space-age__/sound/entity/mech-armor/mech-armor-moves", 10, 0.4),
    collision_box = {{-0.25 * 1.25, -0.25 * 1.25}, {0.25 * 1.25, 0.25 * 1.25}},
    drawing_box = {{-0.4 * 1.25, -2 * 1.25}, {0.4 * 1.25, 0}},
    open_sound = sounds.armor_open,
    close_sound = sounds.armor_close,
    default_import_location = "bm-balack",
    stack_size = 1,
    weight = 1 * tons,
  },
  {
    type = "ammo",
    name = "bm-hypersonic-rounds-magazine",
    icon = "__biological-machines-planet-balack__/graphics/hypersonic-rounds-magazine.png",
    ammo_category = "bullet",
    ammo_type =
    {
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit",
              offsets = {{0, 1}},
              offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            },
            {
              type = "damage",
              damage = {amount = 240, type = "physical"}
            },
            {
              type = "activate-impact",
              deliver_category = "bullet"
            }
          }
        }
      }
    },
    magazine_size = 10,
    --reload_time = 10,
    subgroup = "ammo",
    order = "a[basic-clips]-c[uranium-rounds-magazine]-a",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 20,
    weight = 100 * kg
  },
})
