local armored_biter_spawner = data.raw["unit-spawner"]["armoured-biter-spawner"]

if settings.startup["ab-enable-nest"].value and armored_biter_spawner then
  armored_biter_spawner.loot = data.raw["unit-spawner"]["biter-spawner"].loot
end
