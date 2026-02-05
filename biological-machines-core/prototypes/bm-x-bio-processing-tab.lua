--same condition as cultivation
if mods["biological-machines-hunger"]
or mods["biological-machines-industry"]
or mods["biological-machines-cloning"]
or mods["biological-machines-radioactive-tissue"]
or settings.startup["bm-alternative-nutrients-standalone"].value then
  data.raw["item-subgroup"]["bm-cultivation"].group = "bioprocessing"
  data.raw["item-subgroup"]["bm-biological-fluid-recipes"].group = "bioprocessing"
end

if mods["biological-machines-hunger"]
or mods["biological-machines-industry"]
or settings.startup["bm-alternative-nutrients-standalone"].value then
  data.raw["item-subgroup"]["bm-nutrients"].group = "bioprocessing"
  data.raw["item-subgroup"]["nauvis-agriculture"].order = "lz-a"
end

if mods["biological-machines-hunger"] then
  data.raw["item-subgroup"]["bm-processed-food"].group = "bioprocessing"
  data.raw["item-subgroup"]["bm-processed-food"].order = "z"
end

if mods["biological-machines-industry"] then
  data.raw["item-subgroup"]["bm-pyrolysis"].group = "bioprocessing"
end
