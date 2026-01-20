local dh = require("__biological-machines-core__.data-helper")



--ALL SCIENCE
table.insert(bm_all_sci_packs, {"bm-nuclear-military-science-pack", 1})



--fix technology prerequisites
dh.remove_prereq("uranium-ammo", {"tank", "uranium-processing"})

dh.remove_prereq("biolab", {"biter-egg-handling", "uranium-processing"})
dh.add_prereq("biolab", {"agricultural-science-pack", "bm-nuclear-military-science-pack"})

dh.remove_prereq("fission-reactor-equipment", "military-science-pack")

local add_nuclear_military = {
  "uranium-ammo", "fission-reactor-equipment", "atomic-bomb", "spidertron",
  "physical-projectile-damage-7", "captive-biter-spawner", "railgun",
  "promethium-science-pack", "bm-reinforced-wall",
}
dh.add_prereq(add_nuclear_military, "bm-nuclear-military-science-pack")

dh.remove_prereq("bm-reinforced-wall", "military-3")

dh.remove_prereq("bm-cloning", "captive-biter-spawner")
dh.add_prereq("bm-cloning", "bm-radioactive-tissue-cultivation")
dh.add_prereq("bm-cloning", "bm-poison")



--fix technology ingredients
local add_ingredient = {
  "uranium-ammo",
  "fission-reactor-equipment",
  "atomic-bomb",
  "spidertron",
  "biolab",
  "physical-projectile-damage-7",
  "captive-biter-spawner",
  "railgun",
  "railgun-shooting-speed-1",
  "railgun-damage-1",
  "promethium-science-pack",
  "research-productivity",
  "bm-reinforced-wall",
  "bm-cloning",
}
for _, t in pairs(add_ingredient) do
  table.insert(data.raw["technology"][t].unit.ingredients, {"bm-nuclear-military-science-pack", 1})
end

table.insert(data.raw["technology"]["promethium-science-pack"].unit.ingredients, {"military-science-pack", 1})



--fix base technology other parameters
dh.remove_recipe_unlock("military-3", "poison-capsule")

data.raw["technology"]["fission-reactor-equipment"].unit.count = 100

local modifiers = {0.25, 0.25, 0.05, 0.05, 0.05, 0.1, 0.1}
for i=1, 7 do
  local effects = data.raw["technology"]["physical-projectile-damage-"..i].effects
  local effect = {type = "ammo-damage", ammo_category = "bm-poison-bullet", modifier = modifiers[i]}
  table.insert(effects, effect)
end



data:extend({
  {
    type = "technology",
    name = "bm-poison",
    icon = "__biological-machines-radioactive-tissue__/graphics/poison.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "bm-poison"},
      {type = "unlock-recipe", recipe = "bm-poison-rounds-magazine"},
      {type = "unlock-recipe", recipe = "poison-capsule"},
      {type = "unlock-recipe", recipe = "bm-poison-mine"}
    },
    prerequisites = {"chemical-science-pack", "military-science-pack"},

    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    }
  },
  {
    type = "technology",
    name = "bm-nuclear-military-science-pack",
    icon = "__biological-machines-radioactive-tissue__/graphics/nuclear-military-science-pack-research.png",
    icon_size = 256,
    effects = {{type = "unlock-recipe", recipe = "bm-nuclear-military-science-pack"}},
    prerequisites = {"uranium-processing", "tank"},

    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    }
  },
  {
    type = "technology",
    name = "bm-poison-damage-1",
    icons = {
      {
        icon = "__biological-machines-radioactive-tissue__/graphics/poison.png",
        icon_size = 64,
        scale = 4
      },
      {
        icon = "__core__/graphics/icons/technology/constants/constant-damage.png",
        icon_size = 128,
        scale = 1,
        shift = {50, 50},
        floating = true
      }
    },
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bm-poison",
        modifier = 0.2
      },
      {
        type = "ammo-damage",
        ammo_category = "bm-poison-bullet",
        modifier = 0.1
      }
    },
    prerequisites = {"bm-poison", "bm-nuclear-military-science-pack"},
    unit = {
      count_formula = "2^(L-4)*1000",
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"bm-nuclear-military-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true
  },
  {
    type = "technology",
    name = "bm-radioactive-tissue-processing",
    icon = "__biological-machines-radioactive-tissue__/graphics/hardened-tissue.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "bm-hardened-tissue"},
      {type = "unlock-recipe", recipe = "bm-hardened-tissue-processing"},
      {type = "unlock-recipe", recipe = "bm-biosludge-processing"}
    },
    prerequisites = {"bm-poison", "bm-nuclear-military-science-pack"},

    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"bm-nuclear-military-science-pack", 1}
      },
      time = 30
    }
  },
  {
    type = "technology",
    name = "bm-radioactive-tissue-cultivation",
    icon = "__biological-machines-radioactive-tissue__/graphics/radioactive-tissue.png",
    icon_size = 64,
    effects = {{type = "unlock-recipe", recipe = "bm-radioactive-tissue-cultivation"}},
    prerequisites = {"bm-nuclear-military-science-pack", "agricultural-science-pack"},

    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"bm-nuclear-military-science-pack", 1},
        {"agricultural-science-pack", 1}
      },
      time = 30
    }
  },
  {
    type = "technology",
    name = "bm-cybernetic-contact",
    icon = "__biological-machines-radioactive-tissue__/graphics/cybernetic-contact.png",
    icon_size = 64,
    effects = {{type = "unlock-recipe", recipe = "bm-cybernetic-contact"}},
    prerequisites = {"bm-radioactive-tissue-cultivation", "night-vision-equipment", "utility-science-pack"},

    unit = {
      count = 1000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"military-science-pack", 1},
        {"bm-nuclear-military-science-pack", 1},
        {"agricultural-science-pack", 1}
      },
      time = 30
    }
  },
  {
    type = "technology",
    name = "bm-military-automation",
    --icons = {{icon = "__base__/graphics/technology/automation-3.png", icon_size = 256, tint = {1, 0.5, 1, 1}}},
    icon = "__biological-machines-k2-assets__/graphics/aam-technology.png",
    icon_size = 256,
    effects = {{type = "unlock-recipe", recipe = "bm-military-assembling-machine"}},
    prerequisites = {"bm-nuclear-military-science-pack", "metallurgic-science-pack", "automation-3"},

    unit = {
      count = 1000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"space-science-pack", 1},
        {"military-science-pack", 1},
        {"bm-nuclear-military-science-pack", 1},
        {"metallurgic-science-pack", 1}
      },
      time = 30
    }
  },
})
