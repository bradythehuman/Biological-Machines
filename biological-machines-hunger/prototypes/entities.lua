local hunger_interval = 60



data.raw["simple-entity"]["small-demolisher-corpse"].minable.results = {
  {type = "item", name = "tungsten-ore", amount_min = 1, amount_max = 20},
  {type = "item", name = "bm-demolisher-meat", amount_min = 1, amount_max = 5}
}
data.raw["simple-entity"]["medium-demolisher-corpse"].minable.results = {
  {type = "item", name = "tungsten-ore", amount_min = 1, amount_max = 40},
  {type = "item", name = "bm-demolisher-meat", amount_min = 1, amount_max = 10}
}
data.raw["simple-entity"]["big-demolisher-corpse"].minable.results = {
  {type = "item", name = "tungsten-ore", amount_min = 1, amount_max = 60},
  {type = "item", name = "bm-demolisher-meat", amount_min = 1, amount_max = 15}
}




table.insert(data.raw["tree"]["stingfrond"].minable.results, {type = "item", name = "bm-stingfrond", amount = 8})
local stingfrond = util.table.deepcopy(data.raw["tree"]["stingfrond"])
stingfrond.type = "plant"
stingfrond.name = "bm-stingfrond-plant"
stingfrond.surface_conditions = { {property = "pressure", min = 2000, max = 2000}}
stingfrond.autoplace = {
  probability_expression = 0,
  tile_restriction = {"midland-turquoise-bark", "midland-turquoise-bark-2"}
}
stingfrond.growth_ticks = 10 * minute
stingfrond.harvest_emissions = {spores = 15}
stingfrond.created_effect = nil
data:extend({stingfrond})



data:extend({
  {
    type = "sticker",
    name = "bm-starving",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = hunger_interval,
    --damage_per_tick = {amount = 0.1, type = "physical"},
    target_movement_modifier = 0.85
  },
  {
    type = "sticker",
    name = "bm-malnourished",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = hunger_interval,
    target_movement_modifier = 0.85,
    target_movement_max = 2.5
  },
  {
    type = "sticker",
    name = "bm-well-nourished",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = hunger_interval,
    damage_per_tick = {amount = -0.05, type = "physical"}
  },
  {
    type = "sticker",
    name = "bm-well-nourished-2",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = hunger_interval,
    damage_per_tick = {amount = -0.1, type = "physical"}
  },
  {
    type = "sticker",
    name = "bm-energized",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = hunger_interval,
    target_movement_modifier = 1.15
  },
  {
    type = "sticker",
    name = "bm-energized-2",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = hunger_interval,
    target_movement_modifier = 1.30
  },
  {
    type = "sticker",
    name = "bm-artificial-biology",
    flags = {"not-on-map"},
    single_particle = true,
    duration_in_ticks = hunger_interval,
    damage_per_tick = {amount = -0.05, type = "physical"},
    target_movement_modifier = 1.15
  }
})
