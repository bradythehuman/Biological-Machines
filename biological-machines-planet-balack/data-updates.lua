local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_require("panglia_planet", "bm-panglia-override", "prototypes.balack-x-panglia-updates")

--cleans up from balack-x-tissue and balack-x-panglia
dh.recycle_to_ingredients("bm-ai-control-unit")

data.raw.recipe["bm-ai-control-unit-active-recycling"].results = data.raw.recipe["bm-ai-control-unit-recycling"].results

if data.raw.item["bm-ai-control-unit-trained"] then
  data.raw.recipe["bm-ai-control-unit-trained-recycling"].results = data.raw.recipe["bm-ai-control-unit-recycling"].results
end



dh.mod_override_require("biological-machines-promethium-belts", "bm-promethium-belts-override", "prototypes.balack-x-promethium-belts-updates")

dh.mod_override_require("BuggisNuclearBots", "bm-nuclear-bots-override", "prototypes.balack-x-nuclear-bots-updates")



data.raw.recipe["bm-ai-control-unit-active-recycling"].results = data.raw.recipe["bm-ai-control-unit-recycling"].results
