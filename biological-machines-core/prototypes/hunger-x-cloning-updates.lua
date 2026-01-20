local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("bm-clone", "bioflux")
dh.add_ingredient("bm-clone", "item", "bm-fluroflux", 25)

dh.remove_ingredient("bm-suspension-fluid", "bioflux")
dh.add_ingredient("bm-suspension-fluid", "item", "bm-fluroflux", 5)



dh.add_prereq("bm-cloning", "bm-fluroflux")
