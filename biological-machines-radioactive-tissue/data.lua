require("prototypes.entities")
require("prototypes.equipment")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technologies")

local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_require("ironclad-gunboat-and-mortar-turret-fork", "bm-ironclad-fork-override", "prototypes.tissue-x-ironclad-fork")

dh.mod_override_require("snouz-handcannon", "bm-handcannon-override", "prototypes.tissue-x-handcannon")

dh.mod_override_require("shelter-k2", "bm-shelter-override", "prototypes.tissue-x-shelter")



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
