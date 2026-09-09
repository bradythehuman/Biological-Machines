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
    name = "bm_station_y_mirrored",
    --expression = "y - 35",
    expression = "abs(y + 35)",
  },
  {
    type = "noise-expression",
    name = "bm_station_x_offset",
    expression = "x + 50",
  },
  {
    type = "noise-expression",
    name = "bm_station_x_repeating",
    expression = "abs(bm_station_x_offset) %% 101",
  },
  --FLOOR
  {
    type = "noise-expression",
    name = "bm_station_floor",
    expression = "(bm_station_y_mirrored < 61)",
  },
  {
    type = "noise-expression",
    name = "bm_station_concrete",
    expression = "bm_station_y_mirrored < 5",
  },
  {
    type = "noise-expression",
    name = "bm_station_hazard_concrete",
    expression = "(bm_station_x_repeating > 47) * (bm_station_x_repeating < 55)\z
                  * ((bm_station_y_mirrored < 9) - bm_station_concrete)",
  },
  --WALL
  {
    type = "noise-expression",
    name = "bm_station_middle",
    expression = "(bm_station_y_mirrored < 10)",
  },
  {
    type = "noise-expression",
    name = "bm_station_middle_hallway_main",
    expression = "bm_station_y_mirrored < 4",
  },
  {
    type = "noise-expression",
    name = "bm_station_middle_hallway_door",
    expression = "(bm_station_x_repeating > 47) * (bm_station_x_repeating < 55)\z
                  * (bm_station_middle - bm_station_middle_hallway_main)",
  },
  {
    type = "noise-expression",
    name = "bm_station_middle_hallway",
    expression = "bm_station_middle_hallway_main + bm_station_middle_hallway_door",
  },
  {
    type = "noise-expression",
    name = "bm_station_middle_filling_1",
    expression = "(bm_station_y_mirrored == 7) - ((bm_station_x_repeating > 45) * (bm_station_x_repeating < 57))",
  },
  {
    type = "noise-expression",
    name = "bm_station_middle_filling_2",
    expression = "(bm_station_y_mirrored == 6) - ((bm_station_x_repeating > 45) * (bm_station_x_repeating < 57))",
  },
  {
    type = "noise-expression",
    name = "bm_station_edge",
    expression = "bm_station_y_mirrored == 60",
  },
  {
    type = "noise-expression",
    name = "bm_station_dividers",
    expression = "(bm_station_x_repeating == 0) * bm_station_floor",
  },
  {
    type = "noise-expression",
    name = "bm_station_wall",
    expression = "max(bm_station_middle, bm_station_edge, bm_station_dividers)\z
                  - max(bm_station_middle_hallway, bm_station_middle_filling_1, bm_station_middle_filling_2)",
  },
  --CLUTTER
  {
    type = "noise-expression",
    name = "bm_station_clutter_free_area",
    expression = "10 * max(0, bm_station_middle, bm_station_edge, bm_station_dividers, 1.1 - distance / 32)",
    --expression = "aux_basic - max(bm_station_middle, bm_station_edge, bm_station_dividers)",
  },
  {
    type = "noise-expression",
    name = "bm_station_clutter",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 2222,\z
                                    octaves = 8,\z
                                    persistence = 0.95,\z
                                    input_scale = 1,\z
                                    output_scale = 0.05}\z
                              - bm_station_clutter_free_area",
  },
  {
    type = "noise-expression",
    name = "bm_station_market_spawner",
    expression = "0.0075 * bm_station_clutter",
  },
  {
    type = "noise-expression",
    name = "bm_station_recycler",
    expression = "0.015 * bm_station_clutter",
  },
  {
    type = "noise-expression",
    name = "bm_station_assembler",
    expression = "0.0225 * bm_station_clutter",
  },
  {
    type = "noise-expression",
    name = "bm_station_market",
    expression = "0.05 * bm_station_clutter",
  },
  {
    type = "noise-expression",
    name = "bm_station_steel_chest",
    expression = "0.95 * bm_station_clutter",
  },
  {
    type = "noise-expression",
    name = "bm_station_iron_chest",
    expression = "bm_station_clutter",
  },
  {
    type = "noise-expression",
    name = "bm_station_crash",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 3333,\z
                                    octaves = 2,\z
                                    persistence = 0.5,\z
                                    input_scale = 1,\z
                                    output_scale = 0.001}\z
                              - bm_station_clutter_free_area",
  },
  {
    type = "noise-expression",
    name = "bm_station_pipe",
    expression = "(0.19 + aux_basic) * bm_station_middle_filling_1",
  },
  {
    type = "noise-expression",
    name = "bm_station_heat_pipe",
    expression = "(1.30 - aux_basic) * bm_station_middle_filling_2",
  },

  --DECORATIVES
  {
    type = "noise-expression",
    name = "bm_station_decorative_free_area",
    expression = "10 * max(0, bm_station_middle, bm_station_edge)",
  },
  {
    type = "noise-expression",
    name = "bm_station_decorative",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 1111,\z
                                    octaves = 4,\z
                                    persistence = 0.9,\z
                                    input_scale = 1,\z
                                    output_scale = 1}\z
                        - bm_station_decorative_free_area",
  },

  --UNITS
  {
    type = "noise-expression",
    name = "bm_station_bot",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 4444,\z
                                    octaves = 4,\z
                                    persistence = 0.9,\z
                                    input_scale = 1,\z
                                    output_scale = 0.035}\z
                  * bm_station_middle_hallway_main - max(0, 1.1 - abs(x) / 32)",
  },
  {
    type = "noise-expression",
    name = "bm_station_biter_free_area",
    expression = "10 * max(0, (bm_station_y_mirrored < 20), bm_station_edge, bm_station_dividers, 1.1 - distance / 32)",
    --expression = "aux_basic - max(bm_station_middle, bm_station_edge, bm_station_dividers)",
  },
  {
    type = "noise-expression",
    name = "bm_station_biter",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 5555,\z
                                    octaves = 4,\z
                                    persistence = 0.9,\z
                                    input_scale = 1,\z
                                    output_scale = 0.001}\z
                  - max(0, bm_station_biter_free_area, 1.1 - distance / 64)",
  },
})
