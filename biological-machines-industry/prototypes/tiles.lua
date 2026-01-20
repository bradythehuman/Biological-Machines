------------------------------------------------------FERTILE SOIL
local fertile_soil = util.table.deepcopy(data.raw["tile"]["landfill"])
fertile_soil.name = "bm-fertile-soil"
fertile_soil.minable = {mining_time = 0.1, result = "bm-fertile-soil"}
fertile_soil.walking_speed_modifier = 0.8
fertile_soil.vehicle_friction_modifier = 1.8 --sand is 1.8
fertile_soil.layer = 13
fertile_soil.layer_group = "ground-artificial"
fertile_soil.decorative_removal_probability = 0.25
fertile_soil.tint = {0.45, 0.25, 0}
fertile_soil.is_foundation = false
data:extend({fertile_soil})

local plants = data.raw["plant"]
table.insert(plants["tree-plant"].autoplace.tile_restriction, "bm-fertile-soil")
table.insert(plants["bm-berry-bush"].autoplace.tile_restriction, "bm-fertile-soil")
