local recycling = require("__recycler__.recycling")

local promethium_belts = {
  "promethium-transport-belt", "promethium-underground-belt",
  "promethium-splitter",
}

if mods["aai-loaders"] and settings.startup["aai-loaders-mode"].value ~= "graphics-only" then
  table.insert(promethium_belts, "aai-promethium-loader")
end

for _, recipe_name in pairs(promethium_belts) do
  --generates recycling recipe into parts. passed a function which always returns true to bypass metallurgy recipes defaulting to recycle into themselves
  recycling.generate_recycling_recipe(data.raw.recipe[recipe_name], function(_) return true end)
end
