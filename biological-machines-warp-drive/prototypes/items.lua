local item_sounds = require("__base__.prototypes.item_sounds")



data:extend({
  {
    type = "item",
    name = "bm-warp-drive",
    icon = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-icon.png",
    subgroup = "space-platform",
    order = "z",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "bm-warp-drive",
    stack_size = 1,
    weight = 10000 * kg,
  },
  {
    type = "item",
    name = "bm-warp-power-cell",
    icon = "__biological-machines-k2-assets__/graphics/warp-power-cell.png",
    subgroup = "aquilo-processes",
    order = "z",
    inventory_move_sound = item_sounds.reactor_inventory_move,
    pick_sound = item_sounds.reactor_inventory_pickup,
    drop_sound = item_sounds.reactor_inventory_move,
    stack_size = 10,
    weight = 200 * kg,
  },
  {
    type = "item",
    name = "bm-warp",
    icon = "__biological-machines-k2-assets__/graphics/matter.png",
    subgroup = "space-platform",
    order = "z-a",
    stack_size = 1,
    weight = 10000 * kg,
    --hidden = true,
    --hidden_in_factoriopedia = true,

    spoil_ticks = 1,
    spoil_to_trigger_result = {
      items_per_trigger = 1,
      trigger = {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "bm-warp",
          starting_speed = 1,
        }
      }
    },
  },
})
