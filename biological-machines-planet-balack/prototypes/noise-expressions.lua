--[[
Objectives:
Fairly narrow channels of dark sand between regions that require elevated rail to not be uniformly stright.
Wide channels of sand between plateaus that are too far for big power poles.
Plateaus sizes that are big enough for a few train stops + ramps and either a mining outpost or a production line, but not much more.
Natural areas have more space but no resources.
Sparse city areas have wide low richness resource patches.
Vault islands have a small island with a moat so are difficult to build on, but have an extreme richness resource patch

chebyshev ◇ diamond, max(abs(x), abs(y))
manhattan □ square, abs(x) + abs(y)
euclidean ○ circle, (x^2 + y^2)^0.5
minkowski3  ▢ rounded square, (x^3 + y^3)^(1/3)

The starting island is a natural island. It can merge with a vault island, but to prevent a vault bridge to mainland,
the starting island also needs to have a moat.
The natural area of the starting island should override the vault content if the overlap too much.
]]

data:extend
{
  { -- The grid sze for the voronoi. As most other noise is scaled based on this it acts like terrain segmentation, but the value has a specific meaning.
    -- 200 is ideal. 180-ish is the minimim viable size.
    type = "noise-expression",
    name = "bm_balack_grid",
    expression = "85 - slider_to_linear(control:bm_balack_islands:frequency, -50, 50)", --default 175, small 85
  },
  { -- the starting area cone, slightly larger diameter than a grid cell.
    type = "noise-expression",
    name = "bm_balack_starting_cone",
    expression = "max(0, starting_spot_at_angle{angle = map_seed / 360,\z
                                                distance = bm_balack_grid / 30,\z
                                                radius = bm_balack_grid / 1.8,\z
                                                x_distortion = 1 * bm_balack_wobble_x,\z
                                                y_distortion = 1 * bm_balack_wobble_y},\z
                         starting_spot_at_angle{angle = map_seed / 360,\z
                                                distance = 1,\z
                                                radius = bm_balack_grid / 4,\z
                                                x_distortion = 0.25 * bm_balack_wobble_x,\z
                                                y_distortion = 0.25 * bm_balack_wobble_y})",
  },
  { -- the starting area cone, slightly larger diameter than a grid cell.
    type = "noise-expression",
    name = "bm_balack_starting_vault_cone",
    --[[
    expression = "max(0, starting_spot_at_angle{angle = map_seed / 360 + 180,\z
                                                distance = bm_balack_grid / 1.8,\z
                                                radius = bm_balack_grid / 1.8,\z
                                                x_distortion = 1 * bm_balack_wobble_x,\z
                                                y_distortion = 1 * bm_balack_wobble_y})",
    ]]
    expression = "max(0, starting_spot_at_angle{angle = map_seed / 360 + 180,\z
                                                distance = 0,\z
                                                radius = bm_balack_grid,\z
                                                x_distortion = 1 * bm_balack_wobble_x,\z
                                                y_distortion = 1 * bm_balack_wobble_y})",
  },
  {
    type = "noise-expression",
    name = "bm_balack_starting_mask",
    expression = "(bm_balack_starting_cone - bm_balack_starting_vault_cone) > 0",
  },
  {
    type = "noise-expression",
    name = "bm_balack_starting_vault_mask",
    expression = "(bm_balack_starting_vault_cone - bm_balack_starting_cone) > 0",
  },
  { -- Controls the X Y input wobble effect.
    type = "noise-expression",
    name = "bm_balack_wobble_influence",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    persistence = 0.5,\z
                                    seed0 = map_seed,\z
                                    seed1 = 1,\z
                                    octaves = 3,\z
                                    input_scale = 128 / bm_balack_grid / 20 ,\z
                                    output_scale = 3}",
  },
  { -- We usually want a lot of wobble or none at all, so influence has a high outpus scale and then we clamp it.
    type = "noise-expression",
    name = "bm_balack_wobble_mask",
    expression = "clamp(bm_balack_wobble_influence + 0.6, 0, 1)",
  },

  { -- generate X input distortion
    type = "noise-expression",
    name = "bm_balack_wobble_x", -- only add to input X or Y
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_wobble_x',\z
                                    octaves = 4,\z
                                    input_scale = 5 / bm_balack_grid,\z
                                    output_scale = bm_balack_grid * 0.07}"
  },
  { -- generate y input distortion
    type = "noise-expression",
    name = "bm_balack_wobble_y", -- only add to input X or Y
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_wobble_y',\z
                                    octaves = 4,\z
                                    input_scale = 5 / bm_balack_grid,\z
                                    output_scale = bm_balack_grid * 0.07}"
  },

  { -- offset grid so that the starting area is in the middle of a cell
    type = "noise-expression",
    name = "bm_balack_ox",
    expression = "x + bm_balack_grid / 2"
  },
  { -- offset grid so that the starting area is in the middle of a cell
    type = "noise-expression",
    name = "bm_balack_oy",
    expression = "y + bm_balack_grid / 2"
  },

  { -- distorted x. Also offset grid so that the starting area is in the middle of a cell
    type = "noise-expression",
    name = "bm_balack_wx",
    expression = "bm_balack_ox + bm_balack_wobble_x * bm_balack_wobble_mask"
  },
  { -- distorted y. Also offset grid so that the starting area is in the middle of a cell
    type = "noise-expression",
    name = "bm_balack_wy",
    expression = "bm_balack_oy + bm_balack_wobble_y * bm_balack_wobble_mask"
  },

  { -- The main basis noise for natural areas
    type = "noise-expression",
    name = "bm_balack_basis",
    expression = "multioctave_noise{x = bm_balack_wx,\z
                                    y = bm_balack_wy,\z
                                    persistence = 0.5,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_basis',\z
                                    octaves = 6,\z
                                    input_scale = 128 / bm_balack_grid / 7.5,\z
                                    output_scale = 0.5}",
  },
  { -- How much voronoi points are offset in their grid square.
    type = "noise-expression",
    name = "bm_balack_jitter",
    expression = "0.6",
  },
  { -- Cell ids for the main voronoi islands
    type = "noise-expression",
    name = "bm_balack_cells",
    expression = "voronoi_cell_id{x = bm_balack_wx,\z
                                  y = bm_balack_wy,\z
                                  seed0 = map_seed,\z
                                  seed1 = 'bm_balack_cells',\z
                                  grid_size = bm_balack_grid,\z
                                  distance_type = 'manhattan',\z
                                  jitter = bm_balack_jitter}",
  },
  { -- Pyramids for the main voronoi islands
    type = "noise-expression",
    name = "bm_balack_pyramids",
    expression = "voronoi_pyramid_noise{x = bm_balack_wx,\z
                                        y = bm_balack_wy,\z
                                        seed0 = map_seed,\z
                                        seed1 = 'bm_balack_cells',\z
                                        grid_size = bm_balack_grid,\z
                                        distance_type = 'manhattan',\z
                                        jitter = bm_balack_jitter}",
  },
  { -- Spots for the main voronoi islands (vaults only). Spots are inverted cones
    type = "noise-expression",
    name = "bm_balack_spots",
    expression = "voronoi_spot_noise{x = bm_balack_ox + bm_balack_wobble_x / 2,\z
                                     y = bm_balack_oy + bm_balack_wobble_y / 2,\z
                                     seed0 = map_seed,\z
                                     seed1 = 'bm_balack_cells',\z
                                     grid_size = bm_balack_grid,\z
                                     distance_type = 'euclidean',\z
                                     jitter = bm_balack_jitter}",
  },
  { -- Spots for the main voronoi islands (vaults only). Spots are cones
    type = "noise-expression",
    name = "bm_balack_spots_inv",
    expression = "1 - bm_balack_spots",
  },
  { -- Cells that are blank and will become oil ocean
    type = "noise-expression",
    name = "bm_balack_blanks",
    --expression = "bm_balack_cells < 0.33",
    expression = "bm_balack_cells < 0.10",
  },
  { -- Treat some islands as natural
    type = "noise-expression",
    name = "bm_balack_mesa",
    --expression = "bm_balack_cells > 0.75",
    expression = "bm_balack_cells > 0.70",
  },
  { -- Cells that have sprawling settlement islands
    type = "noise-expression",
    name = "bm_balack_sprawl",
    --expression = "(bm_balack_cells > 0.5) - bm_balack_mesa",
    expression = "(bm_balack_cells > 0.40) - bm_balack_mesa",
  },
  { -- Cells that have vault islands with moats
    type = "noise-expression",
    name = "bm_balack_vaults",
    expression = "1 - bm_balack_blanks - bm_balack_sprawl - bm_balack_mesa",
  },
  { -- Cells that have vault islands with moats
    type = "noise-expression",
    name = "bm_balack_vaults_and_starting_vault",
    --expression = "max(bm_balack_vaults, bm_balack_starting_vault_mask)",
    expression = "bm_balack_vaults",
  },
  { -- The natural landscape distribution
    type = "noise-expression",
    name = "bm_balack_natural",
    expression = "bm_balack_basis * 2 * slider_rescale(control:bm_balack_islands:size,  2) - 0.85",
    --expression = "bm_balack_basis * 10 * slider_rescale(control:bm_balack_islands:size,  2) - 0.85",
  },
  { -- Pyramids restricted to sprawl cells plus mesas altered by oil basis
    type = "noise-expression",
    name = "bm_balack_sprawl_pyramids",
    expression = "bm_balack_pyramids\z
                  * (bm_balack_sprawl\z
                     + bm_balack_mesa * min(1, abs(0.9 - 0.2 * bm_balack_basis_oil + 0.05 * bm_balack_rock)))",
  },
  { -- Pyramids restricted to vault cells
    type = "noise-expression",
    name = "bm_balack_vault_pyramids",
    expression = "max(bm_balack_vaults * bm_balack_pyramids, 0.5 * bm_balack_starting_vault_cone)",
  },
  {
    type = "noise-expression",
    name = "bm_balack_vault_pyramids_and_start",
    expression = "max(bm_balack_vault_pyramids, 0.5 * bm_balack_starting_cone)",
  },
  { -- The moats of vault cells. These take chunks out of other terrain. The depths is to ensure that there's some oil ocean in the oil sand.
    type = "noise-expression",
    name = "bm_balack_moats",
    expression = "min(bm_balack_artificial_cap, 1.5 * max(-0.05 -bm_balack_vault_pyramids_and_start * 2, (bm_balack_vault_pyramids_and_start - 0.35) * 2))",
    --expression = "min(bm_balack_artificial_cap, 1.5 * max(-0.05 -bm_balack_vault_pyramids * 2, (bm_balack_vault_pyramids - 0.35) * 2))",
  },
  { -- The upper limit of pyramids, making them plateaus instead.
    type = "noise-expression",
    name = "bm_balack_artificial_cap",
    expression = "0.25",
  },
  { -- Get sprawl pyramids to the correct level to mix with the natural landscape
    type = "noise-expression",
    name = "bm_balack_mix_pyramids",
    expression = "min(bm_balack_artificial_cap, (bm_balack_sprawl_pyramids - 0.185) * 4)",
  },
  { -- Mix the sprawl and natural landscape together
    type = "noise-expression",
    name = "bm_balack_mix_natural",
    expression = "max(bm_balack_natural, bm_balack_mix_pyramids)",
  },
  { -- Compare the sprawl and natural landscape heights to make a mask for what is natural and what is not. Vault cells are also removed.
    type = "noise-expression",
    name = "bm_balack_natural_mask",
    expression = "max(min(bm_balack_natural > bm_balack_mix_pyramids, 1 - bm_balack_vaults_and_starting_vault), bm_balack_starting_mask)",
  },
  { -- Compare the sprawl and natural landscape heights to make a mask for what is natural and what is not. Vault cells are also removed.
    type = "noise-expression",
    name = "bm_balack_natural_and_mesa_mask",
    expression = "max(bm_balack_natural_mask, bm_balack_mesa)",
  },
  { -- Make a mask for sprawl area, essentially just sprawl cells minus the natural mask.
    type = "noise-expression",
    name = "bm_balack_sprawl_mask",
    expression = "max(0, bm_balack_sprawl - bm_balack_natural_mask)",
  },
  { -- Cut vault moats out of the landscape
    type = "noise-expression",
    name = "bm_balack_mix_moats",
    expression = "lerp(bm_balack_mix_natural, bm_balack_moats, max(bm_balack_vaults_and_starting_vault, bm_balack_starting_mask))",
  },
  { -- Make vault spots into small roundish plateaus with a consistent size for consistent resources.
    -- normal spot inverse is roughly 0.5 to 1, but the lower bound can be a bit less in corners.
    -- blending in the starting spot properly required a 0.5 bump.
    type = "noise-expression",
    name = "bm_balack_vault_spots",
    expression = "min(bm_balack_artificial_cap,\z
                      -10 + 11.5 * max(bm_balack_vaults * bm_balack_spots_inv,\z
                                       bm_balack_starting_vault_mask * (0.5 + 0.5 * bm_balack_starting_vault_cone),\z
                                       bm_balack_starting_mask * (0.5 + 0.5 * bm_balack_starting_cone)))",
  },
  { -- Apply vault spots to the landscape
    type = "noise-expression",
    name = "bm_balack_mix_spots",
    expression = "max(bm_balack_mix_moats, bm_balack_vault_spots) + max(0, bm_balack_starting_cone - 0.8)",
  },
  { -- A mask for low oil areas, i.e. oil sand and oil ocean. Later sand basins will be also be below 0 (to have inner cliffs), but will not be in the oil mask
    type = "noise-expression",
    name = "bm_balack_oil_mask",
    expression = "bm_balack_mix_spots < 0",
  },
  { -- not oil, not natural
    type = "noise-expression",
    name = "bm_balack_artificial_mask",
    expression = "1 - max(bm_balack_oil_mask, bm_balack_natural_and_mesa_mask)",
  },
  { -- Noise to break up the oil areas. This gets heavily distorted.
    type = "noise-expression",
    name = "bm_balack_basis_oil",
    expression = "multioctave_noise{x = x + 1.5 * bm_balack_wobble_x,\z
                                    y = y + 1.5 * bm_balack_wobble_y,\z
                                    persistence = 0.65,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_basis_oil',\z
                                    octaves = 4,\z
                                    input_scale = 1 / 10}",
  },
  {  -- Apply oil noise to the oil mask areas, but make sure it doens't make oil areas positive
    type = "noise-expression",
    name = "bm_balack_mix_oil",
    expression = "lerp(bm_balack_mix_spots, min(-0.01, bm_balack_mix_spots - 0.4 + 0.6 * bm_balack_basis_oil), bm_balack_oil_mask)",
  },
  { -- We want cliffs right on the coast edge but to do that we need to move the coastline elevation above 0
    type = "noise-expression",
    name = "bm_balack_coastline",
    expression = 80,
  },
  { -- Make a large elevation change at the coast so that that the janky cliff smothing does mot mess up
    type = "noise-expression",
    name = "bm_balack_coastline_drop",
    expression = 20,
  },
  { -- Invert the heightfield above a certain elevation so that natural inland sand areas form bowls with cliffs facing inwards instead of outwards.
    -- This does make inland areas negative elevation, so we will need to use the oil mask so that liquids don't go here.
    type = "noise-expression",
    name = "bm_balack_sand_basins",
    expression = "min(bm_balack_mix_oil, 0.6 - bm_balack_mix_oil)",
    --expression = "bm_balack_mix_oil",
  },
  { -- Make the initial elevation. The elevation rate should be such that the 2nd level of cliffs are where the inner sand basin cliffs are now.
    type = "noise-expression",
    name = "bm_balack_pre_elevation",
    expression = "bm_balack_sand_basins * 60 + bm_balack_coastline"
  },
  { -- Make the final elevation by applying the coastal cliff drop
    type = "noise-expression",
    name = "bm_balack_elevation",
    --intended_property = "elevation",
    expression = "bm_balack_pre_elevation + ((bm_balack_sand_basins > 0) - 0.5) * bm_balack_coastline_drop\z
                                          + 40 * bm_balack_sprawl_mask",
    --expression = "bm_balack_pre_elevation"
  }
} -- End elevation

