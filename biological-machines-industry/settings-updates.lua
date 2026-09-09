if mods["crushing-industry"] then
  --data.raw["bool-setting"]["crushing-industry-space-crusher"].default_value = false
  data.raw["bool-setting"]["crushing-industry-space-crusher-quality"].default_value = false
  data.raw["bool-setting"]["crushing-industry-smelting-productivity"].default_value = false
  data.raw["bool-setting"]["crushing-industry-optical-fiber"].default_value = false

  data.raw["bool-setting"]["crushing-industry-concrete-mix"].forced_value = false
  data.raw["bool-setting"]["crushing-industry-concrete-mix"].hidden = true

  data.raw["int-setting"]["crushing-industry-concrete-spoil-amount"].hidden = true
  data.raw["string-setting"]["crushing-industry-concrete-machine-ignorelist"].hidden = true

  data.raw["bool-setting"]["crushing-industry-sandfill"].default_value = false

  --[[
  if mods["Krastorio2-spaced-out"] then
    data.raw["bool-setting"]["crushing-industry-k2"].forced_value = false
    data.raw["bool-setting"]["crushing-industry-k2"].hidden = true
  end
  ]]

  if mods["crushing-industry-tweaks"] or mods["skewer_planet_vesta"] then
    data.raw["bool-setting"]["bm-crushing-industry-override"].forced_value = false
    data.raw["bool-setting"]["bm-crushing-industry-override"].hidden = true
  elseif mods["Krastorio2-spaced-out"] then
    data.raw["bool-setting"]["crushing-industry-k2"].default_value = false
    data.raw["bool-setting"]["crushing-industry-k2"].localised_description = {"mod-setting-description.bm-crushing-industry-k2"}
  end
end
