local dh = require("__biological-machines-core__.data-helper")



local tree_seeding = data.raw["technology"]["tree-seeding"]
tree_seeding.prerequisites = {"agriculture", "logistic-science-pack"}
tree_seeding.unit = {
  count = 200,
  ingredients = {
    {"automation-science-pack",   1}, {"logistic-science-pack",     1}
  },
  time = 30
}

data.raw["technology"]["fish-breeding"].prerequisites = {"agricultural-science-pack"}



---------------------------------------------------------CARBON
dh.add_recipe_unlock("military-2", "bm-potassium-nitrate")
dh.add_recipe_unlock("military-2", "bm-gunpowder-mix")

dh.add_recipe_unlock("explosives", "bm-potassium-nitrate")
dh.add_recipe_unlock("explosives", "bm-gunpowder-mix")

dh.add_prereq("military-2", "automation-2")

local fiber_tech = data.raw.technology["carbon-fiber"]
fiber_tech.unit = nil
fiber_tech.prerequisites = {"biochamber"}
fiber_tech.research_trigger = {
  type = "craft-item",
  item = "biochamber",
  count = 5
}

local fiber_postreqs = {"stack-inserter", "rocket-turret", "toolbelt-equipment"}
for i=1, #fiber_postreqs do
  dh.remove_prereq(fiber_postreqs[i], "carbon-fiber")
  dh.add_prereq(fiber_postreqs[i], "agricultural-science-pack")
end

dh.add_prereq("agricultural-science-pack", "carbon-fiber")


-----------------------------------------------------METAL
data.raw["recipe"]["pipe"].enabled = true
data.raw["recipe"]["iron-stick"].enabled = true
dh.remove_recipe_unlock("steam-power", "pipe")
dh.remove_recipe_unlock("railway", "iron-stick")
dh.remove_recipe_unlock("circuit-network", "iron-stick")
dh.remove_recipe_unlock("concrete", "iron-stick")
dh.remove_recipe_unlock("electric-energy-distribution-1", "iron-stick")

data.raw["technology"]["steel-processing"].prerequisites = {"bm-stone-crushing"}
dh.add_recipe_unlock("steel-processing", "bm-steel-mix")

data.raw["technology"]["automation-2"].prerequisites = {"automation", "engine"}

dh.remove_recipe_unlock("foundry", "concrete-from-molten-iron")

dh.remove_prereq("logistics-3", "lubricant")
dh.add_prereq("logistics-3", "electric-engine")

dh.add_recipe_unlock("foundry", "bm-molten-steel-from-lava")
dh.add_recipe_unlock("foundry", "bm-steel-mix-melting")
dh.add_recipe_unlock("foundry", "bm-casting-piston")



-------------------------------------------------STONE
dh.remove_prereq("production-science-pack", "railway")
dh.add_prereq("elevated-rail", "railway")

dh.add_prereq("concrete", "bm-stone-crushing")
dh.add_recipe_unlock("concrete", "bm-cement-mix")

dh.add_prereq("automation-3", "concrete")

dh.remove_recipe_unlock("space-platform", "crusher")
--dh.add_recipe_unlock("space-platform", "volcanic-stone-crushing")

dh.add_recipe_unlock("foundry", "bm-molten-glass")
dh.add_recipe_unlock("foundry", "bm-sand-from-lava")
dh.add_recipe_unlock("foundry", "bm-stone-brick-from-lava")

dh.add_recipe_unlock("bm-scrapyard", "bm-landfill-with-wood")
dh.add_recipe_unlock("bm-scrapyard", "bm-landfill-with-spoilage")
dh.add_recipe_unlock("bm-scrapyard", "bm-landfill-from-sand")



------------------------------------------------------ELECTRONICS
dh.add_recipe_unlock("electronics", {"bm-resin", "bm-circuit-board-with-resin"})

