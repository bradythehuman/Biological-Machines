local initial_trades = {
  ["space-platform-foundation"] = 100,
  ["solar-panel"] = 200,
  ["electric-engine-unit"] = 200,
  ["low-density-structure"] = 200,
  ["processing-unit"] = 200,
  ["tungsten-plate"] = 100,
  ["superconductor"] = 150,
  ["supercapacitor"] = 75,
  ["quantum-processor"] = 25,
}

local extra_trades = {
  ["rocket-fuel"] = 100,
  ["rocket-silo"] = 1,
  ["bm-suspension-fluid-barrel"] = 10,
  ["bm-clone"] = 1,
  ["bm-energy-link-core"] = 1
}

if (mods and mods["biological-machines-planet-wit"])
or (prototypes and prototypes.item["bm-advanced-solar-panel"]) then
  initial_trades["solar-panel"] = nil
  initial_trades["bm-advanced-solar-panel"] = 50
  initial_trades["bm-mixed-gas-power-cell"] = 75
end

if (mods and mods["biological-machines-planet-balack"])
or (prototypes and prototypes.item["bm-radiation-sheilding"]) then
  initial_trades["quantum-processor"] = nil
  initial_trades["bm-radiation-sheilding"] = 50
  initial_trades["bm-ai-control-unit"] = 1
end

if (mods and mods["biological-machines-hunger"])
or (prototypes and prototypes.item["bm-nutrient-paste"]) then
  extra_trades["bm-nutrient-paste"] = 200
end

if (settings.startup["bm-rocket-parts"] and settings.startup["bm-rocket-parts"].value)
or (prototypes and prototypes.recipe["bm-rocket-part-bm-dyson-sphere"]) then
  extra_trades["rocket-part"] = 50
end



local function scale_trade(initial_amount, trade_count)
  return math.floor(initial_amount * (1 + 0.1 * trade_count))
end



return {
  station_io_ticks = 60,
  initial_payout = 200,
  final_payout = 2000,
  initial_trades = initial_trades,
  extra_trades = extra_trades,
  scale_trade = scale_trade,
}
