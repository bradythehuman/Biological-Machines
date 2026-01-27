local dh = require("__biological-machines-core__.data-helper")



data.raw.item["deadlock-large-lamp"].order = "a[light]-a[small-lamp]-a"

dh.remove_ingredient("deadlock-large-lamp", "copper-cable")
dh.add_ingredient("deadlock-large-lamp", "item",  "bm-lightbulb", 4)

local to_remove = {
  ["deadlock-copper-lamp"] = true,
  ["deadlock-electric-copper-lamp"] = true,
  ["deadlock-floor-lamp"] = true,
}

for lamp_name, _ in pairs(to_remove) do
  data.raw.recipe[lamp_name] = nil
  data.raw.item[lamp_name] = nil
  if lamp_name == "deadlock-copper-lamp" then
    data.raw["assembling-machine"][lamp_name] = nil
  else
    data.raw["lamp"][lamp_name] = nil
  end
end

local new_effects = {}
for _, effect in pairs(data.raw.technology["lamp"].effects) do
  if effect.type == "unlock-recipe" then
    if to_remove[effect.recipe] == nil then
      table.insert(new_effects, effect)
    end
  else
    table.insert(new_effects, effect)
  end
end
data.raw["technology"]["lamp"].effects = new_effects

--[[
local remove_cable = {"deadlock-large-lamp", "deadlock-electric-copper-lamp", "deadlock-floor-lamp"}
dh.remove_ingredient(remove_cable, "copper-cable")

local add_lightbulb = {
  ["deadlock-large-lamp"] = 4,
  ["deadlock-electric-copper-lamp"] = 4,
  ["deadlock-floor-lamp"] = 4,
}
dh.add_ingredient_table(add_lightbulb, "item",  "bm-lightbulb")

dh.remove_ingredient("deadlock-electric-copper-lamp", "advanced-circuit")

dh.add_ingredient("deadlock-electric-copper-lamp", "item", "electronic-circuit", 1)
]]
