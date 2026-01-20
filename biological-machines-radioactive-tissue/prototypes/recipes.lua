local dh = require("__biological-machines-core__.data-helper")



local poison_capsule = data.raw["recipe"]["poison-capsule"]
poison_capsule.category = "bm-military-crafting-with-fluid"
poison_capsule.ingredients = {
  {type = "item", name = "steel-plate", amount = 1},
  {type = "item", name = "plastic-bar", amount = 5},
  {type = "fluid", name = "bm-poison", amount = 20}
}

data.raw["recipe"]["slowdown-capsule"].ingredients = {
  {type = "item", name = "steel-plate", amount = 1},
  {type = "item", name = "plastic-bar", amount = 5},
  {type = "item", name = "coal", amount = 5}
}

data.raw["recipe"]["flamethrower-ammo"].category = "bm-military-crafting-with-fluid"



dh.remove_ingredient("spidertron", "raw-fish")

local remove_u_235 = {"biolab", "captive-biter-spawner"}
dh.remove_ingredient(remove_u_235, "uranium-235")

local remove_egg = {"biolab", "bm-clone"}
dh.remove_ingredient(remove_egg, "biter-egg")

local add_tissue = {
  ["spidertron"] = 1,
  ["biolab"] = 10,
  ["captive-biter-spawner"] = 10,
  ["bm-clone"] = 2
}
dh.add_ingredient_table(add_tissue, "item", "bm-radioactive-tissue")

dh.remove_ingredient("bm-suspension-fluid", "sulfuric-acid")
dh.add_ingredient("bm-suspension-fluid", "fluid", "bm-poison", 10)



--move recipes to military crafting category
local to_military_cc = {
  "firearm-magazine", "piercing-rounds-magazine", "uranium-rounds-magazine",
  "shotgun-shell", "piercing-shotgun-shell",
  "rocket", "explosive-rocket", "atomic-bomb",
  "cannon-shell", "explosive-cannon-shell",
  "uranium-cannon-shell", "explosive-uranium-cannon-shell",
  "artillery-shell", "railgun-ammo",
  "gun-turret", "flamethrower-turret", "rocket-turret",
  "artillery-turret", "artillery-wagon",
  --"car", "tank", "spidertron",
  --"light-armor", "heavy-armor", "modular-armor",
  --"power-armor", "power-armor-mk2", "mech-armor",
  "submachine-gun", "shotgun", "combat-shotgun", "flamethrower", "rocket-launcher",
  --"laser-turret", "personal-laser-defense-equipment", "discharge-defense-equipment",
  "grenade", "cluster-grenade", "poison-capsule", "slowdown-capsule", "land-mine",
  "military-science-pack",
}
for _, recipe in pairs(to_military_cc) do
  data.raw["recipe"][recipe].category = "bm-military-crafting"
end



