local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local planet_catalogue_fulgora = require("__space-age__.prototypes.planet.procession-catalogue-fulgora")



local fulgora_map_gen = data.raw.planet.fulgora.map_gen_settings
fulgora_map_gen.property_expression_names["entity:bm-promethium-ore:richness"] = "bm_fulgora_promethium_richness"
fulgora_map_gen.property_expression_names["entity:bm-promethium-ore:probability"] = "bm_fulgora_promethium_probability"
fulgora_map_gen.autoplace_settings.entity.settings["bm-promethium-ore"] = {}
--fulgora_map_gen.autoplace_controls["bm_promethium_ore"] = {}



local balack_map_gen = {
  property_expression_names =
  {
    elevation = "bm_balack_elevation",
    temperature = "temperature_basic",
    moisture = "moisture_basic",
    aux = "aux_basic",
    cliffiness = "bm_balack_cliffiness",
    cliff_elevation = "cliff_elevation_from_elevation",
  },
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
  autoplace_controls =
  {
    ["bm_balack_scrap"] = {},
    ["bm_balack_islands"] = {},
    ["bm_balack_cliff"] = {},
    ["bm_promethium_ore"] = {},
  },
  autoplace_settings =
  {
    ["tile"] =
    {
      settings =
      {
        ["bm-balack-oil-shallow"] = {},
        ["bm-balack-oil-deep"] = {},
        ["bm-balack-n-rock"] = {},
        ["bm-balack-n-dust"] = {},
        ["bm-balack-n-sand"] = {},
        ["bm-balack-n-dunes"] = {},
        ["bm-balack-n-walls"] = {},
        ["bm-balack-n-paving"] = {},
        ["bm-balack-n-conduit"] = {},
        ["bm-balack-n-machinery"] = {},
        ["bm-bio-cube-pool"] = {},
      }
    },
    ["decorative"] =
    {
      settings =
      {
        ["bm-balack-ruin-tiny"] = {},
        --["fulgoran-gravewort"] = {},
        --["urchin-cactus"] = {},
        ["bm-medium-balack-rock"] = {},
        ["bm-small-balack-rock"] = {},
        ["bm-tiny-balack-rock"] = {},
        ["bm-balack-urchin-cactus"] = {},
        ["bm-balack-wispy-lichen"] = {},
        ["bm-balack-carpet-grass"] = {},
        ["bm-balack-brambles"] = {},
        ["bm-balack-blood-grape"] = {},
      }
    },
    ["entity"] =
    {
      settings =
      {
        ["bm-balack-scrap"] = {},
        ["bm-balack-ruin-vault"] = {},
        ["bm-balack-ruin-colossal"] = {},
        ["bm-balack-ruin-huge"] = {},
        ["bm-balack-ruin-big"] = {},
        ["bm-balack-ruin-stonehenge"] = {},
        ["bm-balack-ruin-medium"] = {},
        ["bm-balack-ruin-small"] = {},
        --["fulgurite"] = {},
        ["bm-big-balack-rock"] = {},
        ["bm-balack-water-cane"] = {},
        ["bm-balack-lichen-tree"] = {},
        ["bm-balack-ruin-attractor"] = {},
        ["bm-promethium-ore"] = {},
        ["bm-balack-stomper-shell"] = {},
        ["bm-balack-behemoth-worm"] = {},
      }
    }
  }
}



