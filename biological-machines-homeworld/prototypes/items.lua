local item_sounds = require("__base__.prototypes.item_sounds")



local credit = util.table.deepcopy(data.raw["item"]["coin"])
credit.name = "bm-credit"
credit.subgroup = "bm-homeworld"
credit.order = "b-a"
credit.hidden = false
credit.stack_size = 200
credit.weight = 0.5 * kg
credit.default_import_location = "bm-dyson-sphere"

local super_credit = util.table.deepcopy(data.raw["item"]["coin"])
super_credit.name = "bm-super-credit"
super_credit.icon = "__biological-machines-homeworld__/graphics/purple-coin.png"
super_credit.subgroup = "bm-homeworld"
super_credit.order = "b-b"
super_credit.hidden = false
super_credit.stack_size = 1
super_credit.weight = 100 * kg
super_credit.default_import_location = "bm-dyson-sphere"

data:extend({credit, super_credit})



data:extend({
  {
    type = "item",
    name = "bm-homeworld-market",
    icon = "__base__/graphics/icons/market.png",
    subgroup = "bm-homeworld",
    color_hint = { text = "1" },
    order = "a",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "bm-homeworld-market",
    stack_size = 50,
    weight = 20 * kg,
  },
  {
    type = "item",
    name = "bm-energy-link-core",
    icon = "__biological-machines-k2-assets__/graphics/energy-link-core.png",
    pictures = {
      layers = {
        {
          size = 64,
          filename = "__biological-machines-k2-assets__/graphics/energy-link-core.png",
          scale = 0.5,
        },
        {
          draw_as_light = true,
          size = 64,
          filename = "__biological-machines-k2-assets__/graphics/energy-link-core-light.png",
          scale = 0.5
        },
      }
    },
    subgroup = "bm-homeworld",
    order = "b-c",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 50,
    default_import_location = "bm-dyson-sphere",
    weight = 20*kg
  },
  {
    type = "item",
    name = "bm-interstellar-energy-link",
    icon = "__biological-machines-k2-assets__/graphics/intergalactic-transceiver/intergalactic-transceiver-icon.png",
    subgroup = "energy",
    order = "z",
    place_result = "bm-interstellar-energy-link",
    stack_size = 1,
    weight = 10000 * kg,
  },
})
