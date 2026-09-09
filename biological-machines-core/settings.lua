local dh = require("__biological-machines-core__.data-helper")



dh.mod_override_setting("Moshine", "bm-moshine-override")
dh.mod_override_setting("panglia_planet", "bm-panglia-override")



data:extend({
  {
    type = "bool-setting",
    name = "bm-bot-start",
    setting_type = "startup",
    default_value = false
  },
})
