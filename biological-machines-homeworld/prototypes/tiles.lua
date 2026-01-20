local station_floor = util.table.deepcopy(data.raw["tile"]["space-platform-foundation"])
station_floor.name = "bm-station-floor"
station_floor.minable = nil
station_floor.autoplace = {
  order = "a",
  probability_expression = "bm_station_floor",
  force = "neutral",
},
data:extend({station_floor})
table.insert(bm_add_full_resistences, station_floor)
