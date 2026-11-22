local dh = require("__biological-machines-core__.data-helper")



--decapsulization moved to data-updates for compatibility with k2so
local capsules = {"raw-fish", "yumako", "yumako-mash", "jellynut", "jelly", "bioflux"}
for _, name in pairs(capsules) do
  local item = data.raw["capsule"][name]
  data.raw["capsule"][name] = nil
  item.type = "item"
  data:extend({item})
end



if mods["lignumis"] then  --Lignumis compat
  dh.remove_prereq("bm-food-processing", "agriculture")
end