--[[
  Scrap and machinery tiles share a tech pattern.
  walls and paving can be more wide spread, even appearing on the natural island is small areas.
  Rock is mainly on island edges
  Dust is mainly as deserts in the middle of natural islands.
  Dunes and flat sand are the default and have their own mix.
]]
data:extend
{
  { -- Make the final elevation by applying the coastal cliff drop
    type = "noise-expression",
    name = "bm_balack_cliffiness",
    --intended_property = "cliffiness",
    expression = "8 * slider_rescale(cliff_richness, 20)\z
                  * (bm_balack_road_pyramids - 0.1 + max(0, 1 - 10 * bm_balack_wobble_mask))\z
                  - 1000 * safe_start_excluder_h\z
                  - bm_bio_cube_buffer",
    local_expressions =
    {
      safe_start_excluder_h = "min(x_from_start < bm_balack_grid, x_from_start > -bm_balack_grid, y_from_start < 5, y_from_start > -5)"
    }
  },
  { -- used for tiles and resources
    type = "noise-expression",
    name = "bm_balack_scrap_small",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_scrap_small',\z
                                    octaves = 3,\z
                                    input_scale = 1/9}"
  },
  { -- used for tiles and resources
    type = "noise-expression",
    name = "bm_balack_scrap_medium",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_scrap_medium',\z
                                    octaves = 3,\z
                                    input_scale = 1/18}"
  },
  { -- Ridged noise for walls
    type = "noise-expression",
    name = "bm_balack_ruins_walls",
    expression = "0.66 - abs(multioctave_noise{x = x,\z
                                               y = y,\z
                                               persistence = 0.7,\z
                                               seed0 = map_seed,\z
                                               seed1 = 'bm_balack_ruins_walls',\z
                                               octaves = 3,\z
                                               input_scale = 1/6})"
  },
  { -- Billows noise for paving
    type = "noise-expression",
    name = "bm_balack_ruins_paving",
    expression = "abs(multioctave_noise{x = x,\z
                                        y = y,\z
                                        persistence = 0.7,\z
                                        seed0 = map_seed,\z
                                        seed1 = 'bm_balack_ruins_paving',\z
                                        octaves = 3,\z
                                        input_scale = 1/16})"
  },
  {
    type = "noise-expression",
    name = "bm_balack_road_jitter",
    expression = 1
  },
  { -- The medium scale road grid cells. Swaps internal small road patterns.
    type = "noise-expression",
    name = "bm_balack_road_cells",
    expression = "voronoi_cell_id{x = x,\z
                                  y = y,\z
                                  seed0 = map_seed,\z
                                  seed1 = 'bm_balack_road_cells',\z
                                  grid_size = bm_balack_grid / 3,\z
                                  distance_type = 'chebyshev',\z
                                  jitter = bm_balack_road_jitter}",
  },
  { -- The medium scale road grid pyramids. Required for the main roads.
    type = "noise-expression",
    name = "bm_balack_road_pyramids",
    expression = "voronoi_pyramid_noise{x = x,\z
                                        y = y,\z
                                        seed0 = map_seed,\z
                                        seed1 = 'bm_balack_road_cells',\z
                                        grid_size = bm_balack_grid / 3,\z
                                        distance_type = 'chebyshev',\z
                                        jitter = bm_balack_road_jitter}",
  },
  { -- Banding the main pyramids for road pattern B
    type = "noise-expression",
    name = "bm_balack_pyramids_banding",
    expression = "(bm_balack_pyramids * 8) % 1"
  },
  { -- The multiplier for road pattern C. Needed for the road pattern but also the district center cutout.
    type = "noise-expression",
    name = "bm_balack_spots_prebanding",
    expression = "min(bm_balack_spots, (1 - bm_balack_starting_vault_cone) / 2) * 9 + 0.5"
  },
  { -- Banding the main spots for road pattern C
    type = "noise-expression",
    name = "bm_balack_spots_banding",
    expression = "bm_balack_spots_prebanding % 1"
  },
  {
    type = "noise-expression",
    name = "bm_balack_structure_jitter",
    expression = 0.8
  },
  { -- Cells for the smallest scale voronoi for individual structure blocks.
    type = "noise-expression",
    name = "bm_balack_structure_cells",
    expression = "voronoi_cell_id{x = x,\z
                                  y = y * 0.8,\z
                                  seed0 = map_seed,\z
                                  seed1 = 'bm_balack_structure_cells',\z
                                  grid_size = bm_balack_grid / 8,\z
                                  distance_type = 'minkowski3',\z
                                  jitter = bm_balack_structure_jitter}",
  },
  {
    type = "noise-expression",
    name = "bm_balack_structure_subnoise",
    expression = "multioctave_noise{x = x + 10000 * bm_balack_structure_cells,\z
                                    y = y,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_structure_subnoise',\z
                                    octaves = 3,\z
                                    input_scale = 1/12}"
  },
  { -- Facets for the smallest scale voronoi for individual structure blocks. This is mainly for the small road pattern A.
    type = "noise-expression",
    name = "bm_balack_structure_facets",
    expression = "voronoi_facet_noise{x = x,\z
                                      y = y * 0.8,\z
                                      seed0 = map_seed,\z
                                      seed1 = 'bm_balack_structure_cells',\z
                                      grid_size = bm_balack_grid / 8,\z
                                      distance_type = 'minkowski3',\z
                                      jitter = bm_balack_structure_jitter}",
  },
  {  -- A simple version or large roads and small roads
    type = "noise-expression",
    name = "bm_balack_road_paving_thin",
    expression = "max((bm_balack_road_pyramids < 0.03) * 0.9, (bm_balack_structure_facets < 0.06) * 0.5)",
  },
  { -- Part 1 of complicated paving. Large roads, and small roads split into the 3 patterns based on bm_balack_road_cells ID
    type = "noise-expression",
    name = "bm_balack_road_paving_2",
    expression = "max((bm_balack_road_pyramids < 0.05) * 0.9,\z
                      (bm_balack_pyramids_banding < 0.1) * 0.85 * (bm_balack_road_cells < 0.6) * (bm_balack_road_cells > 0.25),\z
                      (bm_balack_spots_banding < 0.1) * 0.85 * (bm_balack_road_cells < 0.25),\z
                      (bm_balack_structure_facets < 0.1) * 0.85 * (bm_balack_road_cells > 0.6))",
  },
  { -- Part 2 of complicated paving. Cut out some structure blocks.
    type = "noise-expression",
    name = "bm_balack_road_paving_2b",
    expression = "lerp(bm_balack_road_paving_2, (bm_balack_structure_facets < 0.2) * 0.9, bm_balack_structure_cells > 0.8)",
  },
  { -- Part 3 of complicated paving. Cut out district centers.
    type = "noise-expression",
    name = "bm_balack_road_paving_2c",
    expression = "lerp(bm_balack_road_paving_2b, (bm_balack_spots_prebanding > 1) * 0.9, bm_balack_spots_prebanding < 1.3)",
  },
  { -- Dust at the edge of large roads
    type = "noise-expression",
    name = "bm_balack_road_dust",
    expression = "(bm_balack_road_pyramids < 0.08) * 0.9 - bm_balack_road_paving_2c",
  },
  { -- Dunes ridge noise.
    type = "noise-expression",
    name = "bm_balack_dunes",
    expression = "0.66 - abs(multioctave_noise{x = x,\z
                                               y = y,\z
                                               persistence = 0.7,\z
                                               seed0 = map_seed,\z
                                               seed1 = 'bm_balack_dunes',\z
                                               octaves = 3,\z
                                               input_scale = 1/6 })"
  },
  { -- Rock billows noise.
    type = "noise-expression",
    name = "bm_balack_rock",
    expression = "0.33 + abs(multioctave_noise{x = x,\z
                                               y = y,\z
                                               persistence = 0.7,\z
                                               seed0 = map_seed,\z
                                               seed1 = 'bm_balack_rock',\z
                                               octaves = 4,\z
                                               input_scale = 1/3 })"
  },
}

