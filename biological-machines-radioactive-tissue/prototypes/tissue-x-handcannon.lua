local handcannon_tech = data.raw["technology"]["handcannon"]
handcannon_tech.prerequisites = {"bm-nuclear-military-science-pack", "utility-science-pack"}
handcannon_tech.unit.ingredients = {
  {"automation-science-pack", 1},
  {"logistic-science-pack", 1},
  {"chemical-science-pack", 1},
  {"utility-science-pack", 1},
  {"military-science-pack", 1},
  {"bm-nuclear-military-science-pack", 1},
}
