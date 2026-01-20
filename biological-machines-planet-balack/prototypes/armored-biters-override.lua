local biter_spawner = data.raw["unit-spawner"]["biter-spawner"]

if settings.startup["ab-enable-nest"].value then
  data.raw["unit-spawner"]["armoured-biter-spawner"] = nil
  data.raw["corpse"]["armoured-biter-spawner-corpse"] = nil
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

data.raw["unit"]["small-armoured-biter"] = nil
data.raw["corpse"]["small_armoured-corpse"] = nil

data.raw["unit"]["big-armoured-biter"] = nil

for _, prefix in pairs({"medium", "behemoth", "leviathan"}) do
  data.raw["unit"][prefix .. "-armoured-biter"] = nil
  data.raw["corpse"][prefix .. "-armoured-corpse"] = nil
end