data:extend
{
  {
    type = "noise-expression",
    name = "bm_balack_tile_ruin_paving",
    expression = "max(bm_balack_natural_and_mesa_mask * (3 * bm_balack_ruins_paving * bm_balack_road_paving_thin - 0.5),\z
                      bm_balack_artificial_mask * (4 * bm_balack_road_paving_2c + bm_balack_ruins_paving - 1))"
  },
  {
    type = "noise-expression",
    name = "bm_balack_tile_ruin_walls",
    expression = "max(bm_balack_natural_and_mesa_mask * (2 * bm_balack_ruins_walls + bm_balack_ruins_paving - 0.5),\z
                      bm_balack_artificial_mask * (0.25 * bm_balack_ruins_walls\z
                                                 + 0.25 * bm_balack_structure_subnoise\z
                                                 - 4 * bm_balack_structure_facets\z
                                                 - bm_balack_road_paving_2c\z
                                                 + 2.5))"
  },
  {
    type = "noise-expression",
    name = "bm_balack_tile_ruin_conduit",
    expression = "bm_balack_artificial_mask * (bm_balack_ruins_walls\z
                                             + bm_balack_structure_subnoise \z
                                             + 2 * bm_balack_structure_facets\z
                                             - bm_balack_road_paving_2c\z
                                             + 0.2\z
                                             + 0.3 * bm_balack_vaults_and_starting_vault) - bm_balack_road_paving_2c"
  },
  {
    type = "noise-expression",
    name = "bm_balack_tile_ruin_machinery",
    expression = "bm_balack_artificial_mask * (-bm_balack_ruins_walls\z
                                             + 1.25 * bm_balack_structure_subnoise\z
                                             + 2.5 * bm_balack_structure_facets\z
                                             - bm_balack_road_paving_2c\z
                                             - 0.2\z
                                             + 0.3 * bm_balack_vaults_and_starting_vault\z
                                             + 2 * (bm_balack_spots_prebanding < 1)) - bm_balack_road_paving_2c"
  },
  {
    type = "noise-expression",
    name = "bm_balack_decorative_machine_density",
    expression = "max(bm_balack_tile_ruin_walls, bm_balack_tile_ruin_conduit * 2, bm_balack_tile_ruin_machinery * 3)\z
                  - bm_bio_cube_buffer"
  },
  ---[[
  {
    type = "noise-expression",
    name = "bm_bio_cube_pool",
    expression = "100000 * (abs(x) < 4) * (abs(y) < 4)",
  },
  --]]
  {
    type = "noise-expression",
    name = "bm_bio_cube_buffer",
    expression = "100000 * ((x * x) < 150) * ((y * y) < 150)",
  },
  {
    type = "noise-expression",
    name = "bm_bio_cube_scrap_buffer",
    expression = "100000 * ((x * x) < (25 ^ 2)) * ((y * y) < (25 ^ 2))",
  },
  {
    type = "noise-expression",
    name = "bm_bio_cube_enemy_buffer",
    expression = "100000 * ((x * x) < (75 ^ 2)) * ((y * y) < (75 ^ 2))",
  },
  {
    type = "noise-expression",
    name = "bm_balack_oil_ocean_shallow",
    expression = "50 * bm_balack_oil_mask * water_base(bm_balack_coastline, 1000)",
  },
  {
    type = "noise-expression",
    name = "bm_balack_oil_ocean_deep",
    expression = "100 * bm_balack_oil_mask * water_base(bm_balack_coastline - 50 - bm_balack_coastline_drop / 2, 2000)",
  },
  {
    type = "noise-expression",
    name = "bm_balack_oil_ocean_deep_mask",
    expression = "(bm_balack_oil_ocean_deep - bm_balack_oil_ocean_shallow) > 0",
  },
  {
    type = "noise-expression",
    name = "bm_fulgora_promethium_region",
    expression = "spot_noise{x = x + fulgora_wobble_x,\z
                             y = y + fulgora_wobble_y,\z
                             seed0 = map_seed,\z
                             seed1 = 1234,\z
                             candidate_spot_count = 1 + 4 * control:bm_promethium_ore:frequency,\z
                             suggested_minimum_candidate_point_spacing = 100,\z
                             skip_span = 3,\z
                             skip_offset = 2,\z
                             region_size = 250,\z
                             density_expression = 1 / (4 + (1.5 * control:bm_promethium_ore:size) ^ 2),\z
                             spot_quantity_expression = 4 + (1.5 * control:bm_promethium_ore:size) ^ 2,\z
                             spot_radius_expression = 1 + 1.5 * control:bm_promethium_ore:size,\z
                             hard_region_target_quantity = 0,\z
                             spot_favorability_expression = fulgora_natural_and_mesa_mask > 0.01,\z
                             basement_value = -1,\z
                             maximum_spot_basement_radius = 128}",
  },
  {
    type = "noise-expression",
    name = "bm_fulgora_promethium_probability",
    expression = "35 * (control:bm_promethium_ore:size > 0) * bm_fulgora_promethium_region\z
                  - 100000 * ((x * x) < (150 ^ 2)) * ((y * y) < (150 ^ 2))",
  },
  {
    type = "noise-expression",
    name = "bm_fulgora_promethium_richness",
    --expression = "100",
    ---[[
    expression = "40 * control:bm_promethium_ore:richness\z
      / control:bm_promethium_ore:size\z
      * bm_fulgora_promethium_region * random_penalty_between(0.9, 1, 1)"
    --]]
  },
  {
    type = "noise-expression",
    name = "bm_balack_promethium_region",
    expression = "spot_noise{x = x + bm_balack_wobble_x,\z
                             y = y + bm_balack_wobble_y,\z
                             seed0 = map_seed,\z
                             seed1 = 1234,\z
                             candidate_spot_count = 1 + 4 * control:bm_promethium_ore:frequency,\z
                             suggested_minimum_candidate_point_spacing = 100,\z
                             skip_span = 3,\z
                             skip_offset = 2,\z
                             region_size = 150,\z
                             density_expression = 1 / (6.75 + (1.5 * control:bm_promethium_ore:size) ^ 2),\z
                             spot_quantity_expression = 6.75 + (1.5 * control:bm_promethium_ore:size) ^ 2,\z
                             spot_radius_expression = 1.5 + 1.5 * control:bm_promethium_ore:size,\z
                             hard_region_target_quantity = 0,\z
                             spot_favorability_expression = bm_balack_natural_and_mesa_mask > 0.01,\z
                             basement_value = -1,\z
                             maximum_spot_basement_radius = 128}",
  },
  {
    type = "noise-expression",
    name = "bm_balack_promethium_probability",
    --[[
    expression = "(control:bm_promethium_ore:size > 0) * 1000\z
      * ((1 + bm_balack_promethium_region) * random_penalty_between(0.9, 1, 1) - 1)",
    ]]
    expression = "(control:bm_promethium_ore:size > 0) * bm_balack_promethium_region",
  },
  {
    type = "noise-expression",
    name = "bm_balack_promethium_richness",
    expression = "100 * control:bm_promethium_ore:richness\z
      / control:bm_promethium_ore:size\z
      * bm_balack_promethium_region * random_penalty_between(0.9, 1, 1)",
  },
}

