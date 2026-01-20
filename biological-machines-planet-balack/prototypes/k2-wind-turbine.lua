require "__k2-wind-turbine-zars-fork__/_globals"

local overrides = {
  ["vulcanus"] = 150,
  ["nauvis"] = 75,
  ["gleba"] =  75,
  ["fulgora"] =  50,
  ["aquilo"] =   25,
  ["bm-balack"] = 200,
}
for planet_name, wind_power in pairs(overrides) do
  K2_WIND_TURBINE_ZARS_FORK.OVERRIDE_SOLAR_POWER_SCALING[planet_name] = wind_power
end



data.raw["electric-energy-interface"][TURBINE_NAME].surface_conditions = {
  {property = "pressure", min = SETTING.EXQUISITE and 100 or 301, max = 10000},
  {property = "gravity", min = 1, max = 100},
}
