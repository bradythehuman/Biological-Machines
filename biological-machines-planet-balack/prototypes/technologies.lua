
--[[
-shattered planet discovery requires 200 promethium science
-balack planet discovery (prereq/requires 1000 promethium science)
  -unlocks ai control unit and radiation sheilding recipe
-hyperspace (prereq balack, requires 25k promethium science)
  -unlocks hyperspace drive and hyperspace power cell recipes
-mech armor mk2 (prereq balack/mech armor, requires 5k promethium science)
]]

local promethium_sci_tech = data.raw["technology"]["promethium-science-pack"]
local promethium_sci_effects = {}
for _, effect in pairs(promethium_sci_tech.effects) do
  if effect.space_location ~= "shattered-planet" then
    table.insert(promethium_sci_effects, effect)
  end
end
promethium_sci_tech.effects = promethium_sci_effects



table.insert(data.raw.technology["scrap-recycling-productivity"].effects, {
  type = "change-recipe-productivity",
  recipe = "bm-balack-scrap-recycling",
  change = 0.1
})



data.raw.technology["bm-warp-drive"].prerequisites = {"bm-activated-ai-control-unit"}
table.insert(data.raw.technology["bm-warp-drive"].effects,
  {type = "unlock-recipe", recipe = "bm-warp-drive-part"}
)



data:extend({
  {
    type = "technology",
    name = "bm-planet-discovery-shattered-planet",
    icons = util.technology_icon_constant_planet("__biological-machines-planet-balack__/graphics/shattered-planet-technology.png"),
    icon_size = 256,
    essential = true,
    effects = {
      {
        type = "unlock-space-location",
        space_location = "shattered-planet",
        use_icon_overlay_constant = true
      },
    },
    prerequisites = {"promethium-science-pack"},
    unit = {
      count = 250,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    }
  },
  {
    type = "technology",
    name = "bm-planet-discovery-balack",
    icons = util.technology_icon_constant_planet("__biological-machines-planet-balack__/graphics/balack-technology.png"),
    --icon_size = 256,
    essential = true,
    effects = {
      {
        type = "unlock-space-location",
        space_location = "bm-balack",
        use_icon_overlay_constant = true
      },
      {type = "unlock-recipe", recipe = "bm-balack-scrap-recycling"},
      {type = "unlock-recipe", recipe = "bm-oil-sludge-seperation"},
      {type = "unlock-recipe", recipe = "bm-bio-cube"},
      {type = "unlock-recipe", recipe = "bm-radiation-sheilding"},
      {type = "unlock-recipe", recipe = "bm-ai-control-unit"},
    },
    prerequisites = {"promethium-science-pack", "automation-3"},
    unit = {
      count = 1000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    }
  },
  {
    type = "technology",
    name = "bm-activated-ai-control-unit",
    icon = "__biological-machines-planet-balack__/graphics/ai-control-unit-tech.png",
    icon_size = 256,
    essential = true,
    effects = {
      {type = "unlock-recipe", recipe = "bm-ai-control-unit-active"},
    },
    prerequisites = {"bm-planet-discovery-balack"},
    unit = {
      count = 2500,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    }
  },
  {
    type = "technology",
    name = "bm-tank-mk2",
    icons = {
      {
        icon = "__base__/graphics/technology/tank.png",
        icon_size = 256,
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/tier-2.png",
        icon_size = 64,
        shift = {32, -32},
        scale = 1,
      },
    },
    essential = true,
    effects = {
      {type = "unlock-recipe", recipe = "bm-tank-mk2"},
    },
    prerequisites = {"bm-planet-discovery-balack", "tank", "fusion-reactor-equipment", "railgun"},
    unit = {
      count = 5000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    }
  },
  {
    type = "technology",
    name = "bm-mech-armor-mk2",
    icons = {
      {
        icon = "__space-age__/graphics/technology/mech-armor.png",
        icon_size = 256,
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/tier-2.png",
        icon_size = 64,
        shift = {32, -32},
        scale = 1,
      },
    },
    essential = true,
    effects = {
      {type = "unlock-recipe", recipe = "bm-mech-armor-mk2"},
    },
    prerequisites = {"bm-planet-discovery-balack", "mech-armor"},
    unit = {
      count = 10000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    }
  },
  {
    type = "technology",
    name = "bm-bio-cube-ooze",
    icon = "__biological-machines-planet-balack__/graphics/bio-cube-ooze.png",
    essential = true,
    effects = {
      {type = "unlock-recipe", recipe = "bm-bio-cube-ooze"},
      {type = "unlock-recipe", recipe = "bm-radiation-sheilding-from-ooze"},
    },
    prerequisites = {"bm-planet-discovery-balack"},
    unit = {
      count = 2500,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    }
  },
  {
    type = "technology",
    name = "bm-hypersonic-ammo",
    icon = "__biological-machines-planet-balack__/graphics/hypersonic-ammo.png",
    icon_size = 256,
    essential = true,
    effects = {
      {type = "unlock-recipe", recipe = "bm-hypersonic-rounds-magazine"},
    },
    prerequisites = {"bm-planet-discovery-balack", "uranium-ammo", "atomic-bomb"},
    unit = {
      count = 2500,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    }
  },
})
