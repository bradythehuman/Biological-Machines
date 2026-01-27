require("prototypes.entities")
require("prototypes.items")
require("prototypes.noise-expressions")
require("prototypes.recipes")
require("prototypes.resources")
require("prototypes.technologies")
require("prototypes.tiles")



if settings.startup["bm-deep-crude-oil"].value then
  require("prototypes.deep-crude-oil")
end

if settings.startup["bm-complex-science"].value then
  require("prototypes.complex-science")
end

if settings.startup["bm-boompuff-agriculture"].value then
  require("prototypes.boompuff-agriculture")
end

--[[
if  mods["aai-loaders"] and settings.startup["aai-loader-override"].value then
  require("prototypes.industry-x-aai-loader")
end
]]

local dh = require("__biological-machines-core__.data-helper")

dh.mod_override_require("aai-loaders", "bm-aai-loader-override", "prototypes.industry-x-aai-loader")

dh.mod_override_require("slipstacks", "bm-slipstack-agriculture-override", "prototypes.industry-x-slipstack-agriculture")

dh.mod_override_require("LargerLamps-2_0", "bm-larger-lamps-override", "prototypes.industry-x-larger-lamps")

dh.mod_override_require("snouz_better_substation", "bm-snouz-substation-override", "prototypes.industry-x-snouz-substation")

dh.mod_override_require("shield-projector", "bm-shield-projector-override", "prototypes.industry-x-shield-projector")

dh.mod_override_require("pollution-detector", "bm-pollution-detector-override", "prototypes.industry-x-pollution-detector")

dh.mod_override_require("big-wooden-pole", "bm-big-wooden-pole-override", "prototypes.industry-x-big-wooden-pole")



data:extend({
  {
    type = "recipe-category",
    name = "bm-pyrolysis"
  },
  {
    type = "item-subgroup",
    name = "bm-pyrolysis",
    group = "intermediate-products",
    order = "ba"
  },
  --a=powder, b=mix
  {
    type = "item-subgroup",
    name = "bm-powder",
    group = "intermediate-products",
    order = "bb"
  },
  {
  	type = "autoplace-control",
  	localised_name = {"", "[item=bm-sand] ", {"entity-name.bm-sand"}},
  	name = "bm-sand",
  	richness = true,
  	order = "a-i",
  	category = "resource"
  },
  {
  	type = "autoplace-control",
  	localised_name = {"", "[item=bm-potash] ", {"entity-name.bm-potash"}},
  	name = "bm-potash",
  	richness = true,
  	order = "b-a-a",
  	category = "resource"
  },
})



---------------------------------------SURFACE ROCK TYPE
--[[
data:extend({{
  type = "surface-property",
  name = "rock",
  default_value = 0, --0 is volcanic, 1 is sedimentary
  hidden = true
}})

data.raw.surface["space-platform"].surface_properties.rock = 0
data.raw.planet["nauvis"].surface_properties.rock = 1
data.raw.planet["vulcanus"].surface_properties.rock = 0
data.raw.planet["fulgora"].surface_properties.rock = 1
data.raw.planet["gleba"].surface_properties.rock = 1
data.raw.planet["aquilo"].surface_properties.rock = 0
]]
