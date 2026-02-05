--remove concrete foundry recipe from prod tech
local concrete_tech = data.raw.technology["concrete-productivity"]
new_effects = {}
for _, effect in pairs(concrete_tech.effects) do
  if effect.recipe ~= "concrete-from-molten-iron" then
    table.insert(new_effects, effect)
  end
end
concrete_tech.effects = new_effects
