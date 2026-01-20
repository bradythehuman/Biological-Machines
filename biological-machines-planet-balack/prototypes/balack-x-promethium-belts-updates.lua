local dh = require("__biological-machines-core__.data-helper")



--RECIPES
local remove_promethium = {
  "promethium-transport-belt", "promethium-underground-belt",
  "promethium-splitter",
}
dh.remove_ingredient(remove_promethium, "promethium-asteroid-chunk")

local add_sheilding = {
  ["promethium-transport-belt"] = 1,
  ["promethium-underground-belt"] = 10,
  ["promethium-splitter"] = 5,
}
dh.add_ingredient_table(add_sheilding, "item", "bm-radiation-sheilding")



--TECH
dh.remove_prereq("promethium-transport-belt", "promethium-science-pack")

dh.add_prereq("promethium-transport-belt", "bm-planet-discovery-balack")

data.raw["technology"]["promethium-transport-belt"].unit = util.table.deepcopy(data.raw.technology["bm-tank-mk2"].unit)
