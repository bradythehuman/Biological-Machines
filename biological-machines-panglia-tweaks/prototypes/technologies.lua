local dh = require("__biological-machines-core__.data-helper")



--TECH DEPENDENCY
dh.remove_prereq("panglia_advanced_optics_nanotech", "panglia_planet_discovery_panglia")
dh.add_prereq("panglia_advanced_optics_nanotech", "panglia_panglite_multiplication")

dh.remove_prereq("panglia_branbalite_slurry_to_rocket_fuel", "panglia_universe_precursor_volcanic")
dh.add_prereq("panglia_branbalite_slurry_to_rocket_fuel", "panglia_branbalite_slurry_to_lubricant")

dh.remove_prereq("matter_printer-technology", "uranium-processing")
dh.add_prereq("panglia_panglite_fiber", "uranium-processing")

dh.remove_prereq("panglia_simulation_chamber", "matter_printer-technology")



--COSMIC INCUBATION
local incubator_tech = data.raw.technology["matter_printer-technology"]
incubator_tech.localised_name = {"technology-name.bm-panglite-incubator"}
incubator_tech.icon = "__panglia_planet_assets__/graphics/technology/panglia_universe_precursor_volcanic.png"

dh.remove_recipe_unlock("matter_printer-technology", "universe_precursor")
dh.add_recipe_unlock("matter_printer-technology", "bm-igneous-rock-incubation")

data.raw.technology["panglia_universe_precursor"].hidden = true
data.raw.technology["panglia_universe_precursor_volcanic"].hidden = true

dh.add_recipe_unlock("panglia_crusher", "bm-dust-incubation")

data:extend({
  {
    type = "technology",
    name = "bm-panglite-incubation",
    icon = "__matter_printer__/graphics/technology/matter_printer_tech.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "bm-branbalite-incubation",
      },
    },
    prerequisites = {"matter_printer-technology", "panglia_branbalite_slurry"},
    unit = {
      count = 450,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"agricultural-science-pack", 1},
      },
      time = 60,
    },
  }
})



--DATACELL RESEARCH PRODUCTIVITY
--half all research prod tech bonuses
data.raw.technology["research-productivity"].effects = {{
  type = "laboratory-productivity",
  modifier = 0.05
}}

--create datacell version of research prod tech
local datacell_copy = util.table.deepcopy(data.raw.technology["research-productivity"])
datacell_copy.name = "bm-datacell-research-productivity"
datacell_copy.icon = "__biological-machines-panglia-tweaks__/graphics/datacell-research-prod.png"
datacell_copy.prerequisites = {"promethium-science-pack", "panglia_sentient_processor"}
datacell_copy.unit.ingredients = {
  {"datacell-raw-data", 1},
  {"datacell-ai-model-data", 1},
  --{"datacell-equation", 1},
  {"datacell-solved-equation", 1},
  --{"datacell-dna-raw", 1},
  {"datacell-dna-sequenced", 1},
  {"datacell-cosmic-data-outsignal", 1},
  {"datacell-cosmic-data", 1},
}
datacell_copy.unit.time = 120000

--if warp drive installed and moshine override active
if data.raw.technology["bm-warp-space"] then
  --table.insert(datacell_copy.unit.ingredients, {"bm-datacell-warp-path", 1})
  table.insert(datacell_copy.unit.ingredients, {"bm-datacell-solved-warp-path", 1})
  table.insert(datacell_copy.prerequisites, "bm-warp-space")
end

data:extend({datacell_copy})
