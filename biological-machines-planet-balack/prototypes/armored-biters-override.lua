local biter_spawner = data.raw["unit-spawner"]["biter-spawner"]

if settings.startup["ab-enable-nest"].value then
  local armored_spawner = data.raw["unit-spawner"]["armoured-biter-spawner"]
  armored_spawner.autoplace = nil
  armored_spawner.hidden = true
  data.raw["corpse"]["armoured-biter-spawner-corpse"].hidden = true
elseif biter_spawner then
  local new_result_units = {}
  for _, result_unit in pairs(biter_spawner["result_units"]) do
    if not string.find(result_unit[1], "armoured") then
      new_result_units[#new_result_units + 1] = result_unit
      log("UNIT ALERT: " .. result_unit[1])
    end
  end
  biter_spawner["result_units"] = new_result_units
end

data.raw["unit"]["small-armoured-biter"].hidden = true
data.raw["corpse"]["small_armoured-corpse"].hidden = true

data.raw["unit"]["big-armoured-biter"].hidden = true

for _, prefix in pairs({"medium", "behemoth", "leviathan"}) do
  data.raw["unit"][prefix .. "-armoured-biter"].hidden = true
  data.raw["corpse"][prefix .. "-armoured-corpse"].hidden = true
end
