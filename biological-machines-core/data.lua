--MODULES
if mods["biological-machines-hunger"]
or mods["biological-machines-industry"]
or mods["biological-machines-cloning"]
or mods["biological-machines-radioactive-tissue"]
or settings.startup["bm-alternative-nutrients-standalone"].value then
  require("prototypes.cultivation")
end

if mods["biological-machines-hunger"]
or mods["biological-machines-industry"]
or settings.startup["bm-alternative-nutrients-standalone"].value then
  require("prototypes.alternative-nutrients")
end

if mods["biological-machines-industry"]
or mods["biological-machines-planet-wit"]
or settings.startup["bm-scrapyard-standalone"].value then
  require("prototypes.scrapyard")
end

if mods["biological-machines-industry"]
or mods["biological-machines-planet-wit"] then
  require("prototypes.glass")
end

if mods["biological-machines-industry"]
or mods["biological-machines-planet-wit"]
or mods["biological-machines-planet-balack"] then
  require("prototypes.offshore-dump")
end
if mods["biological-machines-radioactive-tissue"]
or mods["biological-machines-planet-balack"]
or settings.startup["bm-reinforced-wall-standalone"].value then
  require("prototypes.reinforced-wall")
end

if mods["biological-machines-homeworld"]
or (mods["biological-machines-planet-balack"]
and settings.startup["bm-shattered-core"].value) then
  require("prototypes.empty-space")
end

if mods["biological-machines-modpack"]
or settings.startup["bm-bot-start-standalone"].value then
  require("prototypes.bot-start")
end



--FULL RESISTANCES
--add prototypes to table and they will be made invulnerable in the data-final-fixes stage
--example: table.insert(bm_add_full_resistences, data.raw["wall"]["stone-wall"])
bm_add_full_resistences = {}



--ALL SCIENCE
bm_all_sci_packs = util.table.deepcopy(data.raw.technology["research-productivity"].unit.ingredients)

if mods["biological-machines-radioactive-tissue"] then
  table.insert(bm_all_sci_packs, {"bm-nuclear-military-science-pack", 1})
end

if mods["biological-machines-planet-wit"] then
  table.insert(bm_all_sci_packs, {"bm-interstellar-science-pack", 1})
end

function BM_COPY_ALL_SCI_PACKS()
  return util.table.deepcopy(bm_all_sci_packs)
end
