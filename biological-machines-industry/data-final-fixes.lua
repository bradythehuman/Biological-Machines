local dh = require("__biological-machines-core__.data-helper")



if mods["foliax"] then
  require("prototypes.industry-x-foliax") --mandatory changes so foliax loads
end



if mods["crushing-industry"]
and settings.startup["bm-crushing-industry-override"].value
and settings.startup["crushing-industry-coal"].value then
  data.raw.recipe["crushed-grenade"].hidden = true
  dh.remove_recipe_unlock("oil-processing", "crushed-grenade")
end
