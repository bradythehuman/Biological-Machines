require("__base__.prototypes.entity.remnants")
local dh = require("__biological-machines-core__.data-helper")



--add power consumption to splitters
--nauvis desert rocks drop sand
--nauvis trees drop leaf litter/spoilage
--[[
local nauvis_trees = {
  "tree-01", "tree-02", "tree-02-red", "tree-03", "tree-04", "tree-05",
  "tree-06", "tree-06-brown", "tree-07", "tree-08", "tree-08-brown",
  "tree-08-red", "tree-09", "tree-09-brown", "tree-09-red"
]]



local vulcanus_trees = {"ashland-lichen-tree", "ashland-lichen-tree-flaming"}
dh.add_entity_drop("tree", vulcanus_trees, "bm-potash", 2)



data.raw["assembling-machine"]["crusher"].surface_conditions = nil

data.raw["furnace"]["stone-furnace"].result_inventory_size = 2
data.raw["furnace"]["steel-furnace"].result_inventory_size = 2
data.raw["furnace"]["electric-furnace"].result_inventory_size = 4

table.insert(data.raw["furnace"]["electric-furnace"].crafting_categories, "bm-pyrolysis")



local recycler_prototype = data.raw["furnace"]["recycler"]
if recycler_prototype.result_inventory_size < 14 then
  recycler_prototype.result_inventory_size = 14
  data.raw["furnace"]["bm-scrapyard"].result_inventory_size = 14
end



-----------------------------------------------CARBONIZER
local carbonizer = util.table.deepcopy(data.raw["furnace"]["stone-furnace"])
carbonizer.name = "bm-carbonizer"
carbonizer.icon = "__biological-machines-industry__/graphics/carbonizer-icon.png"
carbonizer.minable.result = "bm-carbonizer"
carbonizer.fast_replaceable_group = ""
carbonizer.next_upgrade = nil
carbonizer.corpse = "bm-carbonizer-remnants"
--carbonizer.allowed_effects = {"speed", "consumption", "pollution"} --what is this?
carbonizer.crafting_categories = {"bm-pyrolysis"}
carbonizer.result_inventory_size = 4
carbonizer.energy_source = {
  type = "void", --use burner type with 0 fuel slots and 0 power consumption?
  emissions_per_minute = {pollution = 2},
  render_no_power_icon = false,
  render_no_network_icon = false
}
carbonizer.graphics_set.animation.layers[1].filename = "__biological-machines-industry__/graphics/carbonizer-entity.png"

local carbonizer_remnants = util.table.deepcopy(data.raw["corpse"]["stone-furnace-remnants"])
carbonizer_remnants.name = "bm-carbonizer-remnants"
carbonizer_remnants.icon = "__biological-machines-industry__/graphics/carbonizer-icon.png"
carbonizer_remnants.animation = make_rotated_animation_variations_from_sheet(1,
{
  filename = "__base__/graphics/entity/stone-furnace/remnants/stone-furnace-remnants.png",
  line_length = 1,
  width = 152,
  height = 130,
  direction_count = 1,
  shift = util.by_pixel(0, 9.5),
  scale = 0.5
})

data:extend({carbonizer, carbonizer_remnants})
