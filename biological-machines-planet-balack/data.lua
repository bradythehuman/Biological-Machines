require("prototypes.decoratives")
require("prototypes.enemies")
require("prototypes.entities")
require("prototypes.items")
require("prototypes.noise-expressions")
require("prototypes.planet")
require("prototypes.recipes")
require("prototypes.resources")
require("prototypes.technologies")
require("prototypes.tiles")

require("prototypes.k2-wind-turbine")
require("prototypes.mech-armor-mk2-animations")



if settings.startup["bm-shattered-core"].value then
  require("prototypes.shattered-core")
end



local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_require("BuggisNuclearBots", "bm-nuclear-bots-override", "prototypes.balack-x-nuclear-bots")



data:extend({
  {
    type = "module-category",
    name = "bm-ai"
  },

  {
    type = "recipe-category",
    name = "bm-bio-cube"
  },

  --ITEM GROUPS
  {
    type = "item-subgroup",
    name = "bm-balack-tiles",
    group = "tiles",
    order = "z"
  },
  {
    type = "item-subgroup",
    name = "bm-balack-processes",
    group = "intermediate-products",
    order = "p-z"
  },

  --AUTOPLACE CONTROLS
  {
    type = "autoplace-control",
    name = "bm_balack_scrap",
    localised_name = {"", "[entity=bm-balack-scrap] ", {"entity-name.bm-balack-scrap"}},
    richness = true,
    --order = "d-a",
    order = "f-a",
    category = "resource"
  },
  {
    type = "autoplace-control",
    name = "bm_balack_cliff",
    --order = "c-z-c",
    order = "f-z-c",
    category = "cliff"
  },
  {
    type = "autoplace-control",
    name = "bm_balack_islands",
    --order = "c-z-d",
    order = "f-z-d",
    category = "terrain",
    can_be_disabled = false,
  },
  {
    type = "autoplace-control",
    name = "bm_promethium_ore",
    localised_name = {"", "[entity=bm-promethium-ore] ", {"entity-name.bm-promethium-ore"}},
    richness = true,
    --order = "d-a",
    order = "f-a",
    category = "resource"
  },

  --COLLISION
  {
    type = "collision-layer",
    name = "bm_bio_cube_pool",
  },

  --EQUIPMENT GRID
  {
    type = "equipment-grid",
    name = "bm-colossal-equipment-grid",
    width = 13,
    height = 13,
    equipment_categories = {"armor"}
  }
})
