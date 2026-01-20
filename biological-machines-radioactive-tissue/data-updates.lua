if mods["ironclad-gunboat-and-mortar-turret-fork"] and settings.startup["bm-ironclad-fork-override"].value then
  require("prototypes.tissue-x-ironclad-fork-updates")
end

if mods["ArmouredBiters"] then
  require("prototypes.tissue-x-armored-biters-updates")
end
