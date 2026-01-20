local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_setting("PersonalTeslaDefenseEquipment", "bm-tesla-equipment-override")

if mods["PersonalTeslaDefenseEquipment"] then
  data.raw["string-setting"]["PeronsalTeslaDefenseSetting-grid_size"].default_value = "3X3"
end

dh.mod_override_setting("aai-signal-transmission", "bm-aai-signal-override")

dh.mod_override_setting("reach-equipment", "bm-reach-equipment-override")

dh.mod_override_setting("Repair_Turret", "bm-repair-turret-override")



data:extend({
  {
    type = "bool-setting",
    name = "bm-advanced-solar-panels",
    setting_type = "startup",
    default_value = true,
  },
  {
    type = "bool-setting",
    name = "bm-combat-robot-tweaks",
    setting_type = "startup",
    default_value = true,
  },
  {
    type = "bool-setting",
    name = "bm-early-logistics-system",
    setting_type = "startup",
    default_value = true,
  },
})
