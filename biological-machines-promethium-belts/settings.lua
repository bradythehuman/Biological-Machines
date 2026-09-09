data:extend({
  {
    type = "bool-setting",
    name = "promethium-belt-surface-vulcanus",
    setting_type = "startup",
    default_value = false,
  },
  {
    type = "int-setting",
    name = "promethium-belt-science-count",
    setting_type = "startup",
    default_value = 1000,
    minimum_value = 500,
    maximum_value = 50000,
  },
  {
    type = "int-setting",
    name = "promethium-belt-speed",
    setting_type = "startup",
    default_value = 90,
    allowed_values = {75, 90, 105, 120}
  },
})
