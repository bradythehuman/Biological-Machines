local dh = require("__biological-machines-core__.data-helper")



dh.add_ingredient("aai-signal-sender", "item", "bm-helium-power-cell", 20)

dh.remove_ingredient("aai-signal-receiver", "copper-plate")
dh.add_ingredient("aai-signal-receiver", "item", "low-density-structure", 30)

data.raw["item"]["aai-signal-receiver"].weight = 200 * kg
