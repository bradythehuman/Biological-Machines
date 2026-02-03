function BM_STANDALONE_SETTING_OVERRIDE(setting_name)
  local setting_prototype = data.raw["bool-setting"][setting_name]
  setting_prototype.hidden = true
  setting_prototype.forced_value = true
end


data:extend({
  {
    type = "bool-setting",
    name = "bm-bot-start-standalone",
    setting_type = "startup",
    default_value = false
  },
  {
    type = "bool-setting",
    name = "bm-alternative-nutrients-standalone",
    setting_type = "startup",
    default_value = false
  },
  {
    type = "bool-setting",
    name = "bm-scrapyard-standalone",
    setting_type = "startup",
    default_value = false
  },
  {
    type = "bool-setting",
    name = "bm-reinforced-wall-standalone",
    setting_type = "startup",
    default_value = false
  },
  {
    type = "int-setting",
    name = "bm-berry-yield",
    setting_type = "startup",
    default_value = 10,
    minimum_value = 2,
    maximum_value = 50,
  },
})
