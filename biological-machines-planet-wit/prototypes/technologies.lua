local dh = require("__biological-machines-core__.data-helper")



--DESCRIPTIONS
data.raw["technology"]["space-platform"].localised_description = {"technology-description.bm-new-space-platform"}

local space_sci_tech = data.raw["technology"]["space-science-pack"]
space_sci_tech.localised_description = {"technology-description.bm-new-space-science-pack"}
space_sci_tech.prerequisites = {"robotics-facility"}

local thruster_tech = data.raw["technology"]["space-platform-thruster"]
thruster_tech.localised_name = {"technology-name.bm-interplanetary-travel"}
thruster_tech.localised_description = {"technology-description.bm-interplanetary-travel"}
thruster_tech.prerequisites = {"space-science-pack"}



--RECIPE UNLOCKS
local crushing_unlocks = {
  "carbonic-asteroid-crushing", "oxide-asteroid-crushing", "metallic-asteroid-crushing"
}
dh.remove_recipe_unlock("space-platform", crushing_unlocks)

dh.remove_recipe_unlock("space-platform-thruster", "ice-melting")

local space_platform_unlocks = {
  "thruster", "thruster-fuel", "thruster-oxidizer",
}
dh.remove_recipe_unlock("space-platform-thruster", space_platform_unlocks)
dh.add_recipe_unlock("space-platform", space_platform_unlocks)

--dh.add_recipe_unlock("space-platform", "water-separation")

dh.add_recipe_unlock("foundry", "bm-molten-glass-from-shard")
dh.add_recipe_unlock("foundry", "bm-molten-copper-from-dust")

dh.remove_prereq("laser", "chemical-science-pack")
dh.add_prereq("laser", "space-science-pack")

dh.add_prereq("bm-warp-drive", "bm-interstellar-science-pack")



--ADD SPACE SCIENCE TO TECH COSTS
local add_space_sci_pack = {
  "distractor", "destroyer", "follower-robot-count-4",
  "laser","laser-turret","electric-weapons-damage-1",
  "discharge-defense-equipment", "personal-laser-defense-equipment"
}
for i=1, #add_space_sci_pack do
  table.insert(data.raw["technology"][add_space_sci_pack[i]].unit.ingredients, {"space-science-pack", 1})
end

for i=1, 6 do
  table.insert(data.raw["technology"]["laser-shooting-speed-" .. i].unit.ingredients, {"space-science-pack", 1})
  table.insert(data.raw["technology"]["laser-weapons-damage-" .. i].unit.ingredients, {"space-science-pack", 1})
end
table.insert(data.raw["technology"]["laser-shooting-speed-7"].unit.ingredients, {"space-science-pack", 1})

dh.add_prereq("destroyer", "electromagnetic-science-pack")

local add_em_sci_pack = {
  "destroyer", "follower-robot-count-4",
  "electric-weapons-damage-1", "electric-weapons-damage-2"
}
for i=1, #add_em_sci_pack do
  table.insert(data.raw["technology"][add_em_sci_pack[i]].unit.ingredients, {"electromagnetic-science-pack", 1})
end



--GLASS COMPAT W/ INDUSTRY
--[[
if mods["biological-machines-industry"] then
  dh.add_recipe_unlock("space-science-pack", "glass-shard-crushing")
end
]]



