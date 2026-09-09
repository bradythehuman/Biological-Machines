local item_sounds = require("__base__.prototypes.item_sounds")

local dh = require("__biological-machines-core__.data-helper")



--uses "moshine-datacells" when panglia is installed as datacells are seperated
local datacell_subgroup = data.raw["item-subgroup"]["moshine-datacells"] and "moshine-datacells" or "moshine-processes"



dh.add_recipe_unlock("moshine-tech-cosmicscanner-construction5", "bm-datacell-warp-path")
dh.add_recipe_unlock("moshine-tech-cosmicscanner-construction5", "bm-datacell-solved-warp-path")
dh.add_recipe_unlock("moshine-tech-cosmicscanner-construction5", "bm-datacell-remove-solved-warp-path")

dh.add_ingredient("bm-warp-power-cell", "item", "bm-datacell-solved-warp-path", 1)

dh.add_ingredient("bm-warp-power-cell-recharge", "item", "bm-datacell-solved-warp-path", 1)
table.insert(data.raw.recipe["bm-warp-power-cell-recharge"].results,
  {type = "item", name = "datacell-empty", amount = 1}
)



--Adds warp path datacell to accepted compute farm inputs
table.insert(data.raw["agricultural-tower"]["processing-grid"].accepted_seeds, "bm-datacell-warp-path")

local wp_plant = util.table.deepcopy(data.raw["plant"]["processing-grid-process-equation"])
wp_plant.name = "bm-processing-grid-process-warp-path"
wp_plant.icon = "__biological-machines-warp-drive__/graphics/processing-grid-process-warp-path.png"
wp_plant.minable.results = {{type = "item", name = "bm-datacell-solved-warp-path", amount = 1}}
wp_plant.growth_ticks = 10 * minute

data:extend({
  wp_plant,
  {
    type = "fluid",
    name = "bm-solved-warp-path-data",
    localised_name = {"fluid-name.bm-solved-warp-path-data"},
    subgroup = "data-fluid",
    order = "b[solved-equation]-a",
    default_temperature = 15,
    gas_temperature = 0,
    base_color = {212, 5, 212},
    flow_color = {212, 5, 212},
    icon = "__biological-machines-warp-drive__/graphics/solved-warp-path-data.png",
    auto_barrel = false,
    draw_as_glow = true,
  },
  {
    type = "item",
    name = "bm-datacell-warp-path",
    localised_name = {"item-name.bm-datacell-warp-path"},
    icon = "__biological-machines-warp-drive__/graphics/datacell-warp-path.png",
    subgroup = datacell_subgroup,
    order = "z-a",
    --subgroup = "bm-wit-processes",
    --order = "c-g-c",
    plant_result = "bm-processing-grid-process-warp-path",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    default_import_location = "moshine",
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
    stack_size = 200,
    weight = 0.5*kg,

    --spoil_ticks = 5 * minute,
    --spoil_result = "datacell-empty",
  },
  {
    type = "item",
    name = "bm-datacell-solved-warp-path",
    --localised_name = {"item-name.bm-datacell-solved-warp-path"},
    icon = "__biological-machines-warp-drive__/graphics/datacell-solved-warp-path.png",
    subgroup = datacell_subgroup,
    order = "z-b",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    default_import_location = "moshine",
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
    stack_size = 200,
    weight = 0.5*kg,

    --spoil_ticks = 5 * minute,
    --spoil_result = "datacell-empty",
  },
  {
    type = "recipe",
    name = "bm-datacell-warp-path",
    localised_name = {"recipe-name.bm-datacell-warp-path"},
    icon = "__biological-machines-warp-drive__/graphics/datacell-warp-path.png",
    categories = {"data-processing"},
    subgroup = datacell_subgroup,
    order = "z-a",
    hide_from_player_crafting = true,
    energy_required = 1000,
    ingredients = {
      {type = "item", name = "datacell-empty", amount = 1},
      {type = "fluid", name = "cosmic-data", amount = 10},
    },
    results = {
      {type = "item", name = "bm-datacell-warp-path", amount = 1}
    },
    allow_productivity = false,
    auto_recycle = false,
    enabled = false,
    crafting_machine_tint = {primary = {125, 235, 66}}, --#427deb
  },
  {
    type = "recipe",
    name = "bm-datacell-solved-warp-path",
    localised_name = {"recipe-name.bm-datacell-solved-warp-path"},
    icon = "__biological-machines-warp-drive__/graphics/datacell-solved-warp-path.png",
    categories = {"data-processing"},
    subgroup = datacell_subgroup,
    order = "z-b",
    hide_from_player_crafting = true,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "datacell-empty", amount = 1},
      {type = "fluid", name = "bm-solved-warp-path-data", amount = 60},
    },
    results = {{type = "item", name = "bm-datacell-solved-warp-path", amount = 1}},
    allow_productivity = false,
    auto_recycle = false,
    enabled = false,
    crafting_machine_tint = {primary = {212, 5, 212}}, --#f2eb76
  },
  {
    type = "recipe",
    name = "bm-datacell-remove-solved-warp-path",
    localised_name = {"recipe-name.bm-datacell-remove-solved-warp-path"},
    icon = "__biological-machines-warp-drive__/graphics/datacell-solved-warp-path-remove.png",
    categories = {"data-processing"},
    subgroup = datacell_subgroup,
    order = "z-c",
    hide_from_player_crafting = true,
    hide_from_stats = true,
    energy_required = 1,
    ingredients = {
      {type = "item", name = "bm-datacell-solved-warp-path", amount = 1},
    },
    results = {
      {type = "item", name = "datacell-empty", amount = 1},
      {type = "fluid", name = "bm-solved-warp-path-data", amount = 60},
    },
    allow_productivity = false,
    auto_recycle = false,
    enabled = false,
    hide_from_player_crafting = true,
    crafting_machine_tint = {primary = {212, 5, 212}}, --#f2eb76
  },
  {
    type = "technology",
    name = "bm-warp-space",
    icon = "__biological-machines-k2-assets__/graphics/matter-tech.png",
    icon_size = 256,
    --effects = {},
    prerequisites = {"moshine-tech-cosmicscanner-construction5"},
    unit = {
      count = 1000,
      ingredients = {
        {"datacell-raw-data", 1},
        {"datacell-ai-model-data", 1},
        --{"datacell-equation", 1},
        {"datacell-solved-equation", 1},
        --{"bm-datacell-warp-path", 1},
        {"bm-datacell-solved-warp-path", 1},
        {"datacell-cosmic-data-outsignal", 1},
        {"datacell-cosmic-data", 1},
      },
      time = 100000
    }
  },
})
