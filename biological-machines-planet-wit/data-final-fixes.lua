local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_require("panglia_planet", "bm-panglia-override", "prototypes.wit-x-panglia-final-fixes")



table.insert(data.raw["lab"]["lab"].inputs, "bm-interstellar-science-pack")
