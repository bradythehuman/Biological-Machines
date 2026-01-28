--MODULE UPDATES
if mods["biological-machines-hunger"]
or mods["biological-machines-industry"]
or settings.startup["bm-alternative-nutrients-standalone"].value then
  require("prototypes.alternative-nutrients-updates")
end

if mods["biological-machines-industry"]
or mods["biological-machines-planet-wit"] then
  require("prototypes.offshore-dump-updates")
end



--COMPATABILITY UPDATES
if mods["biological-machines-hunger"]
and mods["biological-machines-planet-wit"] then
  require("prototypes.hunger-x-wit-updates")
end

if mods["biological-machines-hunger"]
and mods["biological-machines-radioactive-tissue"] then
  require("prototypes.hunger-x-tissue-updates")
end

if mods["biological-machines-hunger"]
and mods["biological-machines-cloning"] then
  require("prototypes.hunger-x-cloning-updates")
end

if mods["biological-machines-industry"]
and mods["biological-machines-planet-wit"] then
  require("prototypes.industry-x-wit-updates")
end

if mods["biological-machines-industry"]
and mods["biological-machines-radioactive-tissue"] then
  require("prototypes.industry-x-tissue-updates")
end

if mods["biological-machines-planet-balack"]
and mods["biological-machines-hunger"] then
  require("prototypes.hunger-x-balack-updates")
end

if mods["biological-machines-planet-balack"]
and mods["biological-machines-radioactive-tissue"] then
  require("prototypes.balack-x-tissue-updates")
end

if mods["biological-machines-planet-balack"]
and mods["biological-machines-planet-wit"] then
  require("prototypes.balack-x-wit-updates")
end

if mods["biological-machines-planet-balack"]
and mods["biological-machines-industry"] then
  require("prototypes.balack-x-industry-updates")
end

if mods["biological-machines-radioactive-tissue"]
and mods["biological-machines-planet-wit"] then
  require("prototypes.wit-x-tissue-updates")
end

if mods["biological-machines-planet-balack"]
and mods["biological-machines-homeworld"] then
  require("prototypes.balack-x-homeworld-updates")
end
