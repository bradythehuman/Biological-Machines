require("prototypes.entities")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technologies")



if mods["biological-machines-industry"] then
  table.insert(data.raw.recipe["bm-branbalite-incubation"].results,
    {type = "item", name = "bm-potassium-nitrate", amount_min = 0, amount_max = 20, independent_probability = 0.1}
  )
end

if mods["biological-machines-planet-wit"] then
  table.insert(data.raw.recipe["bm-igneous-rock-incubation"].results,
    {type = "item", name = "bm-glass-shard", amount_min = 0, amount_max = 20, independent_probability = 0.1}
  )
end



data:extend({
  {
    type = "recipe-category",
    name = "bm-panglite-incubator"
  },
})
