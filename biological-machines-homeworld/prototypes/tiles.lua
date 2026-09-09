data.raw["tile"]["refined-concrete"].autoplace = {
  order = "b",
  force = "player",
  probability_expression = "3 * bm_station_concrete",
}
data.raw["tile"]["refined-hazard-concrete-left"].autoplace = {
  order = "b",
  force = "player",
  probability_expression = "3 * bm_station_hazard_concrete",
}



local station_floor = util.table.deepcopy(data.raw["tile"]["space-platform-foundation"])
station_floor.name = "bm-station-floor"
station_floor.minable = nil
--station_floor.layer = 60
station_floor.bound_decoratives = nil
station_floor.allows_being_covered = true
station_floor.autoplace = {
  order = "a",
  probability_expression = "2 * bm_station_floor",
  --force = "neutral",
},
data:extend({station_floor})
table.insert(bm_add_full_resistences, station_floor)
