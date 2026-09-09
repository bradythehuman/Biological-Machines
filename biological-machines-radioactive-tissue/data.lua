require("prototypes.entities")
require("prototypes.equipment")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technologies")

local dh = require("__biological-machines-core__.data-helper")



if mods["biological-machines-reinforced-wall"] then
  dh.remove_prereq("bm-reinforced-wall", "military-3")
  dh.add_prereq("bm-reinforced-wall", "bm-nuclear-military-science-pack")
end

if mods["crushing-industry"] and settings.startup["crushing-industry-coal"].value then
  dh.remove_ingredient("poison-capsule", "crushed-coal")
else
  dh.remove_ingredient("poison-capsule", "coal")
end

dh.mod_override_require("ironclad-gunboat-and-mortar-turret-fork", "bm-ironclad-fork-override", "prototypes.tissue-x-ironclad-fork")

dh.mod_override_require("snouz-handcannon", "bm-handcannon-override", "prototypes.tissue-x-handcannon")

dh.mod_override_require("shelter-k2", "bm-shelter-override", "prototypes.tissue-x-shelter")

dh.mod_override_require("panglia_planet", "bm-panglia-override", "prototypes.tissue-x-panglia")





data:extend({
  {
    type = "ammo-category",
    name = "bm-poison",
    icon = "__biological-machines-radioactive-tissue__/graphics/poison-ammo-category.png",
    subgroup = "ammo-category"
  },
  {
    type = "ammo-category",
    name = "bm-poison-bullet",
    icon = "__base__/graphics/icons/ammo-category/bullet.png",
    subgroup = "ammo-category"
  },
  {
    type = "recipe-category",
    name = "bm-military-crafting"
  },
  {
    type = "recipe-category",
    name = "bm-military-crafting-with-fluid"
  },
  {
    type = "fuel-category",
    name = "bm-radioactive-mineral"
  },
})
