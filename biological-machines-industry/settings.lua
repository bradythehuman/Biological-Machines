local dh = require("__biological-machines-core__.data-helper")

dh.mod_override_setting("slipstacks", "bm-slipstack-agriculture-override")

dh.mod_override_setting("LargerLamps-2_0", "bm-larger-lamps-override")

dh.mod_override_setting("snouz_better_substation", "bm-snouz-substation-override")

dh.mod_override_setting("shield-projector", "bm-shield-projector-override")

dh.mod_override_setting("pollution-detector", "bm-pollution-detector-override")

dh.mod_override_setting("big-wooden-pole", "bm-big-wooden-pole-override")

if mods["aai-loaders"] then
  local mode_setting = data.raw["string-setting"]["aai-loaders-mode"]
  mode_setting.default_value = "expensive"

  local recipe_setting = data.raw["string-setting"]["aai-loaders-lubricant-recipe"]
  recipe_setting.default_value = "disabled"
  recipe_setting.allowed_values = {"enabled", "disabled"}

  data:extend({
    {
      type = "bool-setting",
      name = "bm-aai-loader-override",
      setting_type = "startup",
      default_value = true
    },
  })
end



data:extend({
  {
    type = "bool-setting",
    name = "bm-deep-crude-oil",
    setting_type = "startup",
    default_value = true
  },
  {
    type = "bool-setting",
    name = "bm-rocket-parts",
    setting_type = "startup",
    default_value = true
  },
  {
    type = "bool-setting",
    name = "bm-complex-science",
    setting_type = "startup",
    default_value = true
  },
  {
    type = "bool-setting",
    name = "bm-boompuff-agriculture",
    setting_type = "startup",
    default_value = true
  },
})
