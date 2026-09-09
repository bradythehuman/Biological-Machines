local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



data:extend({
  {
    type = "item",
    name = "bm-clone",
    localised_name = {"item-name.bm-clone-dummy"},
    icon = "__core__/graphics/icons/entity/character.png",
    subgroup = "bm-homeworld",
    order = "z",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 1,
    weight = 1000 * kg,
  }
})
