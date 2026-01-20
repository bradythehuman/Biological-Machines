local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local dh = require("__biological-machines-core__.data-helper")



dh.add_recipe_unlock("bm-asteroid-deposit", "bm-electric-boiler")



local eb_entity = util.table.deepcopy(data.raw["boiler"]["boiler"])
eb_entity.name = "bm-electric-boiler"
eb_entity.icon = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler.png"
eb_entity.minable.result = "bm-electric-boiler"
eb_entity.surface_conditions = {{property = "gravity", min = 1}}
eb_entity.energy_consumption = "900kW"
eb_entity.energy_source = {
  type = "electric",
  usage_priority = "secondary-input"
}
-- North sprite
eb_entity.pictures.north.structure.layers[1].filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-N-idle.png"
eb_entity.pictures.north.fire = {
  filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-N-fire.png",
  draw_as_glow = true,
  priority = "extra-high",
  frame_count = 1,
  width = 26,
  height = 26,
  shift = util.by_pixel(0, -8.5),
  scale = 0.5
}
eb_entity.pictures.north.fire_glow.filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-N-light.png"
-- East sprite
eb_entity.pictures.east.structure.layers[1].filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-E-idle.png"
eb_entity.pictures.east.fire = {
  filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-E-fire.png",
  draw_as_glow = true,
  priority = "extra-high",
  frame_count = 1,
  width = 28,
  height = 28,
  shift = util.by_pixel(-9.5, -22),
  scale = 0.5
}
eb_entity.pictures.east.fire_glow.filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-E-light.png"
-- South sprite
eb_entity.pictures.south.structure.layers[1].filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-S-idle.png"
eb_entity.pictures.south.fire = {
  filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-S-fire.png",
  draw_as_glow = true,
  priority = "extra-high",
  frame_count = 1,
  width = 26,
  height = 16,
  shift = util.by_pixel(-1, -26.5),
  scale = 0.5
}
eb_entity.pictures.south.fire_glow.filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-S-light.png"
-- West sprite
eb_entity.pictures.west.structure.layers[1].filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-W-idle.png"
eb_entity.pictures.west.fire = {
  filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-W-fire.png",
  draw_as_glow = true,
  priority = "extra-high",
  frame_count = 1,
  width = 30,
  height = 29,
  shift = util.by_pixel(13, -23.25),
  scale = 0.5
}
eb_entity.pictures.west.fire_glow.filename = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-W-light.png"
eb_entity.fire_flicker_enabled = false
eb_entity.fire_glow_flicker_enabled = false
eb_entity.burning_cooldown = 10



data:extend({
  eb_entity,
  {
    type = "item",
    name = "bm-electric-boiler",
    icon = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler.png",
    subgroup = "energy",
    order = "b[steam-power]-a[boiler]b",
    inventory_move_sound = item_sounds.steam_inventory_move,
    pick_sound = item_sounds.steam_inventory_pickup,
    drop_sound = item_sounds.steam_inventory_move,
    place_result = "bm-electric-boiler",
    stack_size = 50,
    weight = 20 * kg,
    random_tint_color = item_tints.iron_rust
  },
  {
    type = "recipe",
    name = "bm-electric-boiler",
    icon = "__biological-machines-planet-wit__/graphics/electric-boiler/electric-boiler-i.png",
    ingredients = {
      {type = "item", name = "pipe", amount = 4},
      {type = "item", name = "advanced-circuit", amount = 5},
      {type = "item", name = "steel-plate", amount = 5}
    },
    results = {{type = "item", name = "bm-electric-boiler", amount = 1}},
    enabled = false
  }
})
