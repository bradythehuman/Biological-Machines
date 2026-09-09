local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("thinking-brain", "processing-unit")
dh.remove_ingredient("thinking-brain", "low-density-structure")
dh.add_ingredient("thinking-brain", "item", "bm-robotics-facility", 1)
dh.add_ingredient("thinking-brain", "item", "bm-glass-plate", 20)
