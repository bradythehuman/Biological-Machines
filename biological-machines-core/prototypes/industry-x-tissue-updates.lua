if settings.startup["bm-boompuff-agriculture"]
and settings.startup["bm-boompuff-agriculture"].value then
  data.raw["recipe"]["bm-grenade-from-puff-gas"].categories = {"bm-military-crafting-with-fluid"}
  data.raw["recipe"]["bm-light-oil-ammo"].categories = {"bm-military-crafting-with-fluid"}
  data.raw["recipe"]["bm-napalm-ammo"].categories = {"bm-military-crafting-with-fluid"}
end
