require("prototypes.entities")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technologies")

local dh = require("__biological-machines-core__.data-helper")



if mods["quality"] then
  data.raw["assembling-machine"]["bm-suspension-tank-filled"].crafting_speed_quality_multiplier = {
    ["normal"] = 1,
    ["uncommon"] = 0.8,
    ["rare"] = 0.65,
    ["epic"] = 0.55,
    ["legendary"] = 0.4
  }
end

dh.mod_override_require("panglia_planet", "bm-panglia-override", "prototypes.cloning-x-panglia")



data:extend({
  {
    type = "recipe-category",
    name = "bm-suspension-tank"
  },
  {
    type = "recipe-category",
    name = "bm-suspension-tank-filled"
  },
  {
    type = "recipe-category",
    name = "bm-suspension-tank-prepared"
  },
})
