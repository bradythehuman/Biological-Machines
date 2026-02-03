local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_require("promethium-belts", "bm-promethium-belts-override", "prototypes.balack-x-promethium-belts-updates")

dh.mod_override_require("BuggisNuclearBots", "bm-nuclear-bots-override", "prototypes.balack-x-nuclear-bots-updates")



data.raw.recipe["bm-ai-control-unit-active-recycling"].results = data.raw.recipe["bm-ai-control-unit-recycling"].results
