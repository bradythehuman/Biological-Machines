data:extend({
  --OFFSET
  {
    type = "noise-expression",
    name = "bm_station_y_offset",
    --expression = "y - 35",
    expression = "y + 35",
  },
  {
    type = "noise-expression",
    name = "bm_station_x_offset",
    expression = "x + 50",
  },
  --FLOOR
  {
    type = "noise-expression",
    name = "bm_station_floor",
    expression = "2 * (bm_station_y_offset < 61) * (bm_station_y_offset > -61)",
  },
  --WALL
  {
    type = "noise-expression",
    name = "bm_station_middle",
    expression = "(bm_station_y_offset < 11) * (bm_station_y_offset > 1) + (bm_station_y_offset < -1) * (bm_station_y_offset > -11)",
  },
  {
    type = "noise-expression",
    name = "bm_station_edge",
    expression = "(bm_station_y_offset == 60) + (bm_station_y_offset == -60)",
  },
  {
    type = "noise-expression",
    name = "bm_station_dividers",
    expression = "((bm_station_x_offset %% 101) == 0) * bm_station_floor",
  },
  {
    type = "noise-expression",
    name = "bm_station_wall",
    expression = "bm_station_middle + bm_station_edge + bm_station_dividers",
  },
  --MARKET
  {
    type = "noise-expression",
    name = "bm_station_markets",
    expression = "((x %% 101) == 0) * ((y == -20) + (y == -50))",
    --expression = "(x == 0) * (y == -20)",
  },
})
