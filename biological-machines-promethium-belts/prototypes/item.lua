local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local meld = require("meld")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

data:extend
{
  {
    type = "item",
    name = "promethium-transport-belt",
    icon = "__biological-machines-promethium-belts__/graphics/icons/promethium-transport-belt.png",
    subgroup = "belt",
    color_hint = { text = "4" },
    order = "a[transport-belt]-e[promethium-transport-belt]",
    inventory_move_sound = item_sounds.transport_belt_inventory_move,
    pick_sound = item_sounds.transport_belt_inventory_pickup,
    drop_sound = item_sounds.transport_belt_inventory_move,
    place_result = "promethium-transport-belt",
    stack_size = 100,
    default_import_location = "nauvis",
    weight = 20*kg
  },
  {
    type = "item",
    name = "promethium-underground-belt",
    icon = "__biological-machines-promethium-belts__/graphics/icons/promethium-underground-belt.png",
    subgroup = "belt",
    color_hint = { text = "4" },
    order = "b[underground-belt]-e[promethium-underground-belt]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "promethium-underground-belt",
    stack_size = 50,
    default_import_location = "nauvis",
    weight = 40*kg
  },
  {
    type = "item",
    name = "promethium-splitter",
    icon = "__biological-machines-promethium-belts__/graphics/icons/promethium-splitter.png",
    subgroup = "belt",
    color_hint = { text = "4" },
    order = "c[splitter]-e[promethium-splitter]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "promethium-splitter",
    stack_size = 50,
    default_import_location = "nauvis",
    weight = 40*kg
  },
  {
    type = "item",
    name = "promethium-loader",
    icon = "__biological-machines-promethium-belts__/graphics/icons/promethium-loader.png",
    hidden = true,
    subgroup = "belt",
    color_hint = { text = "4" },
    order = "d[loader]-e[promethium-loader]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "promethium-loader",
    stack_size = 50
  }
}
