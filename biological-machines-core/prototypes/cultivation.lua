------------------------------------------CULTIVATION ITEM GROUPS
local cultivate = {
  {name = "iron-bacteria", type = "item", order = "a-a"},
  {name = "iron-bacteria", type = "recipe", order = "a-a"},
  {name = "iron-bacteria-cultivation", type = "recipe", order = "a-b"},
  {name = "copper-bacteria", type = "item", order = "a-c"},
  {name = "copper-bacteria", type = "recipe", order = "a-c"},
  {name = "copper-bacteria-cultivation", type = "recipe", order = "a-d"},
  --{name = "biter-egg", type = "item", order = "b-a"},
  {name = "pentapod-egg", type = "item", order = "b-b"},
  {name = "pentapod-egg", type = "recipe", order = "b-c"}
}
for _, c in pairs(cultivate) do
  local prototype = data.raw[c.type][c.name]
  prototype.subgroup = "bm-cultivation"
  prototype.order = c.order
end


data:extend({
  --a=bacteria, b=eggs, c=tissue
  {
    type = "item-subgroup",
    name = "bm-cultivation",
    group = "intermediate-products",
    order = "ma"
  },
  --a=biodesel, b=poison, c=napalm
  {
    type = "item-subgroup",
    name = "bm-biological-fluid-recipes",
    group = "intermediate-products",
    order = "aa"
  },
})
