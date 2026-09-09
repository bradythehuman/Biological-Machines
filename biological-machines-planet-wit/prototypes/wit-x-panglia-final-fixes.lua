--all but rocket turret craftable in robotics facility
local remove_brain_category = {
  "spidertron", "logistic-robot", "construction-robot",
  "roboport", "flying-robot-frame", "asteroid-collector",
  "defender-capsule", "distractor-capsule", "destroyer-capsule",
  "personal-roboport-equipment", "personal-roboport-mk2-equipment",
  --"rocket-turret",
}

if data.raw.item["long-stack-inserter"] then
  table.insert(remove_brain_category, "long-stack-inserter")
end

for _, recipe_name in pairs(remove_brain_category) do
  local new_categories = {}
  for _, category in pairs(data.raw.recipe[recipe_name].categories) do
    if category ~= "thinkingbrain" then
      table.insert(new_categories, category)
    end
  end
  data.raw.recipe[recipe_name].categories = new_categories
end

--[[
local add_brain_category = {
  "biolab", "neural_computer",
}
for _, recipe_name in pairs(add_brain_category) do
  table.insert(data.raw.recipe[recipe_name].categories, "thinking-brain")
end
]]

data.raw.recipe["biolab"].categories = {"crafting", "thinkingbrain"}
data.raw.recipe["neural_computer"].categories = {"crafting", "thinkingbrain"}
