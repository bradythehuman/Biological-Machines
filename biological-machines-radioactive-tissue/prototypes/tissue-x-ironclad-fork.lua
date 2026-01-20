local dh = require("__biological-machines-core__.data-helper")



--AMMO CATEGORIES
data:extend({
  {
    type = "ammo-category",
    name = "bm-poison-mortar",
    icon = "__aai-vehicles-ironclad__/graphics/icons/mortar-bomb-ammo-category.png",
    subgroup = "ammo-category"
  },
  {
    type = "ammo-category",
    name = "bm-fire-mortar",
    icon = "__aai-vehicles-ironclad__/graphics/icons/mortar-bomb-ammo-category.png",
    subgroup = "ammo-category"
  },
})

data.raw["ammo"]["mortar-poison-bomb"].ammo_category = "bm-poison-mortar"
data.raw["ammo"]["mortar-fire-bomb"].ammo_category = "bm-fire-mortar"

local ironclad_attack = data.raw["gun"]["ironclad-mortar"].attack_parameters
ironclad_attack.ammo_category = nil
ironclad_attack.ammo_categories = {
  "mortar-bomb", "bm-poison-mortar", "bm-fire-mortar"
}

local turret_attack = data.raw["ammo-turret"]["mortar-turret"].attack_parameters
turret_attack.ammo_category = nil
turret_attack.ammo_categories = {
  "mortar-bomb", "bm-poison-mortar", "bm-fire-mortar"
}



--CRAFTING CATEGORY
local to_military_cc = {
  "mortar-bomb", "mortar-cluster-bomb",
  "mortar-poison-bomb", "mortar-fire-bomb",
  "mortar-turret",
}
for _, recipe in pairs(to_military_cc) do
  data.raw["recipe"][recipe].category = "bm-military-crafting"
end



--TECHNOLOGY
local poison_effects = data.raw["technology"]["bm-poison-damage-1"].effects
table.insert(poison_effects, {
  type = "ammo-damage",
  ammo_category = "bm-poison-mortar",
  modifier = 0.2
})

local fire_modifiers = {0.2, 0.2, 0.2, 0.3, 0.3, 0.4, 0.2}
for i=1, 7 do
  local fire_effects = data.raw["technology"]["refined-flammables-"..i].effects
  table.insert(fire_effects, {
    type = "ammo-damage",
    ammo_category = "bm-fire-mortar",
    modifier = fire_modifiers[i]
  })
end
