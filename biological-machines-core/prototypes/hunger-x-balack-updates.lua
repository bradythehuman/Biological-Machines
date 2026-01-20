local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("bm-mech-armor-mk2", "biochamber")
dh.add_ingredient("bm-mech-armor-mk2", "item", "bm-artificial-organs", 1)

dh.add_prereq("bm-mech-armor-mk2", "bm-artificial-organs")
