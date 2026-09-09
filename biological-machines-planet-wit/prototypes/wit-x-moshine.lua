local dh = require("__biological-machines-core__.data-helper")



dh.add_ingredient("3d-data-storage", "item", "bm-helium-power-cell", 2)



--ADVANCED SOLAR
if settings.startup["bm-advanced-solar-panels"].value
and mods["snouz-big-solar-panel"] then
  dh.remove_ingredient("big-solar-panel", "medium-electric-pole")
  dh.remove_ingredient("big-solar-panel", "solar-panel")
  dh.add_ingredient("big-solar-panel", "item", "bm-advanced-solar-panel", 10)
  dh.add_prereq("big-solar-energy", "bm-advanced-solar-energy")
  --dh.add_ingredient("bm-advanced-solar-panel", "item", "silicon-cell", 5)
  --dh.add_prereq("bm-advanced-solar-energy", "moshine-tech-ai-tier-2")
  --data.raw["technology"]["bm-advanced-solar-energy"].unit = util.table.deepcopy(data.raw["technology"]["big-solar-energy"].unit)
  --data.raw["technology"]["bm-advanced-solar-panel-equipment"].unit = util.table.deepcopy(data.raw["technology"]["moshine-tech-ai-tier-3"].unit)

  --data.raw["recipe"]["big-solar-panel"].hidden = true
  --data.raw["item"]["big-solar-panel"].hidden = true
  --data.raw["technology"]["big-solar-energy"].hidden = true
  --data.raw["solar-panel"]["big-solar-panel"].hidden = true
end



--INTERSTELLAR SCI PACK
data.raw.item["bm-empty-data-disk"].hidden = true
data.raw.item["bm-incomplete-data-disk"].hidden = true
data.raw.item["bm-complete-data-disk"].hidden = true
data.raw.recipe["bm-empty-data-disk"].hidden = true
data.raw.recipe["bm-initial-data"].hidden = true
data.raw.recipe["bm-secondary-data"].hidden = true

local isp_recipe = data.raw.recipe["bm-interstellar-science-pack"]
isp_recipe.energy_required = 25
isp_recipe.ingredients = {
  {type = "fluid", name = "thruster-oxidizer", amount = 500},
  {type = "item", name = "bm-mixed-gas-power-cell", amount = 25},
  {type = "item", name = "flying-robot-frame", amount = 5},
  --{type = "item", name = "bm-datacell-solved-warp-path", amount = 1},
  {type = "item", name = "ai-tier-8", amount = 1},
}
isp_recipe.results = {
  {type = "item", name = "bm-interstellar-science-pack", amount = 5},
  --{type = "item", name = "datacell-empty", amount = 1, ignored_by_productivity = 1},
  {type = "item", name = "ai-tier-8", amount = 1, ignored_by_productivity = 1, shared_probability = {min = 0, max = 0.59}},
  {type = "item", name = "ai-tier-7", amount = 1, ignored_by_productivity = 1, shared_probability = {min = 0.59, max = 0.99}},
  {type = "item", name = "model-unstable", amount = 1, ignored_by_productivity = 1, shared_probability = {min = 0.99, max = 1}},
}

dh.add_prereq("bm-interstellar-science-pack", "moshine-tech-ai-tier-8")

dh.remove_recipe_unlock("bm-interstellar-science-pack", "bm-empty-data-disk")
dh.remove_recipe_unlock("bm-interstellar-science-pack", "bm-initial-data")
dh.remove_recipe_unlock("bm-interstellar-science-pack", "bm-secondary-data")



--WARP DRIVE
--[[
dh.remove_recipe_unlock("moshine-tech-processing-grid", "bm-datacell-warp-path")
dh.add_recipe_unlock("bm-interstellar-science-pack", "bm-datacell-warp-path")

dh.remove_prereq("bm-warp-drive", "bm-interstellar-science-pack")
dh.add_prereq("bm-warp-space", "bm-interstellar-science-pack")
]]
