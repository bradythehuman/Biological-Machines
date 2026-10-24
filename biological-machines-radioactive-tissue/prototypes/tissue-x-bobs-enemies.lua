for name, spawner in pairs(data.raw["unit-spawner"]) do
  if string.sub(name, 1, 3) == "bob" then
    if spawner.loot == nil then
      spawner.loot = {}
    end
    table.insert(spawner.loot, {type = "item", name = "bm-radioactive-tissue", amount_min = 1, amount_max = 9})
  end
end