data:extend({
  {
    type = "planet",
    name = "bm-balack",
    icon = "__biological-machines-planet-balack__/graphics/balack-icon.png",
    starmap_icon = "__biological-machines-planet-balack__/graphics/balack-starmap.png",
    starmap_icon_size = 3840,
    gravity_pull = 10,
    distance = 41,
    orientation = 0.29,
    magnitude = 0.9,
    label_orientation = 0.35,
    order = "f[balack]",
    subgroup = "planets",
    map_gen_settings = balack_map_gen,
    pollutant_type = "pollution",
    solar_power_in_space = 120,
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
    surface_properties =
    {
      ["day-night-cycle"] = 60 * 60,
      ["magnetic-field"] = 25,
      ["solar-power"] = 0,
      pressure = 1500,
      gravity = 15,
    },
    surface_render_parameters =
    {
      --[[
      clouds =
      {
        shape_noise_texture =
        {
          filename = "__core__/graphics/clouds-noise.png",
          size = 2048
        },
        detail_noise_texture =
        {
          filename = "__core__/graphics/clouds-detail-noise.png",
          size = 2048
        },

        warp_sample_1 = { scale = 0.8 / 16 },
        warp_sample_2 = { scale = 3.75 * 0.8 / 32, wind_speed_factor = 0 },
        warped_shape_sample = { scale = 2 * 0.18 / 32 },
        additional_density_sample = { scale = 1.5 * 0.18 / 32, wind_speed_factor = 1.77 },
        detail_sample_1 = { scale = 1.709 / 32, wind_speed_factor = 0.2 / 1.709 },
        detail_sample_2 = { scale = 2.179 / 32, wind_speed_factor = 0.33 / 2.179 },

        scale = 1,
        movement_speed_multiplier = 0.75,
        opacity = 0.25,
        opacity_at_night = 0.25,
        density_at_night = 1,
        detail_factor = 1.5,
        detail_factor_at_night = 2,
        shape_warp_strength = 0.06,
        shape_warp_weight = 0.4,
        detail_sample_morph_duration = 0,
      },
      ]]

      -- Should be based on the default day/night times, ie
      -- sun starts to set at 0.25
      -- sun fully set at 0.45
      -- sun starts to rise at 0.55
      -- sun fully risen at 0.75
      -- On fulgora night looks a bit longer to look right with the lightning.
      shadow_opacity = 0.0,
      day_night_cycle_color_lookup =
      {
        --{0.0, "__biological-machines-planet-balack__/graphics/nightvision.png"},
        --{0.0, "identity"},
        {0.0, "__space-age__/graphics/lut/gleba-1-noon.png"},
        --{0.0, "__space-age__/graphics/lut/vulcanus-2-night.png"},

        {0.5, "__biological-machines-planet-balack__/graphics/night.png"},

        --[[
        {0.0, "__space-age__/graphics/lut/fulgora-1-noon.png"},
        {0.2, "__space-age__/graphics/lut/fulgora-1-noon.png"},
        {0.3, "__space-age__/graphics/lut/fulgora-2-afternoon.png"},
        {0.4, "__space-age__/graphics/lut/fulgora-3-after-sunset.png"},
        {0.6, "__space-age__/graphics/lut/fulgora-4-before-dawn.png"},
        {0.7, "__space-age__/graphics/lut/fulgora-5-morning.png"},
        ]]
      },

      terrain_tint_effect =
      {
        noise_texture =
        {
          filename = "__space-age__/graphics/terrain/vulcanus/tint-noise.png",
          size = 4096
        },

        offset = { 0.2, 0, 0.4, 0.8 },
        intensity = { 0.2, 0.4, 0.3, 0.25 },
        scale_u = { 1.85, 1.85, 1.85, 1.85 },
        scale_v = { 1, 1, 1, 1 },

        global_intensity = 0.6, --0.3 base
        global_scale = 0.25,
        zoom_factor = 3.8,
        zoom_intensity = 0.75
      }
    },
    --ticks_between_player_effects = 2, --from tenebris
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge, 0.9),
    persistent_ambient_sounds =
    {
      base_ambience = {filename = "__space-age__/sound/wind/base-wind-fulgora.ogg", volume = 0.5},
      wind = {filename = "__space-age__/sound/wind/wind-fulgora.ogg", volume = 0.8},
      crossfade =
      {
        order = {"wind", "base_ambience"},
        curve_type = "cosine",
        from = {control = 0.35, volume_percentage = 0.0},
        to = {control = 2, volume_percentage = 100.0}
      },
      semi_persistent =
      {
        {
          sound =
          {
            variations = sound_variations("__space-age__/sound/world/semi-persistent/sand-wind-gust", 5, 0.45),
            advanced_volume_control =
            {
              fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0}}}
            }
          },
          delay_mean_seconds = 15,
          delay_variance_seconds = 9,
        },
      }
    }
  },
})



data:extend({
  {
    type = "space-connection",
    name = "bm-fulgora-to-balack",
    subgroup = "planet-connections",
    from = "fulgora",
    to = "bm-balack",
    order = "i-a",
    length = 100000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge)
  },
  {
    type = "space-connection",
    name = "bm-aquilo-to-balack",
    subgroup = "planet-connections",
    from = "aquilo",
    to = "bm-balack",
    order = "i-b",
    length = 100000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge)
  },
  {
    type = "space-connection",
    name = "bm-balack-to-edge",
    subgroup = "planet-connections",
    from = "bm-balack",
    to = "solar-system-edge",
    order = "i-c",
    length = 100000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge)
  },
})
