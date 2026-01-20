--FULL RESISTANCES
local full_resistences = {}
for _, damage_type in pairs(data.raw["damage-type"]) do
  table.insert(full_resistences, {type = damage_type.name, percent = 100})
end

for _, prototype in pairs(bm_add_full_resistences) do
  prototype.resistances = full_resistences
end
