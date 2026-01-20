if settings.startup["bm-boompuff-agriculture"]
and settings.startup["bm-boompuff-agriculture"].value then
  data.raw["recipe"]["bm-grenade-from-puff-gas"].category = "bm-military-crafting-with-fluid"
  data.raw["recipe"]["bm-light-oil-ammo"].category = "bm-military-crafting-with-fluid"
  data.raw["recipe"]["bm-napalm-ammo"].category = "bm-military-crafting-with-fluid"
end