data:extend({
  {
    type = "technology",
    name = "bm-planet-discovery-wit",
    icons = PlanetsLib.technology_icon_moon("__biological-machines-planet-wit__/graphics/wit-technology.png", 256),
    --icons = util.technology_icon_constant_planet("__biological-machines-planet-wit__/graphics/wit-technology.png"),
    --icon = "__biological-machines-planet-wit__/graphics/wit-technology.png",
    --icon_size = 256,
    effects = {
      {
        type = "unlock-space-location",
        space_location = "bm-wit",
        use_icon_overlay_constant = false,
        --icons = PlanetsLib.technology_icon_moon("__biological-machines-planet-wit__/graphics/wit-icon.png", 64),
      }
    },
    prerequisites = {"space-platform", "electric-boiler"},
    research_trigger = {
      type = "build-entity",
      entity = "thruster"
    }
  },
  {
    type = "technology",
    name = "bm-asteroid-deposit",
    icon = "__biological-machines-planet-wit__/graphics/asteroid-deposit.png",
    icon_size = 256,
    effects = {
      {type = "unlock-recipe", recipe = "bm-plastic-from-thruster-fuel"},
      {type = "unlock-recipe", recipe = "bm-solid-fuel-from-thruster-fuel"},
      {type = "unlock-recipe", recipe = "bm-rocket-fuel-from-thruster-fuel"},
      {type = "unlock-recipe", recipe = "bm-lubricant-from-thruster-fuel"},
      {type = "unlock-recipe", recipe = "ice-melting"},
    },
    prerequisites = {"bm-planet-discovery-wit"},
    research_trigger = {
      type = "mine-entity",
      entity = "bm-big-wit-rock"
    }
  },
  {
    type = "technology",
    name = "bm-glass-deposit",
    icon = "__biological-machines-planet-wit__/graphics/glass-deposit.png",
    icon_size = 256,
    effects = {
      {type = "unlock-recipe", recipe = "bm-glass-plate-from-shard"},
      {type = "unlock-recipe", recipe = "bm-landfill-from-shard"},
      {type = "unlock-recipe", recipe = "bm-rail-from-glass-shard"},
      {type = "unlock-recipe", recipe = "bm-brick-from-glass-shard"},
      {type = "unlock-recipe", recipe = "bm-glass-dust-filtration"},
    },
    prerequisites = {"bm-planet-discovery-wit"},
    research_trigger = {
      type = "mine-entity",
      entity = "bm-glassberg-big"
    }
  },
  {
    type = "technology",
    name = "bm-asteroid-crushing",
    --icon = "__space-age__/graphics/asteroid-productivity.png",
    icon = "__biological-machines-planet-wit__/graphics/asteroid-crushing.png",
    icon_size = 256,
    effects = {
      {type = "unlock-recipe", recipe = "carbonic-asteroid-crushing"},
      {type = "unlock-recipe", recipe = "oxide-asteroid-crushing"},
      {type = "unlock-recipe", recipe = "metallic-asteroid-crushing"},
    },
    prerequisites = {"bm-asteroid-deposit", "bm-glass-deposit"},
    research_trigger = {
      type = "mine-entity",
      entity = "bm-asteroid-ore"
    }
  },
  {
    type = "technology",
    name = "bm-copper-sulfate-processing",
    icon = "__biological-machines-planet-wit__/graphics/copper-sulfate-processing.png",
    icon_size = 256,
    effects = {
      {type = "unlock-recipe", recipe = "bm-copper-sulfate-electrolysis"},
      {type = "unlock-recipe", recipe = "bm-copper-plate-from-dust"},
    },
    prerequisites = {"bm-asteroid-deposit", "bm-glass-deposit"},
    research_trigger = {
      type = "mine-entity",
      entity = "bm-copper-sulfate"
    }
  },
  {
    type = "technology",
    name = "bm-helium-processing",
    icon = "__biological-machines-planet-wit__/graphics/helium-processing.png",
    icon_size = 256,
    effects = {
      {type = "unlock-recipe", recipe = "bm-helium-power-cell"},
    },
    prerequisites = {"bm-asteroid-crushing", "bm-copper-sulfate-processing"},
    research_trigger = {
      type = "mine-entity",
      entity = "bm-helium-vent"
    }
  },
  {
    type = "technology",
    name = "bm-interstellar-science-pack",
    icon = "__biological-machines-planet-wit__/graphics/interstellar-science-pack-technology.png",
    icon_size = 256,
    essential = true,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "bm-interstellar-science-pack",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-mixed-gas-power-cell",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-empty-data-disk",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-initial-data",
      },
      {
        type = "unlock-recipe",
        recipe = "bm-secondary-data",
      },
    },
    prerequisites = {"promethium-science-pack"},
    unit = {
      count = 1000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1},
      },
      time = 120,
    }
  },
  {
    type = "technology",
    name = "bm-advanced-accumulator",
    icon = "__biological-machines-planet-wit__/graphics/advanced-accumulator/advanced-accumulator-icon-big.png",
    icon_size = 640,
    essential = true,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "bm-advanced-accumulator",
      },
    },
    prerequisites = {"bm-interstellar-science-pack"},
    unit = {
      count = 2500,
      ingredients = BM_COPY_ALL_SCI_PACKS(),
      time = 120,
    }
  },
})