dh.add_recipe_unlock("planet-discovery-vulcanus", "bm-circuit-board-with-tar")

dh.add_recipe_unlock("jellynut", "bm-circuit-board-with-jelly")
dh.add_recipe_unlock("carbon-fiber", "bm-circuit-board-with-carbon-fiber")

data.raw["technology"]["lamp"].prerequisites = {"bm-glass"}
dh.add_recipe_unlock("lamp", "bm-lightbulb")
dh.add_prereq("automobilism", "lamp")
dh.add_prereq("modules", "lamp")
dh.add_prereq("railway", "lamp")

dh.remove_recipe_unlock("circuit-network", "display-panel")
dh.add_recipe_unlock("lamp", "display-panel")

dh.add_prereq("electromagnetic-science-pack", "quality-module")
dh.add_prereq("mech-armor", "quality-module-2")
dh.add_prereq("spidertron", "productivity-module-2")



------------------------------------------------OIL
dh.add_prereq("oil-processing", "bm-glass")
dh.add_prereq("bm-alcohol", "bm-glass")
dh.add_prereq("advanced-oil-processing", "bm-alcohol")

dh.remove_recipe_unlock("sulfur-processing", "sulfur")
dh.add_recipe_unlock("sulfur-processing", "bm-sulfur-from-crude-oil")

local aop_unlock = {"bm-solid-fuel-pyrolysis", "bm-solid-fuel-from-tar", "sulfur"}
dh.add_recipe_unlock("advanced-oil-processing", aop_unlock)

--dh.add_recipe_unlock("tungsten-carbide", "carbon-from-tar")

dh.add_recipe_unlock("plastics", "bm-circuit-board")

dh.add_recipe_unlock("lubricant", "bm-lubricant-from-tar")



data:extend({
  --------------------------------------------------------STONE
  {
    type = "technology",
    name = "bm-stone-crushing",
    icon = "__biological-machines-industry__/graphics/stone-crushing.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "crusher"},
      --{type = "unlock-recipe", recipe = "sedimentary-stone-crushing"},
      {type = "unlock-recipe", recipe = "bm-slag-crushing"},
      {type = "unlock-recipe", recipe = "bm-stone-crushing"},
      {type = "unlock-recipe", recipe = "bm-lime"},
    },
    prerequisites = {"automation-science-pack"},
    unit = {
      count = 25,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 15
    }
  },
  {
    type = "technology",
    name = "bm-glass",
    icon = "__biological-machines-core__/graphics/glass-plate.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "bm-glass-mix"},
      {type = "unlock-recipe", recipe = "bm-glass-plate"}
    },
    prerequisites = {"bm-stone-crushing"},
    unit = {
      count = 25,
      ingredients = {{"automation-science-pack", 1}},
      time = 15
    }
  },
  {
    type = "technology",
    name = "bm-fertile-soil",
    icons = {{
      icon = "__base__/graphics/technology/landfill.png",
      icon_size = 256,
      tint = {0.45, 0.25, 0}
    }},
    prerequisites = {"logistic-science-pack", "agriculture"},

    unit = {
      count = 150,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 15
    },

    effects = {{type = "unlock-recipe", recipe = "bm-fertile-soil"}}
  },

  ----------------------------------------------------OIL
  {
    type = "technology",
    name = "bm-biodeisel",
    icon = "__biological-machines-industry__/graphics/biodeisel.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "bm-biodeisel"},
      {type = "unlock-recipe", recipe = "bm-seed-oil-from-trees"},
      {type = "unlock-recipe", recipe = "bm-seed-oil-from-berries"},
      {type = "unlock-recipe", recipe = "bm-seed-oil-from-yumako"},
      {type = "unlock-recipe", recipe = "bm-seed-oil-from-jellynut"}
    },
    prerequisites = {"agricultural-science-pack"},
    unit = {
      count = 1000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"agricultural-science-pack", 1}
      },
      time = 60
    }
  }
})
