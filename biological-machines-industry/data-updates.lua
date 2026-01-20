local dh = require("__biological-machines-core__.data-helper")



if settings.startup["bm-rocket-parts"].value then
  require("prototypes.rocket-parts")
end



if settings.startup["bm-boompuff-agriculture"].value then
  data.raw.item["bm-napalm-barrel"].default_import_location = "gleba"
  data.raw.item["bm-puff-gas-barrel"].default_import_location = "gleba"
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
