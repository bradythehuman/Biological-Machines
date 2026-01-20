local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({
  {
    type = "equipment-grid",
    name = "bm-survival-equipment-grid",
    width = 3,
    height = 3,
    equipment_categories = {"armor"},
  },
  {
    type = "armor",
    name = "bm-survival-armor",
    icon = "__biological-machines-core__/graphics/survival-armor.png",
    subgroup = "armor",
    order = "aa[light-armor]",
    inventory_move_sound = item_sounds.armor_small_inventory_move,
    pick_sound = item_sounds.armor_small_inventory_pickup,
    drop_sound = item_sounds.armor_small_inventory_move,
    stack_size = 1,
    infinite = true,
    equipment_grid = "bm-survival-equipment-grid",
    open_sound = "__base__/sound/armor-open.ogg",
    close_sound = "__base__/sound/armor-close.ogg"
  },
})
