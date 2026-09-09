local dh = require("__biological-machines-core__.data-helper")



--[[
local raw_dna = data.raw.recipe["datacell-dna-raw"]
raw_dna.categories = {"organic"}
raw_dna.allow_productivity = false
raw_dna.maximum_productivity = 0
raw_dna.energy_required = raw_dna.energy_required / 10
dh.add_ingredient("datacell-dna-raw", "fluid", "panglia_branbalite_slurry", 2)
dh.add_ingredient("datacell-dna-raw", "item", "spoilage", 1)
]]

--[[
local specimen_0 = data.raw.recipe["panglia_cloned_specimen_body_0"]
specimen_0.categories = {"organic"}
specimen_0.maximum_productivity = 0
specimen_0.energy_required = specimen_0.energy_required * 2
]]

dh.remove_ingredient("bm-clone", "biter-egg")
dh.add_ingredient("bm-clone", "item", "panglia_cloned_specimen_body_2", 1)

dh.add_prereq("bm-cloning", "panglia_simulation_matrix")
