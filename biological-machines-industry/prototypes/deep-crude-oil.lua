local resource_autoplace = require("resource-autoplace")

local normal_crude = data.raw["resource"]["crude-oil"]
local deep_crude = util.table.deepcopy(normal_crude)

--normal_crude.minimum = 45000 --base 60000
--normal_crude.normal = 225000 --base 300000
normal_crude.autoplace.tile_restriction = {
    "grass-1", "grass-2", "grass-3", "grass-4",
    "dry-dirt", "dirt-1", "dirt-2", "dirt-3", "dirt-4", "dirt-5", "dirt-6", "dirt-7",
    "dust-crests", "dust-flat", "dust-lumpy", "dust-patchy",
    "ice-rough", "ice-smooth", "snow-crests", "snow-flat", "snow-lumpy", "snow-patchy"
}

deep_crude.name = "bm-deep-crude-oil"
deep_crude.minimum = 180000
deep_crude.normal = 900000
deep_crude.autoplace = resource_autoplace.resource_autoplace_settings{
  name = "bm-deep-crude-oil",
  order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
  base_density = 8.2,
  base_spots_per_km2 = 1.8,
  random_probability = 1/48,
  random_spot_size_minimum = 1,
  random_spot_size_maximum = 1, -- don't randomize spot size
  additional_richness = 220000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
  has_starting_area_placement = false,
  regular_rq_factor_multiplier = 1
}
deep_crude.autoplace.tile_restriction = {
  "red-desert-0", "red-desert-1", "red-desert-2", "red-desert-3",
  "sand-1", "sand-2", "sand-3"
}

data:extend({
  deep_crude,
  {
    type = "autoplace-control",
    name = "bm-deep-crude-oil",
    localised_name = {"", "[entity=bm-deep-crude-oil] ", {"entity-name.bm-deep-crude-oil"}},
    richness = true,
    order = "a-e",
    category = "resource"
  }
})

resource_autoplace.initialize_patch_set("bm-deep-crude-oil", false)

data.raw.planet.nauvis.map_gen_settings.autoplace_controls["bm-deep-crude-oil"] = {}
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["bm-deep-crude-oil"] = {}
