local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_setting("promethium-belts", "bm-promethium-belts-override")

if mods["BuggisNuclearBots"] then
  data.raw["int-setting"]["robot-cargo-mul"].default_value = 5

  data:extend({
    {
      type = "bool-setting",
      name = "bm-nuclear-bots-override",
      setting_type = "startup",
      default_value = true
    },
  })
end



data:extend({
  {
    type = "bool-setting",
    name = "bm-armored-biters-override",
    setting_type = "startup",
    default_value = true,
  },
  {
    type = "bool-setting",
    name = "bm-shattered-core",
    setting_type = "startup",
    default_value = true,
  },
  {
    type = "double-setting",
    name = "bm-cube-speed",
    setting_type = "startup",
    minimum_value = 0.01,
    maximum_value = 100,
    default_value = 1,
  },
  {
    type = "int-setting",
    name = "bm-cube-pollution",
    setting_type = "startup",
    minimum_value = 100,
    maximum_value = 1000000,
    default_value = 10000,
  },
})



if mods["skewer_shattered_planet"] then
  local setting_prototype = data.raw["bool-setting"]["bm-shattered-core"]
  setting_prototype.hidden = true
  setting_prototype.forced_value = false
end
