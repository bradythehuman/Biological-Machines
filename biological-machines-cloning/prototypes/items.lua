local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



data:extend({
  {
    type = "item",
    name = "bm-suspension-tank",
    icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
    subgroup = "agriculture",
    order = "c[suspension-tank]",
    inventory_move_sound = item_sounds.fluid_inventory_move,
    pick_sound = item_sounds.fluid_inventory_pickup,
    drop_sound = item_sounds.fluid_inventory_move,
    place_result = "bm-suspension-tank",
    stack_size = 20,
    weight = 50 * kg,
    default_import_location = "gleba"
  },
  {
    type = "item",
    name = "bm-clone",
    icon = "__core__/graphics/icons/entity/character.png",
    subgroup = "bm-cultivation",
    order = "z",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 1,
    weight = 1000 * kg,
    --hidden = true,

    fuel_category = "chemical",
    fuel_value = "100MJ",

    spoil_ticks = 2 * minute,
  },
  {
    type = "item",
    name = "bm-suspended-clone",
    flags = {"ignore-spoil-time-modifier"},
    icons = {
      {
        icon = "__core__/graphics/icons/entity/character.png",
      },
      {
        icon = "__biological-machines-cloning__/graphics/suspension-fluid.png",
        scale = 0.25,
        shift = {8, -8}
      },
    },
    subgroup = "bm-cultivation",
    order = "z-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 1,
    weight = 10000 * kg,
    hidden = true,
    hidden_in_factoriopedia = true,

    spoil_ticks = 2,
    spoil_to_trigger_result = {
      items_per_trigger = 1,
      trigger = {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "bm-clone-suspended",
          starting_speed = 1,
        }
      }
    }
  },
  {
    type = "item",
    name = "bm-prepared-tank",
    flags = {"ignore-spoil-time-modifier"},
    icons = {
      {
        icon = "__biological-machines-cloning__/graphics/suspension-tank/cloning-vat-icon.png",
      },
      {
        icon = "__biological-machines-cloning__/graphics/suspension-fluid.png",
        scale = 0.25,
        shift = {8, -8}
      },
    },
    subgroup = "bm-cultivation",
    order = "z-c",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 1,
    weight = 10000 * kg,
    hidden = true,
    hidden_in_factoriopedia = true,

    spoil_ticks = 2,
    spoil_to_trigger_result = {
      items_per_trigger = 1,
      trigger = {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "bm-tank-prepared",
          starting_speed = 1,
        }
      }
    }
  },
  {
    type = "fluid",
    name = "bm-suspension-fluid",
    icon = "__biological-machines-cloning__/graphics/suspension-fluid.png",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2kJ",
    base_color = {0.20, 0.38, 0.40},
    flow_color = {0.40, 0.70, 0.75}
  },
})