--[[
-- scrap should be dense on the smallest islands (++), sparse on the mid islands, (+- and -+)
data.raw.resource["bm-balack-scrap"].autoplace =
{
  control = "bm-balack-scrap",
  order = "b",
  probability_expression = "(control:bm_balack_scrap:size > 0)\z
                            * (1 - bm_balack_starting_mask)\z
                            * (min((bm_balack_structure_cells < min(0.1 * frequency, 0.05 + 0.05 * frequency))\z
                               * (1 + bm_balack_structure_subnoise) * abs_mult_height_over * bm_balack_artificial_mask\z
                               + (bm_balack_spots_prebanding < (1.2 + 0.4 * linear_size)) * bm_balack_vaults_and_starting_vault * 10,\z
                               0.5) * (1 - bm_balack_road_paving_2c))",
  richness_expression = "(1 + bm_balack_structure_subnoise) * 1000 * (7 / (6 + frequency) + 100 * bm_balack_vaults_and_starting_vault) * richness",
  local_expressions =
  {
    abs_mult_height_over = "bm_balack_elevation > (bm_balack_coastline + 10)", -- Resources prevent cliffs from spawning. This gets resources away from cliffs.
    frequency = "control:bm_balack_scrap:frequency", -- limited application
    size = "control:bm_balack_scrap:size", -- Size also affects noise peak height so impacts richness as a sideeffect...
    linear_size = "slider_to_linear(size, -1, 1)", -- the intetion is to increase coverage (access & mining speed) without significantly affecting richness.
    richness = "control:bm_balack_scrap:richness"
  }
}
]]
