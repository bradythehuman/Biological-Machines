data:extend({
  {
    type = "noise-expression",
    name = "wit_scale_multiplier",
    expression = "slider_rescale(control:bm_wit_volcanism:frequency, 3)"
  },

  -----------------------------------------------------TILE RANGES
  {
    type = "noise-expression",
    name ="wit_ash_cracks_range",
    -- volcano peak circle is expected to be 1020 to 1030, The cliff is at 1020
    expression = "wit_mountains_biome_full_pre_volcano"
  },
  {
   type = "noise-expression",
   name = "wit_ash_flats_range",
   expression = "wit_ashlands_biome_full"
  },
  {
    type = "noise-expression",
    name = "wit_ash_light_range",
    expression = "2 * (wit_ashlands_biome - 0.5)\z
                  - 1.5 * (moisture - 0.6)"
  },
  {
    type = "noise-expression",
    name = "wit_ash_dark_range",
    expression = "min(1, 4 * (wit_mountains_biome - 0.25))\z
                  -1.5 * (aux - 0.25)\z"
  },

  -------------------------------------------------ELEVATION
  {
    type = "noise-expression",
    name = "wit_elevation_offset",
    expression = "700"
  },
  {
    --functions more like a cliffiness multiplier as all the mountain tiles have it offset.
    type = "noise-expression",
    name = "wit_mountains_elevation_multiplier",
    expression = 1.5
  },
  {
    type = "noise-function",
    name = "wit_plasma",
    parameters = {"seed", "scale", "scale2", "magnitude1", "magnitude2"},
    expression = "abs(basis_noise{x = x,\z
                                  y = y,\z
                                  seed0 = map_seed,\z
                                  seed1 = 12643,\z
                                  input_scale = 1 / 50 / scale,\z
                                  output_scale = magnitude1}\z
                      - basis_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 13423 + seed,\z
                                    input_scale = 1 / 50 / scale2,\z
                                    output_scale = magnitude2})"
  },
  {
    type = "noise-expression",
    name = "crater_plasma",
    expression = "wit_plasma(102, 2.5, 10, 125, 625)"
  },
  {
    type = "noise-expression",
    name = "crater_basis_noise",
    expression = "basis_noise{x = x,\z
                              y = y,\z
                              seed0 = map_seed,\z
                              seed1 = 13423,\z
                              input_scale = 1 / 500,\z
                              output_scale = 250}"
  },
  {
    type = "noise-expression",
    name = "crater_elevation",
    expression = "lerp(max(clamp(crater_plasma, -100, 10000), crater_basis_noise),\z
                       crater_plasma,\z
                       clamp(0.7 * crater_basis_noise, 0, 1))\z
                  * (1 - clamp(wit_plasma(13, 2.5, 10, 0.15, 0.75), 0, 1))",
  },
  {
    type = "noise-expression",
    name = "crater_spots",
    expression = "max(wit_starting_volcano_spot, raw_spots - starting_protector)",
    local_expressions =
    {
      starting_protector = "clamp(starting_spot_at_angle{ angle = wit_mountains_angle + 180 * wit_starting_direction,\z
                                                          distance = (300 * wit_starting_area_radius) / 2,\z
                                                          radius = 600 * wit_starting_area_radius,\z
                                                          x_distortion = wit_wobble_x/2 + wit_wobble_large_x/12 + wit_wobble_huge_x/80,\z
                                                          y_distortion = wit_wobble_y/2 + wit_wobble_large_y/12 + wit_wobble_huge_y/80}, 0, 1)",
      raw_spots = "spot_noise{x = x + wit_wobble_x/2 + wit_wobble_large_x/12 + wit_wobble_huge_x/80,\z
                              y = y + wit_wobble_y/2 + wit_wobble_large_y/12 + wit_wobble_huge_y/80,\z
                              seed0 = map_seed,\z
                              seed1 = 1,\z
                              candidate_spot_count = 1,\z
                              suggested_minimum_candidate_point_spacing = volcano_spot_spacing,\z
                              skip_span = 1,\z
                              skip_offset = 0,\z
                              region_size = 256,\z
                              density_expression = volcano_area / volcanism_sq,\z
                              spot_quantity_expression = volcano_spot_radius * volcano_spot_radius,\z
                              spot_radius_expression = volcano_spot_radius,\z
                              hard_region_target_quantity = 0,\z
                              spot_favorability_expression = volcano_area,\z
                              basement_value = 0,\z
                              maximum_spot_basement_radius = volcano_spot_radius}",
      volcano_area = "lerp(wit_mountains_biome_full_pre_volcano, 0, wit_starting_area)",
      volcano_spot_radius = "200 * volcanism",
      volcano_spot_spacing = "200 * volcanism",
      volcanism = "0.3 + 0.7 * slider_rescale(control:bm_wit_volcanism:size, 3) / slider_rescale(wit_scale_multiplier, 3)",
      volcanism_sq = "volcanism * volcanism"
    }
  },
  {
    type = "noise-function",
    name = "crater_inverted_peak",
    parameters = {"spot", "inversion_point"},
    expression = "(inversion_point - abs(spot - inversion_point)) / inversion_point - 0.5"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_func",
    expression = "lerp(1.25 * crater_elevation, 700 * crater_inverted_peak(crater_spots, 0.275), clamp(crater_spots * 1, 0, 1))\z
     + 100 * (aux - 0.25) * (crater_spots + 0.25)"
  },
  {
    type = "noise-expression",
    name = "wit_ashlands_func",
    expression = "300 + 0.001 * min(basis_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 12643,\z
                                                input_scale = wit_scale_multiplier / 50 / scale,\z
                                                output_scale = 150},\z
                                    basis_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 12643,\z
                                                input_scale = wit_scale_multiplier / 50 / scale,\z
                                                output_scale = 150})",
    local_expressions = {scale = 3}
  },
  {
    type = "noise-expression",
    name = "wit_elev",
    expression = "wit_elevation_offset\z
                  + lerp(wit_ashlands_func,\z
                          20 + wit_mountains_func * wit_mountains_elevation_multiplier,\z
                          wit_mountains_biome)"
  },
  {
    type = "noise-expression",
    name = "wit_elevation",
    --intended_property = "elevation",
    expression = "max(-500, wit_elev)"
  },

  ------------------------------------------------------BIOME NOISE
  {
    type = "noise-function",
    name = "wit_biome_noise",
    parameters = {"seed1", "scale"},
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    persistence = 0.65,\z
                                    seed0 = map_seed,\z
                                    seed1 = seed1,\z
                                    octaves = 5,\z
                                    input_scale = wit_scale_multiplier / scale}"
  },
  {
    type = "noise-function",
    name = "wit_biome_multiscale",
    parameters = {"seed1", "scale", "bias"},
    expression = "bias + lerp(wit_biome_noise(seed1, scale * 0.5),\z
                              wit_biome_noise(seed1 + 1000, scale),\z
                              clamp(distance / 10000, 0, 1))"
  },
  {
    type = "noise-expression",
    name = "wit_ashlands_biome_noise",
    expression = "wit_biome_multiscale{seed1 = 12416,\z
                                            scale = 40,\z
                                            bias = 0}"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_biome_noise",
    expression = "wit_biome_multiscale{seed1 = 342,\z
                                            scale = 60,\z
                                            bias = 0}"
  },
  {
    type = "noise-function",
    name = "wit_detail_noise",
    parameters = {"seed1", "scale", "octaves", "magnitude"},
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = seed1 + 12243,\z
                                    octaves = octaves,\z
                                    persistence = 0.6,\z
                                    input_scale = 1 / 50 / scale,\z
                                    output_scale = magnitude}"
  },

  ---------------------------------------------------WOBBLES
  {
    type = "noise-expression",
    name = "wit_wobble_x",
    expression = "wit_detail_noise{seed1 = 10, scale = 1/8, octaves = 2, magnitude = 4}"
  },
  {
    type = "noise-expression",
    name = "wit_wobble_y",
    expression = "wit_detail_noise{seed1 = 1010, scale = 1/8, octaves = 2, magnitude = 4}"
  },
  {
    type = "noise-expression",
    name = "wit_wobble_large_x",
    expression = "wit_detail_noise{seed1 = 20, scale = 1/2, octaves = 2, magnitude = 50}"
  },
  {
    type = "noise-expression",
    name = "wit_wobble_large_y",
    expression = "wit_detail_noise{seed1 = 1020, scale = 1/2, octaves = 2, magnitude = 50}"
  },
  {
    type = "noise-expression",
    name = "wit_wobble_huge_x",
    expression = "wit_detail_noise{seed1 = 30, scale = 2, octaves = 2, magnitude = 800}"
  },
  {
    type = "noise-expression",
    name = "wit_wobble_huge_y",
    expression = "wit_detail_noise{seed1 = 1030, scale = 2, octaves = 2, magnitude = 800}"
  },

  ----------------------------------------------------STARTING AREAS
  {
    type = "noise-expression",
    name = "wit_starting_direction",
    expression = "-1 + 2 * (map_seed_small & 1)"
  },
  {
    type = "noise-expression",
    name = "wit_starting_area_radius",
    expression = "0.7 * 0.75"
  },
  {
    type = "noise-expression",
    name = "wit_starting_circle", -- Used to push random ores away. No not clamp.
    -- 600-650 circle
    expression = "1 + wit_starting_area_radius * (300 - distance) / 50"
  },
  {
    type = "noise-expression",
    name = "wit_starting_area_multiplier",
    -- reduced richness for starting resources
    expression = "1"
    --expression = "lerp(1, 0.06, clamp(0.5 + wit_starting_circle, 0, 1))"
  },
  {
    type = "noise-expression",
    name = "wit_ashlands_angle",
    expression = "map_seed_normalized * 3600"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_angle",
    expression = "wit_ashlands_angle + 120 * wit_starting_direction"
  },
  {
    type = "noise-expression",
    name = "wit_ashlands_start",
    -- requires more influence because it is smaller and has no mountain boost
    expression = "4 * starting_spot_at_angle{ angle = wit_ashlands_angle,\z
                                              distance = 170 * wit_starting_area_radius,\z
                                              radius = 350 * wit_starting_area_radius,\z
                                              x_distortion = 0.1 * wit_starting_area_radius * (wit_wobble_x + wit_wobble_large_x + wit_wobble_huge_x),\z
                                              y_distortion = 0.1 * wit_starting_area_radius * (wit_wobble_y + wit_wobble_large_y + wit_wobble_huge_y)}"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_start",
    expression = "2 * starting_spot_at_angle{ angle = wit_mountains_angle,\z
                                              distance = 200 * wit_starting_area_radius,\z
                                              radius = 400 * wit_starting_area_radius,\z
                                              x_distortion = 0.05 * wit_starting_area_radius * (wit_wobble_x + wit_wobble_large_x + wit_wobble_huge_x),\z
                                              y_distortion = 0.05 * wit_starting_area_radius * (wit_wobble_y + wit_wobble_large_y + wit_wobble_huge_y)}"
  },
  {
    type = "noise-expression",
    name = "wit_starting_area", -- used for biome blending
    expression = "clamp(max(wit_mountains_start, wit_ashlands_start), 0, 1)"
  },
  {
    type = "noise-expression",
    name = "wit_starting_volcano_spot",
    expression = "clamp(starting_spot_at_angle{ angle = wit_mountains_angle,\z
                                                distance = 300 * wit_starting_area_radius,\z
                                                radius = 100,\z
                                                x_distortion = wit_wobble_x/2 + wit_wobble_large_x/12 + wit_wobble_huge_x/80,\z
                                                y_distortion = wit_wobble_y/2 + wit_wobble_large_y/12 + wit_wobble_huge_y/80}, 0, 1)"
  },


  ---------------------------------------------------BIOMES
  {
    type = "noise-expression",
    name = "wit_biome_contrast",
    expression = 2 -- higher values mean sharper transitions
  },
  {
    type = "noise-expression",
    name = "wit_ashlands_raw",
    expression = "lerp(wit_ashlands_biome_noise, starting_weights, clamp(2 * wit_starting_area, 0, 1))",
    local_expressions =
    {
      starting_weights = "-wit_mountains_start + wit_ashlands_start"
    }
  },
  {
    type = "noise-expression",
    name = "wit_mountains_raw_pre_volcano",
    expression = "lerp(wit_mountains_biome_noise, starting_weights, clamp(2 * wit_starting_area, 0, 1))",
    local_expressions =
    {
      starting_weights = "wit_mountains_start - wit_ashlands_start"
    }
  },
  {
    type = "noise-expression",
    name = "wit_mountains_raw_volcano",
    -- moderate influence for the outer 1/3 of the volcano, ramp to high influence for the middle third, and maxed for the innter third
    expression = "0.5 * wit_mountains_raw_pre_volcano + max(2 * crater_spots, 10 * clamp((crater_spots - 0.33) * 3, 0, 1))"
  },
  {
    type = "noise-expression",
    name = "wit_ashlands_biome_full",
    expression = "wit_ashlands_raw - wit_mountains_raw_volcano"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_biome_full_pre_volcano",
    expression = "wit_mountains_raw_pre_volcano - wit_ashlands_raw"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_biome_full",
    expression = "wit_mountains_raw_volcano - wit_ashlands_raw"
  },
  -- clamped 0-1 biomes
  {
    type = "noise-expression",
    name = "wit_ashlands_biome",
    expression = "clamp(wit_ashlands_biome_full * wit_biome_contrast, 0, 1)"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_biome",
    expression = "clamp(wit_mountains_biome_full * wit_biome_contrast, 0, 1)"
  },

  ----------------------------------------------------RESOURCES
  {
    type = "noise-expression",
    name = "wit_ore_dist",
    --expression = "1"
    expression = "max(1, 0.5 + (distance / 8000))"
  },
  {
    type = "noise-expression",
    name = "wit_mountains_resource_favorability_asteroid",
    --expression = "clamp(main_region - (crater_spots > 0.78), 0, 1)",
    expression = "clamp(main_region + (0.8 * (crater_spots > 0.90)), 0, 1)",
    local_expressions =
    {
      buffer = 10, --7 -- push ores away from biome edges.
      contrast = 4, --2
      --main_region = "clamp(((wit_mountains_biome_full * (wit_starting_area < 0.01)) - buffer) * contrast, 0, 1)"
      main_region = "clamp((wit_mountains_biome_full - buffer) * contrast, 0, 1)"
    }
  },
  {
    type = "noise-expression",
    name = "wit_mountains_resource_favorability_glass",
    expression = "clamp(main_region - (crater_spots > 0.78), 0, 1)",
    local_expressions =
    {
      buffer = 0, --0.1 -- push ores away from biome edges.
      contrast = 4, --1
      --main_region = "clamp(((wit_mountains_biome_full * (wit_starting_area < 0.01)) - buffer) * contrast, 0, 1)"
      main_region = "clamp((wit_mountains_biome_full - buffer) * contrast, 0, 1)"
    }
  },
  {
    type = "noise-expression",
    name = "wit_ashlands_resource_favorability",
    expression = "clamp(((wit_ashlands_biome_full * (wit_starting_area < 0.01)) - buffer) * contrast, 0, 1)",
    local_expressions =
    {
      buffer = 0.3, -- push ores away from biome edges.
      contrast = 2
    }
  },
  {
    type = "noise-expression",
    name = "wit_resource_wobble_x",
    expression = "wit_wobble_x + 0.25 * wit_wobble_large_x"
  },
  {
    type = "noise-expression",
    name = "wit_resource_wobble_y",
    expression = "wit_wobble_y + 0.25 * wit_wobble_large_y"
  },
  {
    type = "noise-function",
    name = "wit_spot_noise",
    parameters = {"seed", "count", "spacing", "span", "offset", "region_size", "density", "quantity", "radius", "favorability"},
    expression = "spot_noise{x = x + wit_resource_wobble_x,\z
                             y = y + wit_resource_wobble_y,\z
                             seed0 = map_seed,\z
                             seed1 = seed,\z
                             candidate_spot_count = count,\z
                             suggested_minimum_candidate_point_spacing = 128,\z
                             skip_span = span,\z
                             skip_offset = offset,\z
                             region_size = region_size,\z
                             density_expression = density,\z
                             spot_quantity_expression = quantity,\z
                             spot_radius_expression = radius,\z
                             hard_region_target_quantity = 0,\z
                             spot_favorability_expression = favorability,\z
                             basement_value = -1,\z
                             maximum_spot_basement_radius = 128}"
  },
  {
    type = "noise-function",
    name = "wit_place_non_metal_spots",
    parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
    expression = "min(2 * favor_biome - 1, wit_spot_noise{seed = seed,\z
                                                               count = count,\z
                                                               spacing = wit_ore_spacing,\z
                                                               span = 3,\z
                                                               offset = offset,\z
                                                               region_size = 400 + 400 / freq,\z
                                                               density = favor_biome * 4,\z
                                                               quantity = size * size,\z
                                                               radius = size,\z
                                                               favorability = favor_biome > 0.9})"
  },
  {
    type = "noise-function",
    name = "wit_place_sulfur_spots",
    parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
    expression = "min(2 * favor_biome - 1, wit_spot_noise{seed = seed,\z
                                                               count = count,\z
                                                               spacing = wit_ore_spacing,\z
                                                               span = 3,\z
                                                               offset = offset,\z
                                                               region_size = 450 + 450 / freq,\z
                                                               density = favor_biome * 4,\z
                                                               quantity = size * size,\z
                                                               radius = size,\z
                                                               favorability = favor_biome > 0.9})"
  },
  {
    type = "noise-expression",
    name = "wit_richness_multiplier",
    expression = "6 + distance / 10000"
  },

  {
    type = "noise-expression",
    name = "asteroid_ore_size",
    expression = "slider_rescale(control:bm_asteroid_ore:size, 2) * 1"
  },
  {
    type = "noise-expression",
    name = "asteroid_ore_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    --expression = "wit_mountains_resource_favorability_asteroid"
    ---[[
    expression = "min(wit_mountains_resource_favorability_asteroid,\z
                        wit_place_non_metal_spots(749, 100, 1,\z
                          asteroid_ore_size * min(1.2, wit_ore_dist) * 15,\z
                          1000 * control:bm_asteroid_ore:frequency,\z
                          wit_mountains_resource_favorability_asteroid))"
    --]]
  },
  {
    type = "noise-expression",
    name = "asteroid_ore_probability",
    --expression = "(control:bm_asteroid_ore:size > 0) * (1000 * ((1 + asteroid_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
    expression = "(control:bm_asteroid_ore:size > 0) * (1000 * ((1 + asteroid_ore_region) - 1))"
  },
  {
    type = "noise-expression",
    name = "asteroid_ore_richness",
    expression = "asteroid_ore_region * random_penalty_between(0.9, 1, 1)\z
                  * 1000000 * wit_starting_area_multiplier\z
                  * control:bm_asteroid_ore:richness / asteroid_ore_size"
  },

  {
    type = "noise-expression",
    name = "glass_shard_size",
    expression = "slider_rescale(control:bm_glass_shard:size, 2) / 1.5"
  },
  {
    type = "noise-expression",
    name = "glass_shard_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    expression = "wit_place_non_metal_spots(333, 12, 1,\z
                          glass_shard_size * min(1.2, wit_ore_dist) * 10,\z
                          7500 * control:bm_glass_shard:frequency,\z
                          wit_mountains_resource_favorability_glass)\z
                  - 100 * (crater_spots > 0.50)"
  },
  {
    type = "noise-expression",
    name = "glass_shard_probability",
    expression = "(control:bm_glass_shard:size > 0) * (10000 * ((1 + glass_shard_region) * random_penalty_between(0.9, 1, 1) - 1))"
  },
  {
    type = "noise-expression",
    name = "glass_shard_richness",
    expression = "glass_shard_region * random_penalty_between(0.9, 1, 1)\z
                  * 7500 * wit_starting_area_multiplier\z
                  * control:bm_glass_shard:richness / glass_shard_size"
  },

  {
    type = "noise-expression",
    name = "copper_sulfate_size",
    expression = "slider_rescale(control:bm_copper_sulfate:size, 2) / 1.5"
  },
  {
    type = "noise-expression",
    name = "copper_sulfate_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    expression = "max(wit_starting_copper_sulfate, min(1 - wit_starting_circle,\z
                    wit_place_non_metal_spots(444, 12, 1,\z
                          copper_sulfate_size * min(1.2, wit_ore_dist) * 25,\z
                          0.9 * control:bm_copper_sulfate:frequency,\z
                          wit_ashlands_resource_favorability)))"
  },
  {
    type = "noise-expression",
    name = "copper_sulfate_probability",
    expression = "(control:bm_copper_sulfate:size > 0) * (1000 * ((1 + copper_sulfate_region) * random_penalty_between(0.9, 1, 1) - 1))"
  },
  {
    type = "noise-expression",
    name = "copper_sulfate_richness",
    expression = "copper_sulfate_region * random_penalty_between(0.9, 1, 1)\z
                  * 2500 * (wit_starting_area_multiplier + 1)\z
                  * control:bm_copper_sulfate:richness / copper_sulfate_size"
  },

  {
    type = "noise-expression",
    name = "helium_vent_size",
    expression = "slider_rescale(control:bm_helium_vent:size, 2)"
  },
  {
    type = "noise-expression",
    name = "helium_vent_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    --"max(wit_starting_helium_vent, min(1 - wit_starting_circle,\z"
    expression = "wit_place_sulfur_spots(759, 9, 0,\z
                                  helium_vent_size * min(1.2, wit_ore_dist) * 25,\z
                                  1.2 * control:bm_helium_vent:frequency,\z
                                  wit_ashlands_resource_favorability)"
  },
  {
    type = "noise-expression",
    name = "helium_vent_patches",
    -- small wavelength noise (5 tiles-ish) to make geyser placement patchy but consistent between resources and decoratives
    expression = "0.8 * abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 21000, octaves = 2, input_scale = 1/3})"
  },
  {
    type = "noise-expression",
    name = "helium_vent_region_patchy",
    expression = "(1 + helium_vent_region) * (0.5 + 0.5 * helium_vent_patches) - 1"
  },
  {
    type = "noise-expression",
    name = "helium_vent_probability",
    expression = "(control:bm_helium_vent:size > 0) * (0.025 * ((helium_vent_region_patchy > 0) + 2 * helium_vent_region_patchy))"
  },
  {
    type = "noise-expression",
    name = "helium_vent_richness",
    expression = "(helium_vent_region > 0) * random_penalty_between(0.5, 1, 1)\z
                  * 25000 * 40 * wit_richness_multiplier * wit_starting_area_multiplier\z
                  * control:bm_helium_vent:richness / helium_vent_size"
  },

  {
    type = "noise-expression",
    name = "wit_starting_copper_sulfate",
    --wit_ashlands_angle + 15 * wit_starting_direction
    expression = "starting_spot_at_angle{ angle = wit_ashlands_angle + 15 * wit_starting_direction,\z
                                          distance = 180 * wit_starting_area_radius,\z
                                          radius = 15 * copper_sulfate_size,\z
                                          x_distortion = 0.5 * wit_resource_wobble_x,\z
                                          y_distortion = 0.5 * wit_resource_wobble_y}"
  },
  {
    type = "noise-expression",
    name = "wit_starting_glass_shard",
    expression = "starting_spot_at_angle{ angle = wit_mountains_angle - 20 * wit_starting_direction,\z
                                          distance = 350 * wit_starting_area_radius,\z
                                          radius = 35 / 1.5 * wit_glass_shard_size,\z
                                          x_distortion = 0.5 * wit_resource_wobble_x,\z
                                          y_distortion = 0.5 * wit_resource_wobble_y}"
  },
  {
    type = "noise-expression",
    name = "wit_starting_helium_vent",
    --expression = "max("
    expression = "starting_spot_at_angle{ angle = wit_ashlands_angle - 5 * wit_starting_direction,\z
                                              distance = 300 * wit_starting_area_radius,\z
                                              radius = 20,\z
                                              x_distortion = 0.75 * wit_resource_wobble_x,\z
                                              y_distortion = 0.75 * wit_resource_wobble_y}\z"
    --[[
                      ", starting_spot_at_angle{ angle = wit_ashlands_angle - 10 * wit_starting_direction,\z
                                              distance = 500 * wit_starting_area_radius,\z
                                              radius = 25 * helium_vent_size,\z
                                              x_distortion = 0.75 * wit_resource_wobble_x,\z
                                              y_distortion = 0.75 * wit_resource_wobble_y})"
    ]]
  },

  -----------------------------------------------SMALL STUFF
  {
    type = "noise-expression",
    name = "wit_aux",
    --intended_property = "aux",
    expression = "clamp(abs(multioctave_noise{x = x,\z
                                                  y = y,\z
                                                  seed0 = map_seed,\z
                                                  seed1 = 2,\z
                                                  octaves = 5,\z
                                                  persistence = 0.6,\z
                                                  input_scale = 0.2,\z
                                                  output_scale = 0.6}),\z
                        0, 1)"
  },
  ---- MOISTURE (0-1): On wit used for vegetation clustering.
  ---- 0 is no vegetation, such as ash bowels in the ashlands.
  ---- 1 is vegetation pathches (mainly in ashlands).
  ---- As this drives the ash bowls, it also has an impact on small rock & pebble placement.
  {
    type = "noise-expression",
    name = "wit_moisture",
    --intended_property = "moisture",
    expression = "clamp(1\z
                        - abs(multioctave_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 4,\z
                                                octaves = 2,\z
                                                persistence = 0.6,\z
                                                input_scale = 0.025,\z
                                                output_scale = 0.25})\z
                        - abs(multioctave_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 400,\z
                                                octaves = 3,\z
                                                persistence = 0.62,\z
                                                input_scale = 0.051144353,\z
                                                output_scale = 0.25}),\z
                        0, 1)"
  },
  {
    type = "noise-expression",
    name = "wit_decorative_knockout", -- small wavelength noise (5 tiles-ish) to make decoratives patchy
    expression = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1300000, octaves = 2, input_scale = 1/3}"
  },
  {
    type = "noise-expression",
    name = "wit_rock_noise",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 137,\z
                                    octaves = 4,\z
                                    persistence = 0.65,\z
                                    input_scale = 0.1,\z
                                    output_scale = 0.4}"
    -- 0.1 / slider_rescale(var('control:bm_rocks:frequency'), 2),\z
  },

  {
    type = "noise-expression",
    name = "wit_rock_huge",
    expression = "min(wit_mountains_biome, - 1.6 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout) - 10 * max(glass_shard_region, 0)"
    --expression = "min(0.2 * (1 - 0.75 * wit_ashlands_biome), - 1.2 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout)"
  },
  {
    type = "noise-expression",
    name = "wit_rock_big",
    expression = "min(wit_mountains_biome, - 1.2 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout) - 10 * max(glass_shard_region, 0)"
    --expression = "min(0.2 * (1 - 0.5 * wit_ashlands_biome), - 1.0 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout)"
  },
  {
    type = "noise-expression",
    name = "wit_rock_medium",
    expression = "- 1.1 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout - 10 * max(glass_shard_region, 0)"
    --expression = "min(0.5 * (1 - 0.5 * wit_ashlands_biome), - 0.8 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout)"
  },
  {
    type = "noise-expression",
    name = "wit_rock_cluster",
    expression = "- 1 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout - 10 * max(glass_shard_region, 0)"
    --expression = "min(0.2 * (1 - 0.5 * wit_ashlands_biome), - 0.7 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout)"
  },
  {
    type = "noise-expression",
    name = "wit_rock_small",
    expression = "- 0.8 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout - 10 * max(glass_shard_region, 0)"
    --expression = "min(0.6 * (1 - 0.5 * wit_ashlands_biome), - 0.6 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout)"
  },
  {
    type = "noise-expression",
    name = "wit_rock_tiny",
    expression = "- 0.7 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout - 10 * max(glass_shard_region, 0)"
    --expression = "min(0.75 * (1 - 0.5 * wit_ashlands_biome), - 0.5 + 1.2 * min(aux, -0.1 + 1.1 * moisture) + wit_rock_noise + 0.5 * wit_decorative_knockout)"
  },

  {
    type = "noise-expression",
    name = "glassberg_huge",
    expression = "min(glass_shard_region, 0.04 * (wit_rock_noise + aux))"
  },
  {
    type = "noise-expression",
    name = "glassberg_big",
    expression = "min(glass_shard_region, 0.12 * (wit_rock_noise + aux))"
  },
  {
    type = "noise-expression",
    name = "glassberg_medium",
    expression = "min(glass_shard_region, 0.8 * (wit_rock_noise + aux))"
  },
  {
    type = "noise-expression",
    name = "glassberg_small",
    expression = "min(glass_shard_region, 0.5 + 1 * (wit_rock_noise + aux))"
  },

  {
   type = "noise-expression",
   name = "wit_crater_small",
   expression = "min(0.1, 0.3 - wit_rock_noise - aux)"
 },
 {
   type = "noise-expression",
   name = "wit_crater_large",
   expression = "min(0.15, (0.2 - wit_rock_noise - aux) * place_every_n(3,3,0,0))"
 },
 {
   type = "noise-expression",
   name = "wit_waves_decal", -- everywhere sand
   expression = "(1 - aux - moisture) * 0.05 * place_every_n(5.7,5.7,1,1) * wit_ashlands_biome"
 },
 {
    type = "noise-expression",
    name = "wit_vulcanus_dune_decal",
    expression = "(1 - aux - moisture) * 0.05 * wit_ashlands_biome"
  },
  {
    type = "noise-expression",
    name = "wit_crater_cliff",
    expression = "0.5 * (wit_rock_noise + 0.5 * aux - 0.5 * moisture) * (1 - wit_ashlands_biome) * place_every_n(21,21,0,0)"
  },
})