data:extend({
  {
    type = "recipe",
    name = "bm-radioactive-tissue-cultivation",
    icon = "__biological-machines-radioactive-tissue__/graphics/radioactive-tissue-cultivation.png",
    category = "organic",
    subgroup = "bm-cultivation",
    order = "c-b",
    surface_conditions = {{property = "pressure", min = 1000, max = 2000}},
    enabled = false,
    allow_productivity = true,
    result_is_always_fresh = true,
    energy_required = 30,
    ingredients = {
      {type = "item", name = "bm-radioactive-tissue", amount = 1},
      {type = "item", name = "uranium-235", amount = 1},
      {type = "item", name = "bioflux", amount = 25}
    },
    results = {{type = "item", name = "bm-radioactive-tissue", amount = 2}}
  },
  {
    type = "recipe",
    name = "bm-hardened-tissue",
    icon = "__biological-machines-radioactive-tissue__/graphics/hardened-tissue.png",
    category = "chemistry",
    subgroup = "bm-cultivation",
    order = "c-c",
    enabled = false,
    allow_productivity = false,
    result_is_always_fresh = true,
    energy_required = 15,
    ingredients = {
      {type = "item", name = "bm-radioactive-tissue", amount = 1},
      {type = "item", name = "iron-ore", amount = 10},
      {type = "fluid", name = "steam", amount = 50}
    },
    results = {
      {type = "item", name = "bm-hardened-tissue", amount = 1},
      {type = "fluid", name = "bm-radioactive-biosludge", amount = 50}
    },
    main_product = "bm-hardened-tissue"
  },
  {
    type = "recipe",
    name = "bm-biosludge-processing",
    icon = "__biological-machines-radioactive-tissue__/graphics/radioactive-biosludge.png",
    category = "organic-or-chemistry",
    subgroup = "bm-biological-fluid-recipes",
    order = "b-c",
    enabled = false,
    allow_productivity = true,
    energy_required = 15,
    ingredients = {
      {type = "fluid", name = "bm-radioactive-biosludge", amount = 50},
      {type = "fluid", name = "sulfuric-acid", amount = 25}
    },
    results = {
      {type = "item", name = "spoilage", amount = 25},
      {type = "fluid", name = "bm-poison", amount = 25},
      {type = "fluid", name = "water", amount = 25}
    }
  },
  {
    type = "recipe",
    name = "bm-hardened-tissue-processing",
    icon = "__biological-machines-radioactive-tissue__/graphics/hardened-tissue-processing.png",
    category = "centrifuging",
    subgroup = "bm-cultivation",
    order = "c-d",
    enabled = false,
    allow_decomposition = false,
    allow_productivity = true,
    energy_required = 60,
    ingredients = {{type = "item", name = "bm-hardened-tissue", amount = 1}},
    results = {
     {type = "item", name = "uranium-ore", amount = 3},
     {type = "item", name = "spoilage", amount = 30}
    }
  },
  {
    type = "recipe",
    name = "bm-nuclear-military-science-pack",
    icon = "__biological-machines-radioactive-tissue__/graphics/nuclear-military-science-pack.png",
    category = "bm-military-crafting",
    enabled = false,
    energy_required = 15,
    allow_productivity = true,
    ingredients = {
      {type = "item", name = "bm-radioactive-tissue", amount = 1},
      {type = "item", name = "refined-concrete", amount = 5},
      {type = "item", name = "cannon-shell", amount = 5},
      {type = "item", name = "uranium-238", amount = 5}
    },
    results = {{type = "item", name = "bm-nuclear-military-science-pack", amount = 5}}
  },
  {
    type = "recipe",
    name = "bm-poison",
    icon = "__biological-machines-radioactive-tissue__/graphics/poison.png",
    category = "organic-or-chemistry",
    subgroup = "bm-biological-fluid-recipes",
    order = "b-a",
    enabled = false,
    energy_required = 15,
    allow_productivity = true,
    ingredients = {
      {type = "item", name = "bm-radioactive-tissue", amount = 1},
      {type = "fluid", name = "sulfuric-acid", amount = 25}
    },
    results = {
      {type = "item", name = "spoilage", amount = 25},
      {type = "fluid", name = "bm-poison", amount = 50}
    },
    primary_result = "bm-poison",
  },
  {
    type = "recipe",
    name = "bm-poison-rounds-magazine",
    icon = "__biological-machines-radioactive-tissue__/graphics/poison-rounds-magazine.png",
    category = "bm-military-crafting-with-fluid",
    enabled = false,
    energy_required = 6,
    allow_productivity = false,
    ingredients = {
      {type = "item", name = "piercing-rounds-magazine", amount = 1},
      {type = "item", name = "plastic-bar", amount = 5},
      {type = "fluid", name = "bm-poison", amount = 20}
    },
    results = {{type = "item", name = "bm-poison-rounds-magazine", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-poison-mine",
    icon = "__biological-machines-radioactive-tissue__/graphics/poison-mine.png",
    category = "bm-military-crafting-with-fluid",
    enabled = false,
    allow_productivity = false,
    energy_required = 8,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 1},
      {type = "item", name = "plastic-bar", amount = 5},
      {type = "fluid", name = "bm-poison", amount = 50}
    },
    results = {{type = "item", name = "bm-poison-mine", amount = 4}}
  },
  {
    type = "recipe",
    name = "bm-cybernetic-contact",
    icon = "__biological-machines-radioactive-tissue__/graphics/cybernetic-contact.png",
    category = "crafting-with-fluid",
    enabled = false,
    allow_productivity = false,
    energy_required = 30,
    ingredients = {
      {type = "item", name = "jelly", amount = 10},
      {type = "item", name = "processing-unit", amount = 5},
      {type = "item", name = "bm-radioactive-tissue", amount = 1},
      {type = "fluid", name = "steam", amount = 25}
    },
    results = {{type = "item", name = "bm-cybernetic-contact", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-military-assembling-machine",
    --icons = {{icon = "__base__/graphics/icons/assembling-machine-3.png", tint = {1, 0.5, 1, 1}}},
    icon = "__biological-machines-k2-assets__/graphics/aam-icon.png",
    category = "crafting",
    enabled = false,
    allow_productivity = false,
    energy_required = 15,
    ingredients = {
      {type = "item", name = "refined-concrete", amount = 20},
      {type = "item", name = "assembling-machine-3", amount = 2},
      {type = "item", name = "bm-radioactive-tissue", amount = 10},
      {type = "item", name = "tungsten-plate", amount = 50},
      {type = "item", name = "electric-engine-unit", amount = 20}
    },
    results = {{type = "item", name = "bm-military-assembling-machine", amount = 1}}
  },
})
