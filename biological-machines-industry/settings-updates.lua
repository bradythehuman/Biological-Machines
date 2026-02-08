if mods["est-tiny-storage-tank"] then
  data.raw["string-setting"]["tiny-storage-tank-enable"].default_value = "inline-variant"
  data.raw["int-setting"]["tiny-storage-tank-volume"].default_value = 1000
end

if mods["crushing-industry"] then
  data.raw["bool-setting"]["crushing-industry-space-crusher"].default_value = false
  data.raw["bool-setting"]["crushing-industry-space-crusher-quality"].default_value = false
  data.raw["bool-setting"]["crushing-industry-smelting-productivity"].default_value = false

  local force_value = {
    ["crushing-industry-glass"] = false,
    ["crushing-industry-concrete-mix"] = false,
    ["crushing-industry-byproducts"] = false,
  }
  for setting_name, setting_value in pairs(force_value) do
    local force_setting = data.raw["bool-setting"][setting_name]
    force_setting.forced_value = setting_value
    force_setting.hidden = true
  end

  data.raw["int-setting"]["crushing-industry-concrete-spoil-amount"].hidden = true
  data.raw["string-setting"]["crushing-industry-concrete-machine-ignorelist"].hidden = true
end
