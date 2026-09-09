--same condition as cultivation
if mods["biological-machines-hunger"]
or mods["biological-machines-industry"]
or mods["biological-machines-cloning"]
or mods["biological-machines-radioactive-tissue"]
or mods["biological-machines-alternative-nutrients"] then
  data.raw["item-subgroup"]["bm-cultivation"].group = "bioprocessing"
  data.raw["item-subgroup"]["bm-biological-fluid-recipes"].group = "bioprocessing"
end

if mods["biological-machines-alternative-nutrients"] then
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

if mods["biological-machines-planet-balack"] then
  data:extend({{
    type = "item-subgroup",
    name = "bm-balack-bioprocesses",
    group = "bioprocessing",
    order = "y"
  }})

  local balack_bio = {
    "bm-oil-sludge-seperation", "bm-advanced-oil-sludge-seperation",
    "bm-bio-cube-ooze", "bm-radiation-sheilding-from-ooze", "bm-bioflux-from-ooze",
    "bm-uranium-enrichment-with-ooze", "bm-napalm-from-ooze",
  }
  for _, recipe_name in pairs(balack_bio) do
    local recipe_prototype = data.raw.recipe[recipe_name]
    if recipe_prototype then
      recipe_prototype.subgroup = "bm-balack-bioprocesses"
    end
  end

  data.raw.item["bm-bio-cube-ooze"].subgroup = "bm-balack-bioprocesses"
end
