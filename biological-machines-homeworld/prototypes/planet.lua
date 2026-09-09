local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")



--data.raw["space-connection"]["solar-system-edge-shattered-planet"].length = 1000000



local dyson_map_gen = {
  property_expression_names =
  {
    --elevation = "bm_balack_elevation",
    temperature = "temperature_basic",
    moisture = "moisture_basic",
    aux = "aux_basic",
    --cliffiness = "bm_balack_cliffiness",
    --cliff_elevation = "cliff_elevation_from_elevation",
  },
  --[[
  cliff_settings =
  {
    name = "bm-cliff-balack",
    control = "bm_balack_cliff",
    cliff_elevation_0 = 80,
    -- Ideally the first cliff would be at elevation 0 on the coastline, but that doesn't work,
    -- so instead the coastline is moved to elevation 80.
    -- Also there needs to be a large cliff drop at the coast to avoid the janky cliff smoothing
    -- but it also fails if a corner goes below zero, so we need an extra buffer of 40.
    -- So the first cliff is at 80, and terrain near the cliff shouln't go close to 0 (usually above 40).
    cliff_elevation_interval = 40,
    cliff_smoothing = 0, -- This is critical for correct cliff placement on the coast.
    richness = 0.95
  },
  ]]
  autoplace_controls = {
    --[""] = {},
  },
  autoplace_settings = {
    ["tile"] = {
      settings = {
        ["bm-station-floor"] = {},
        ["bm-empty-space-2"] = {},
        ["refined-concrete"] = {},
        ["refined-hazard-concrete-left"] = {},
      }
    },
    ["decorative"] = {
      settings = {
        ["space-platform-decorative-pipes-2x1"] = {},
        ["space-platform-decorative-pipes-1x2"] = {},
        ["space-platform-decorative-pipes-1x1"] = {},
        ["space-platform-decorative-4x4"] = {},
        ["space-platform-decorative-2x2"] = {},
        ["space-platform-decorative-1x1"] = {},
        ["space-platform-decorative-tiny"] = {},
      }
    },
    ["entity"] = {
      settings = {
        ["bm-station-wall"] = {},
        ["bm-homeworld-market"] = {},
        ["pipe"] = {},
        ["heat-pipe"] = {},
        --["turbo-transport-belt"] = {},
        --["iron-chest"] = {},
        --["steel-chest"] = {},
        ["bm-loot-chest"] = {},
        ["assembling-machine-3"] = {},
        ["recycler"] = {},
        --["compilatron"] = {},
        ["bm-station-bot"] = {},
        ["bm-crash-spaceship"] = {},
        ["small-biter"] = {},
        ["bm-market-spawner"] = {},
      }
    },
  }
}



data:extend({
  ----------------------------------------------------CONSTRUCTION PLATFORM
  {
    type = "planet",
    name = "bm-dyson-sphere",
    icon = "__biological-machines-homeworld__/graphics/dyson-sphere-icon.png",
    starmap_icon = "__biological-machines-homeworld__/graphics/dyson-sphere-starmap.png",
    starmap_icon_size = 1000,
    --[[
    starmap_icons = {
      {
        icon = "__biological-machines-homeworld__/graphics/dyson-sphere-starmap.png",
        icon_size = 1000,
      },
      {
        icon = "__biological-machines-homeworld__/graphics/debris-starmap.png",
        icon_size = 2436,
        scale = 0.5,
      },
    },
    ]]
    gravity_pull = 20,
    distance = 116,
    orientation = 0.2,
    magnitude = 3,
    draw_orbit = false,
    --label_orientation = 0.35,
    order = "h-c",
    subgroup = "planets",
    map_gen_settings = dyson_map_gen,
    pollutant_type = "pollution",
    solar_power_in_space = 3000,
    platform_procession_set =
    {
      arrival = {"planet-to-platform-b"},
      departure = {"platform-to-planet-a"}
    },
    planet_procession_set =
    {
      arrival = {"platform-to-planet-b"},
      departure = {"planet-to-platform-a"}
    },
    procession_graphic_catalogue = planet_catalogue_fulgora,
    surface_properties = {
      ["day-night-cycle"] = 60 * 60,
      ["magnetic-field"] = 10,
      ["solar-power"] = 300,
      pressure = 100,
      gravity = 1,
    },
    surface_render_parameters = {
      shadow_opacity = 0.0,
      day_night_cycle_color_lookup = {{0.0, "identity"}},
    },
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.1),
  },

  -----------------------------------------------------NEW SYSTEM
  {
    type = "space-location",
    name = "bm-outer-debris-edge",
    icon = "__biological-machines-homeworld__/graphics/outer-debris-edge-starmap.png",
    icon_size = 256,
    starmap_icon = "__biological-machines-homeworld__/graphics/outer-debris-edge-starmap.png",
    starmap_icon_size = 256,
    order = "h-a",
    subgroup = "planets",
    --gravity_pull = 20,
    distance = 100,
    orientation = 0.2,
    --magnitude = 1.5,
    --label_orientation = 0.15,
    draw_orbit = false,
  	fly_condition = false,
  	solar_power_in_space = 100,
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge, 0.9),
  },
  {
    type = "space-location",
    name = "bm-inner-debris-edge",
    icon = "__biological-machines-homeworld__/graphics/inner-debris-edge-starmap.png",
    icon_size = 256,
    starmap_icon = "__biological-machines-homeworld__/graphics/inner-debris-edge-starmap.png",
    starmap_icon_size = 256,
    order = "h-b",
    subgroup = "planets",
    --gravity_pull = 20,
    distance = 104,
    orientation = 0.2,
    --magnitude = 1.5,
    --label_orientation = 0.15,
    draw_orbit = false,
  	fly_condition = false,
  	solar_power_in_space = 300,
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge, 0.9),
    --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.shattered_planet_trip, 0.8),
  },
  {
    type = "space-location",
    name = "bm-new-system",
    icon = "__biological-machines-homeworld__/graphics/new-system-icon.png",
    starmap_icon = "__biological-machines-homeworld__/graphics/new-system-starmap.png",
    starmap_icon_size = 512,
    order = "h-d",
    subgroup = "planets",
    gravity_pull = 20,
    distance = 100,
    orientation = 0.3,
    magnitude = 2,
    --label_orientation = 0.15,
    draw_orbit = false,
    solar_power_in_space = 300,
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.1),
  },

  ----------------------------------------------------------SPACE CONNECTIONS
  {
    type = "space-connection",
    name = "bm-edge-to-outer-debris",
    subgroup = "planet-connections",
    from = "solar-system-edge",
    to = "bm-outer-debris-edge",
    order = "j-a",
    length = 10000000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
  },
  {
    type = "space-connection",
    name = "bm-outer-debris-to-inner-debris",
    subgroup = "planet-connections",
    from = "bm-outer-debris-edge",
    to = "bm-inner-debris-edge",
    order = "j-a",
    length = 5000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.shattered_planet_trip)
  },
  {
    type = "space-connection",
    name = "bm-inner-debris-to-dyson-sphere",
    subgroup = "planet-connections",
    from = "bm-inner-debris-edge",
    to = "bm-dyson-sphere",
    order = "j-a",
    length = 25000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
  },
  {
    type = "space-connection",
    name = "bm-edge-to-new-system",
    subgroup = "planet-connections",
    from = "solar-system-edge",
    to = "bm-new-system",
    order = "j-b",
    length = 10000000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
  },
})
