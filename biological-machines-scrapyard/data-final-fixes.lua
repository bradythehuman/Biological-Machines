--Moves recycling recipe unlocks to scrapyard if present in recycling tech
if data.raw.technology and data.raw.technology.recycling then
  for _, effect in pairs(data.raw.technology.recycling.effects) do
    local new_effects = {}

    if effect.type == "unlock-recipe"
    and string.sub(effect.recipe, -10, -1) == "-recycling" then
      table.insert(data.raw.technology["bm-scrapyard"].effects, effect)
    else
      table.insert(new_effects, effect)
    end

    data.raw.technology.recycling.effects = new_effects
  end
end
