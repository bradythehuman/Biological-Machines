local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("bm-ai-control-unit", "raw-fish")
dh.remove_ingredient("bm-ai-control-unit", "bm-radioactive-tissue")
dh.remove_ingredient("bm-ai-control-unit", "quantum-processor")

dh.add_ingredient("bm-ai-control-unit", "item", "panglia_sentient_processor", 1)

dh.add_prereq("bm-ai-control-unit", "panglia_sentient_processor")
