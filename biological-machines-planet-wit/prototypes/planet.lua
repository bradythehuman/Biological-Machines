--local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local planet_catalogue_vulcanus = require("__space-age__.prototypes.planet.procession-catalogue-vulcanus")



local wit_map_gen = {
  property_expression_names = {
    elevation = "wit_elevation",
    --temperature = "wit_temperature",
    moisture = "wit_moisture",
    aux = "wit_aux",
    cliffiness = "cliffiness_basic",
    cliff_elevation = "cliff_elevation_from_elevation",
    ["entity:bm-glass-shard:probability"] = "glass_shard_probability",
    ["entity:bm-glass-shard:richness"] = "glass_shard_richness",
    ["entity:bm-copper-sulfate:probability"] = "copper_sulfate_probability",
    ["entity:bm-copper-sulfate:richness"] = "copper_sulfate_richness",
    ["entity:bm-asteroid-ore:probability"] = "asteroid_ore_probability",
    ["entity:bm-asteroid-ore:richness"] = "asteroid_ore_richness",
    ["entity:bm-helium-vent:probability"] = "helium_vent_probability",
    ["entity:bm-helium-vent:richness"] = "helium_vent_richness",
  },
  cliff_settings = {
    name = "bm-cliff-wit",
    cliff_elevation_interval = 120,
    cliff_elevation_0 = 70
  },
  autoplace_controls = {
    ["bm_glass_shard"] = {},
    ["bm_copper_sulfate"] = {},
    ["bm_asteroid_ore"] = {},
    ["bm_helium_vent"] = {},
    ["bm_wit_volcanism"] = {},
    --["rocks"] = {}, -- can't add the rocks control otherwise nauvis rocks spawn
  },
  autoplace_settings = {
    ["tile"] = {
      settings = {
        ["bm-wit-ash-cracks"] = {},
        ["bm-wit-ash-dark"] = {},
        ["bm-wit-ash-light"] = {},
        ["bm-wit-ash-flats"] = {},
        --["wit-jagged-ground"] = {}
      }
    },
    ["decorative"] = {
      settings = {
        ["vulcanus-dune-decal"] = {},
        --["vulcanus-sand-decal"] = {},
        --["calcite-stain"] = {},
        --["calcite-stain-small"] = {},
        --["sulfur-stain"] = {},
        --["sulfur-stain-small"] = {},
        ["crater-small"] = {},
        ["crater-large"] = {},
        ["bm-small-wit-rock"] = {},
        ["bm-medium-wit-rock"] = {},
        ["bm-tiny-wit-rock"] = {},
        ["bm-tiny-wit-rock-cluster"] = {},
        --["small-sulfur-rock"] = {},
        --["tiny-sulfur-rock"] = {},
        --["sulfur-rock-cluster"] = {},
        ["waves-decal"] = {},
        ["bm-glassberg-medium"] = {},
        ["bm-glassberg-small"] = {},
      }
    },
    ["entity"] = {
      settings = {
        ["bm-glass-shard"] = {},
        ["bm-copper-sulfate"] = {},
        ["bm-asteroid-ore"] = {},
        ["bm-helium-vent"] = {},
        ["bm-huge-wit-rock"] = {},
        ["bm-big-wit-rock"] = {},
        ["bm-wit-crater-cliff"] = {},
        ["bm-glassberg-huge"] = {},
        ["bm-glassberg-big"] = {},
      }
    }
  }
}



PlanetsLib:extend({
  {
    type = "planet",
    name = "bm-wit",
    icon = "__biological-machines-planet-wit__/graphics/wit-icon.png",
    icon_size = 64,
    starmap_icon = "__biological-machines-planet-wit__/graphics/wit-starmap.png",
    starmap_icon_size = 1482,
    gravity_pull = 0,
    orbit = {
			parent = {
				type = "planet",
				name = "nauvis",
			},
			distance = 1.39,
			orientation = 0.59,
		},
		subgroup = "satellites",
    --distance = 15,
    --orientation = 0.3,
    label_orientation = 0.51,
    magnitude = 0.5,
    draw_orbit = false,
    order = "a[nauvis]-b",
    subgroup = "planets",
    map_gen_settings = wit_map_gen,
    pollutant_type = nil,
    solar_power_in_space = 300,
    platform_procession_set = {
      arrival = {"planet-to-platform-b"},
      departure = {"platform-to-planet-a"}
    },
    planet_procession_set = {
      arrival = {"platform-to-planet-b"},
      departure = {"planet-to-platform-a"}
    },
    procession_graphic_catalogue = planet_catalogue_vulcanus,
    surface_properties = {
      ["day-night-cycle"] = 14 * minute,
      ["magnetic-field"] = 98,
      ["solar-power"] = 250,
      pressure = 50, --5
      gravity = 2.5
    },
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.1),
    --persistent_ambient_sounds = data.raw["planet"]["aquilo"].persistent_ambient_sounds,
    persistent_ambient_sounds = {
      base_ambience = {filename = "__space-age__/sound/wind/base-wind-aquilo.ogg", volume = 0.5},
      wind = {filename = "__space-age__/sound/wind/wind-aquilo.ogg", volume = 0.8},
      crossfade = {
        order = {"wind", "base_ambience"},
        curve_type = "cosine",
        from = {control = 0.35, volume_percentage = 0.0},
        to = {control = 2, volume_percentage = 100.0}
      },
      semi_persistent = {
        {
          sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/cold-wind-gust", 5, 0.3)},
          delay_mean_seconds = 15,
          delay_variance_seconds = 9
        }
      }
    },
    surface_render_parameters = {
      --fog = effects.default_fog_effect_properties(),
      -- clouds = effects.default_clouds_effect_properties(),

      -- Should be based on the default day/night times, ie
      -- sun starts to set at 0.25
      -- sun fully set at 0.45
      -- sun starts to rise at 0.55
      -- sun fully risen at 0.75
      --day_night_cycle_color_lookup = data.raw["planet"]["fulgora"].day_night_cycle_color_lookup,

      terrain_tint_effect = {
        noise_texture = {
          filename = "__biological-machines-planet-wit__/graphics/wit-tint-noise.png",
          size = 4096
        },

        offset = { 0.2, 0, 0.4, 0.8 },
        intensity = { 0.5, 0.2, 0.3, 1.0 },
        scale_u = { 3, 1, 1, 1 },
        scale_v = { 1, 1, 1, 1 },

        global_intensity = 0.3,
        global_scale = 0.1,
        zoom_factor = 3,
        zoom_intensity = 0.6
      }
    }
  }
})



--PlanetsLib.borrow_music("space-platform", data.raw["planet"]["wit"])



data:extend({
  {
    type = "space-connection",
    name = "bm-nauvis-wit",
    subgroup = "planet-connections",
    from = "nauvis",
    to = "bm-wit",
    order = "a",
    length = 1000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
  }
})
