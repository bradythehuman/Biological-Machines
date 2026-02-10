local dh = require("__biological-machines-core__.data-helper")



--ENTITY
data.raw["assembling-machine"]["crusher"].surface_conditions = nil



--ITEM
local crusher = data.raw["item"]["crusher"]
crusher.subgroup = "smelting-machine"
crusher.order = "d[recycler]-a"



--RECIPE
data.raw["recipe"]["crusher"].ingredients = {
  {type = "item", name = "iron-plate", amount = 5},
  {type = "item", name = "iron-gear-wheel", amount = 10},
  {type = "item", name = "bm-piston", amount = 5},
  {type = "item", name = "electronic-circuit", amount = 2}
}

data.raw["recipe"]["bm-stone-crushing"].enabled = false
data.raw["recipe"]["bm-lime"].enabled = false
data.raw["recipe"]["bm-glass-mix"].enabled = false
data.raw["recipe"]["bm-glass-plate"].enabled = false



--TECH
dh.remove_recipe_unlock("space-platform", "crusher")
dh.add_recipe_unlock("steam-power", "crusher")

dh.add_recipe_unlock("steam-power", "bm-stone-crushing")
dh.add_recipe_unlock("steam-power", "bm-lime")
dh.add_recipe_unlock("steam-power", "bm-glass-mix")
dh.add_recipe_unlock("steam-power", "bm-glass-plate")




--remove stone crushing and glass techs, add all unlocks to steam power
--add glass to lab, agri tower, solar panel, night vison

--[[
data.raw["technology"]["steel-processing"].prerequisites = {"bm-stone-crushing"}

dh.add_prereq("concrete", "bm-stone-crushing")

data.raw["technology"]["lamp"].prerequisites = {"bm-glass"}

dh.add_prereq("oil-processing", "bm-glass")
dh.add_prereq("bm-alcohol", "bm-glass")

data:extend({
  {
    type = "technology",
    name = "bm-stone-crushing",
    icon = "__biological-machines-industry__/graphics/stone-crushing.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "crusher"},
      --{type = "unlock-recipe", recipe = "sedimentary-stone-crushing"},
      {type = "unlock-recipe", recipe = "bm-slag-crushing"},
      {type = "unlock-recipe", recipe = "bm-stone-crushing"},
      {type = "unlock-recipe", recipe = "bm-lime"},
    },
    prerequisites = {"automation-science-pack"},
    unit = {
      count = 25,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 15
    }
  },
  {
    type = "technology",
    name = "bm-glass",
    icon = "__biological-machines-core__/graphics/glass-plate.png",
    icon_size = 64,
    effects = {
      {type = "unlock-recipe", recipe = "bm-glass-mix"},
      {type = "unlock-recipe", recipe = "bm-glass-plate"}
    },
    prerequisites = {"bm-stone-crushing"},
    unit = {
      count = 25,
      ingredients = {{"automation-science-pack", 1}},
      time = 15
    }
  },
})
]]
