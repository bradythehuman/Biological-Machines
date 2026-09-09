local item_sounds = require("__base__.prototypes.item_sounds")

local dh = require("__biological-machines-core__.data-helper")



--ITEMS
local cell_item = data.raw["item"]["bm-warp-power-cell"]
cell_item.default_import_location = "bm-balack"
cell_item.subgroup = "bm-balack-processes"
cell_item.order = "e-b"

local used_cell_item = data.raw["item"]["bm-warp-power-cell-used"]
used_cell_item.default_import_location = "bm-balack"
used_cell_item.subgroup = "bm-balack-processes"
used_cell_item.order = "e-c"

local part_item = data.raw["item"]["bm-warp-drive-part"]
part_item.default_import_location = "bm-balack"
part_item.subgroup = "bm-balack-processes"
part_item.order = "e-a"



--RECIPES
local cell_recipe = data.raw["recipe"]["bm-warp-power-cell"]
cell_recipe.categories = {"bm-bio-cube"}
cell_recipe.subgroup = "bm-balack-processes"
cell_recipe.order = "e-b"
--cell_recipe.energy_required = 120

local used_cell_recipe = data.raw["recipe"]["bm-warp-power-cell-recharge"]
used_cell_recipe.categories = {"bm-bio-cube"}
used_cell_recipe.subgroup = "bm-balack-processes"
used_cell_recipe.order = "e-c"

dh.remove_ingredient("bm-warp-power-cell", "uranium-235")
dh.remove_ingredient("bm-warp-power-cell-recharge", "uranium-235")
dh.remove_ingredient("bm-warp-power-cell", "quantum-processor")
dh.remove_ingredient("bm-warp-power-cell", "tungsten-carbide")

dh.add_ingredient("bm-warp-power-cell", "item", "bm-ai-control-unit-active", 1)
dh.add_ingredient("bm-warp-power-cell-recharge", "item", "bm-ai-control-unit-active", 1)
dh.add_ingredient("bm-warp-power-cell", "item", "bm-radiation-sheilding", 10)

table.insert(data.raw.recipe["bm-warp-power-cell-recharge"].results,
  {type = "item", name = "bm-ai-control-unit", amount = 1}
)

local part_recipe = data.raw.recipe["bm-warp-drive-part"]
part_recipe.ingredients = {
  {type = "item", name = "bm-ai-control-unit", amount = 2},
  {type = "item", name = "bm-radiation-sheilding", amount = 25},
  {type = "item", name = "beacon", amount = 1},
  {type = "item", name = "supercapacitor", amount = 10},
  {type = "item", name = "tungsten-plate", amount = 10},
}
part_recipe.categories = {"bm-bio-cube"}



--TECHNOLOGIES
data.raw.technology["bm-warp-drive"].prerequisites = {"bm-activated-ai-control-unit"}
