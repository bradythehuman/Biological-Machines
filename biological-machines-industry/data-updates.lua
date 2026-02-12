local dh = require("__biological-machines-core__.data-helper")



require("prototypes.slag") --delayed from data stage for muluna compat



if settings.startup["bm-rocket-parts"].value then
  require("prototypes.rocket-parts")
end



--compat with any fluid burning mod including KS Power (Klonan), Gas Generator (ElAdamo) and/or Gas Boiler (ElAdamo)
data.raw.fluid["bm-seed-oil"].fuel_value = data.raw.fluid["heavy-oil"].fuel_value
data.raw.fluid["bm-seed-oil"].emissions_multiplier = data.raw.fluid["heavy-oil"].emissions_multiplier



if settings.startup["bm-boompuff-agriculture"].value then
  data.raw.item["bm-napalm-barrel"].default_import_location = "gleba"
  data.raw.item["bm-puff-gas-barrel"].default_import_location = "gleba"

  --compat with any fluid burning mod
  data.raw.fluid["bm-puff-gas"].fuel_value = data.raw.fluid["petroleum-gas"].fuel_value
  data.raw.fluid["bm-puff-gas"].emissions_multiplier = data.raw.fluid["petroleum-gas"].emissions_multiplier
end



if mods["crushing-industry"] and settings.startup["bm-crushing-industry-override"].value then
  data.raw.recipe["burner-crusher"].enabled = true
  dh.remove_recipe_unlock("steam-power", "burner-crusher")
  --[[
  if settings.startup["crushing-industry-ore"].value then
    dh.remove_recipe_unlock("engine", "electric-crusher")
  end
  ]]
end



  --RECYCLING
dh.recycle_to_ingredients("bm-steel-mix")
dh.recycle_to_ingredients("bm-glass-mix")

dh.recycle_to_self("grenade")
dh.recycle_to_self("bm-tar")

local slow_rocks = {
  "bm-slag", "metallic-asteroid-chunk", "carbonic-asteroid-chunk",
  "oxide-asteroid-chunk", "promethium-asteroid-chunk"
}
for i=1, #slow_rocks do
  data.raw["recipe"][slow_rocks[i] .. "-recycling"].energy_required = 0.5
end

data.raw["recipe"]["landfill-recycling"].energy_required = 1

--data.raw["recipe"]["sand-recycling"].energy_required = 0.03
--data.raw["recipe"]["potash-recycling"].energy_required = 0.03
