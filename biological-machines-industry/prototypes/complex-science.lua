local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("production-science-pack", "rail")
--dh.add_ingredient("production-science-pack", "item", "assembling-machine-2", 1)
dh.add_ingredient("production-science-pack", "item", "chemical-plant", 1)



local agro_recipe = data.raw["recipe"]["agricultural-science-pack"]
agro_recipe.energy_required = 8
agro_recipe.ingredients = {
  {type = "item", name = "bioflux", amount = 2},
  {type = "item", name = "pentapod-egg", amount = 1},
  {type = "item", name = "nutrients", amount = 40}

}
agro_recipe.results = {{type = "item", name = "agricultural-science-pack", amount = 2}}



dh.add_ingredient("metallurgic-science-pack", "fluid", "bm-molten-glass", 50)



local em_sci_pack = data.raw["recipe"]["electromagnetic-science-pack"]
em_sci_pack.ingredients = {
  {type = "item", name = "supercapacitor", amount = 3},
  {type = "item", name = "quality-module", amount = 1},
  {type = "fluid", name = "electrolyte", amount = 25},
  {type = "fluid", name = "holmium-solution", amount = 25},
}
em_sci_pack.energy_required = 20
em_sci_pack.results = {{
  type = "item", name = "electromagnetic-science-pack", amount = 2
}}
