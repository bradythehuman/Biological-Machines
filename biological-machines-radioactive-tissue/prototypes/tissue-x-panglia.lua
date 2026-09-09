local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("bm-clone", "bm-radioactive-tissue")

dh.remove_ingredient("panglia_cloned_specimen_body_0", "uranium-235")
dh.add_ingredient("panglia_cloned_specimen_body_0", "item", "bm-radioactive-tissue", 1)

for _, result in pairs(data.raw.recipe["panglia_cloned_specimen_body_0"].results) do
  if result.name == "panglia_cloned_specimen_body_0" then
    result.shared_probability.max = 0.1
  elseif result.name == "mutated_monster_egg" then
    result.shared_probability.min = 0.1
  elseif result.name == "uranium-238" then
    result.name = "bm-hardened-tissue"
    result.independent_probability = 0.25
  end
end



dh.add_prereq("panglia_planet_discovery_panglia", "bm-radioactive-tissue-cultivation")



--[[
data.raw.technology["panglia_dna_manipulation"].prerequisites = util.table.deepcopy(data.raw.technology["cloning-vat-technology"].prerequisites)
dh.remove_prereq("panglia_simulation_chamber", "cloning-vat-technology")
--dh.add_recipe_unlock("panglia_advanced_optics_nanotech", "datacell-dna-raw")
dh.add_recipe_unlock("panglia_planet_discovery_panglia", "datacell-dna-raw")
--dh.add_recipe_unlock("panglia_branbalite_slurry", "datacell-dna-raw")

dh.remove_ingredient("simulation_chamber", "cloning-vat")
dh.add_ingredient("simulation_chamber", "item", "biochamber", 1)
data.raw["assembling-machine"]["cloning-vat"].hidden = true
data.raw["item"]["cloning-vat"].hidden = true
data.raw["recipe"]["cloning-vat"].hidden = true
data.raw.technology["cloning-vat-technology"].hidden = true
data.raw.recipe["cloning-biter-egg"].hidden = true
]]
