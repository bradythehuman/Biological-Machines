require("prototypes.entities")
require("prototypes.items")
require("prototypes.noise-expressions")
require("prototypes.planet")
require("prototypes.recipes")
require("prototypes.resources")
require("prototypes.technologies")
require("prototypes.tiles")



if settings.startup["bm-advanced-solar-panels"].value then
  require("prototypes.advanced-solar-panels")
end

if settings.startup["bm-combat-robot-tweaks"].value then
  require("prototypes.combat-robot-tweaks")
end

if settings.startup["bm-early-logistics-system"].value then
  require("prototypes.early-logistics-system")
end



local dh = require("__biological-machines-core__.data-helper")

dh.mod_override_require("PersonalTeslaDefenseEquipment", "bm-tesla-equipment-override", "prototypes.wit-x-tesla-equipment")

dh.mod_override_require("aai-signal-transmission", "bm-aai-signal-override", "prototypes.wit-x-aai-signal")

dh.mod_override_require("reach-equipment", "bm-reach-equipment-override", "prototypes.wit-x-reach-equipment")

dh.mod_override_require("Repair_Turret", "bm-repair-turret-override", "prototypes.wit-x-repair-turret")



data.raw["autoplace-control"]["vulcanus_volcanism"].order = "c-z-aa"



data:extend({
  --ITEM GROUPS
  {
    type = "item-subgroup",
    name = "bm-wit-tiles",
    group = "tiles",
    order = "f"
  },
  {
    type = "item-subgroup",
    name = "bm-wit-processes", --a=glass, b=thruster-fuel, c=copper
    group = "intermediate-products",
    order = "j-z"
  },

  --RECIIPE CATEGORY
  {
   type = "recipe-category",
   name = "bm-advanced-robotics" --robotics facility only
 },

 --AUTOPLACE CONTROLS
 {
  type = "autoplace-control",
  name = "bm_asteroid_ore",
  localised_name = {"", "[entity=bm-asteroid-ore] ", {"entity-name.bm-asteroid-ore"}},
  richness = true,
  order = "a-z-a",
  category = "resource"
 },
 {
  type = "autoplace-control",
  name = "bm_glass_shard",
  localised_name = {"", "[entity=bm-glass-shard] ", {"entity-name.bm-glass-shard"}},
  richness = true,
  order = "a-z-b",
  category = "resource"
 },
 {
  type = "autoplace-control",
  name = "bm_copper_sulfate",
  localised_name = {"", "[entity=bm-copper-sulfate] ", {"entity-name.bm-copper-sulfate"}},
  richness = true,
  order = "a-z-c",
  category = "resource"
 },
 {
   type = "autoplace-control",
   name = "bm_helium_vent",
   localised_name = {"", "[entity=bm-helium-vent] ", {"entity-name.bm-helium-vent"}},
   richness = true,
   order = "a-z-d",
   category = "resource"
 },
 {
   type = "autoplace-control",
   name = "bm_wit_volcanism",
   order = "c-z-a",
   category = "terrain",
   can_be_disabled = false
 },
})
