local dh = require("__biological-machines-core__.data-helper")



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



--table which is used byslag.lua in the data-updates stage
BM_ADD_SLAG = {
  {name = "iron-plate", prob = 0.01},
  {name = "copper-plate", prob = 0.01},
  {name = "molten-iron", prob = 0.5},
  {name = "molten-copper", prob = 0.5},
  {name = "tungsten-plate", prob = 0.05},
}



if mods["crushing-industry"] then
  data.raw.recipe["bm-stone-crushing"].category = "basic-crushing"
  data.raw.recipe["bm-slag-crushing"].category = "basic-crushing"
  
  if settings.startup["bm-crushing-industry-override"].value then
    require("prototypes.industry-x-crushing-industry")
  end
else
  require("prototypes.early-crusher")
end



if mods["Krastorio2-spaced-out"] then
  require("prototypes.industry-x-k2so") --mandatory changes so k2so loads
end

if mods["Paracelsin"] then
  require("prototypes.industry-x-paracelsin") --mandatory changes so paracelsin loads
end

if mods["aai-loaders"] and settings.startup["bm-aai-loader-override"].value
and settings.startup["aai-loaders-mode"].value ~= "graphics-only" then
  require("prototypes.industry-x-aai-loader")
end

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
