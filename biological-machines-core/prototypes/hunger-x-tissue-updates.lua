local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("bm-artificial-organs", "biter-egg")
dh.add_ingredient("bm-artificial-organs", "item", "bm-radioactive-tissue", 5)

dh.remove_prereq("bm-artificial-organs", "biter-egg-handling")
dh.add_prereq("bm-artificial-organs", "bm-radioactive-tissue-cultivation")
table.insert(data.raw["technology"]["bm-artificial-organs"].unit.ingredients,
{"bm-nuclear-military-science-pack", 1})
