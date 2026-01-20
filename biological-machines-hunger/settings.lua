data:extend({
  {
    type = "double-setting",
    name = "bm-sat-per-sec",
    setting_type = "runtime-global",
    minimum_value = 0.01,
    maximum_value = 100,
    default_value = 1
  },
  {
    type = "int-setting",
    name = "bm-injury-sat-scalar",
    setting_type = "runtime-global",
    minimum_value = 1,
    maximum_value = 100,
    default_value = 2
  },
  {
    type = "int-setting",
    name = "bm-pref-count",
    setting_type = "runtime-per-user",
    minimum_value = 1,
    maximum_value = 9,
    default_value = 3
  },
  {
    type = "bool-setting",
    name = "bm-show-widget",
    setting_type = "runtime-per-user",
    default_value = true
  },
})
