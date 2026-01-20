local dh = require("__biological-machines-core__.data-helper")



--non explosive bombs unlock with unique ammo ingredient
dh.remove_recipe_unlock("military-3", "mortar-poison-bomb")
dh.add_recipe_unlock("bm-poison", "mortar-poison-bomb")

dh.remove_recipe_unlock("ironclad", "mortar-fire-bomb")
dh.add_recipe_unlock("flamethrower", "mortar-fire-bomb")
