local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")



local crusher = data.raw["item"]["crusher"]
crusher.subgroup = "smelting-machine"
crusher.order = "d[recycler]-a"



data.raw["item"]["yumako-seed"].fuel_value = "1MJ"
data.raw["item"]["jellynut-seed"].fuel_value = "1MJ"




data.raw["item"]["electronic-circuit"].weight = 0.5 * kg
data.raw["item"]["advanced-circuit"].weight = 1 * kg
data.raw["item"]["oil-refinery"].weight = 100 * kg



data:extend({
  ---------------------------------------------------------CARBONIZER
  {
    type = "item",
    name = "bm-potash",
    icon = "__biological-machines-k2-assets__/graphics/potash.png",
    subgroup = "bm-powder",
    order = "a-a",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    weight = 1 * kg,
  },
  {
    type = "item",
    name = "bm-tar",
    icon = "__biological-machines-industry__/graphics/tar.png",
    subgroup = "raw-material",
    order = "b[chemistry]-a[solid-fuel]-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    fuel_category = "chemical",
    fuel_value = "1MJ",
    stack_size = 50,
    weight = 1 * kg,
  },
  {
    type = "item",
    name = "bm-carbonizer",
    icon = "__biological-machines-industry__/graphics/carbonizer-icon.png",
    subgroup = "smelting-machine",
    order = "a[stone-furnace]-a",
    inventory_move_sound = item_sounds.brick_inventory_move,
    pick_sound = item_sounds.brick_inventory_pickup,
    drop_sound = item_sounds.brick_inventory_move,
    place_result = "bm-carbonizer",
    stack_size = 50,
    weight = 20 * kg,
  },
  {
    type = "item",
    name = "bm-potassium-nitrate",
    icon = "__biological-machines-k2-assets__/graphics/potassium-nitrate.png",
    subgroup = "bm-powder",
    order = "a-d",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 1 * kg,
  },
  {
    type = "item",
    name = "bm-gunpowder-mix",
    icon = "__biological-machines-industry__/graphics/gunpowder-mix.png",
    subgroup = "bm-powder",
    order = "b-a",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    weight = 2.5 * kg,
  },

  -----------------------------------------------------------METAL
  {
    type = "item",
    name = "bm-slag",
    icon = "__biological-machines-industry__/graphics/slag.png",
    subgroup = "raw-resource",
    order = "f[copper-ore]-z",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 1,
    weight = 100 * kg,
  },
  {
    type = "item",
    name = "bm-steel-mix",
    icon = "__biological-machines-industry__/graphics/steel-mix.png",
    subgroup = "bm-powder",
    order = "b-a",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    weight = 2.5 * kg,
  },
  {
    type = "item",
    name = "bm-piston",
    icon = "__biological-machines-industry__/graphics/piston.png",
    subgroup = "intermediate-product",
    order = "b[circuits]-z-a",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 100,
    weight = 1 * kg,
  },
  {
    type = "fluid",
    name = "bm-molten-steel",
    icon = "__biological-machines-industry__/graphics/molten-steel.png",
    subgroup = "fluid",
    order = "b[new-fluid]-b[vulcanus]-b[molten-copper]-a",
    default_temperature = 1500,
    max_temperature = 2000,
    heat_capacity = "0.01kJ",
    base_color = {0, 0.05, 0.2},
    flow_color = {0.2, 0.4, 0.5},
    auto_barrel = false,
  },

  --------------------------------------------------------STONE
  {
    type = "item",
    name = "bm-lime",
    icon = "__biological-machines-k2-assets__/graphics/lime.png",
    subgroup = "bm-powder",
    order = "a-c",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    weight = 1 * kg,
  },
  {
    type = "item",
    name = "bm-sand",
    icon = "__biological-machines-k2-assets__/graphics/sand.png",
    subgroup = "bm-powder",
    order = "a-b",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    weight = 1 * kg,
  },
  {
    type = "item",
    name = "bm-cement-mix",
    icon = "__biological-machines-industry__/graphics/cement-mix.png",
    subgroup = "bm-powder",
    order = "b-b",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 50,
    weight = 2.5 * kg,
  },
  {
    type = "item",
    name = "bm-glass-mix",
    icon = "__biological-machines-industry__/graphics/glass-mix.png",
    subgroup = "bm-powder",
    order = "b-c",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 50,
    weight = 2.5 * kg,
  },
  {
    type = "item",
    name = "bm-fertile-soil",
    icons = {{
      icon = "__base__/graphics/icons/landfill.png",
      tint = {0.45, 0.25, 0}
    }},
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]-z",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    weight = 10 * kg,
    place_as_tile = {
      result = "bm-fertile-soil",
      condition_size = 1,
      condition = {layers={water_tile=true}},
      tile_condition = {"sand-1", "sand-2", "sand-3", "landfill"}
    },
    random_tint_color = item_tints.organic_green,
  },

  -----------------------------------------------------------ELECTRONICS
  {
    type = "item",
    name = "bm-resin",
    icon = "__biological-machines-industry__/graphics/resin.png",
    subgroup = "nauvis-agriculture",
    order = "b-c",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 100,
    weight = 0.5 * kg,

    spoil_ticks = 15 * minute,
    spoil_result = "spoilage",
  },
  {
    type = "item",
    name = "bm-circuit-board",
    icon = "__biological-machines-industry__/graphics/circuit-board.png",
    subgroup = "raw-material",
    order = "b[chemistry]-b[plastic-bar]",
    inventory_move_sound = item_sounds.low_density_inventory_move,
    pick_sound = item_sounds.low_density_inventory_pickup,
    drop_sound = item_sounds.low_density_inventory_move,
    stack_size = 200,
    weight = 0.5 * kg,
  },
  {
    type = "item",
    name = "bm-lightbulb",
    icon = "__biological-machines-industry__/graphics/lightbulb.png",
    subgroup = "intermediate-product",
    order = "b[circuits]-z",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 100,
    weight = 1 * kg,
  },

  ------------------------------------------------------OIL
  {
    type = "fluid",
    name = "bm-seed-oil",
    icon = "__biological-machines-industry__/graphics/seed-oil.png",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2kJ",
    base_color = {0.60, 0.50, 0.04},
    flow_color = {0.88, 0.82, 0.45},
  }
})
