local item_sounds = require("__base__.prototypes.item_sounds")
local dh = require("__biological-machines-core__.data-helper")



dh.add_recipe_unlock("foundry", "bm-casting-glass")

data:extend({
  {
    type = "item",
    name = "bm-glass-plate",
    icon = "__biological-machines-core__/graphics/glass-plate.png",
    subgroup = "raw-material",
    order = "a[smelting]-z",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 100,
    weight = 1 * kg
  },
  {
    type = "fluid",
    name = "bm-molten-glass",
    icon = "__biological-machines-core__/graphics/molten-glass.png",
    subgroup = "fluid",
    order = "b[new-fluid]-b[vulcanus]-c[molten-glass]",
    default_temperature = 1500,
    max_temperature = 2000,
    heat_capacity = "0.01kJ",
    base_color = {0.75, 0.9375, 1.0},
    flow_color = {0.9, 0.9, 0.9},
    auto_barrel = false
  },
  {
    type = "recipe",
    name = "bm-casting-glass",
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "b[casting]-ba[casting-glass]",
    icon = "__biological-machines-core__/graphics/casting-glass.png",
    enabled = false,
    ingredients = {{type="fluid", name="bm-molten-glass", amount=20, fluidbox_multiplier=10}},
    energy_required = 3.2,
    allow_decomposition = false,
    results = {{type = "item", name = "bm-glass-plate", amount = 2}},
    allow_productivity = true
  }
})
