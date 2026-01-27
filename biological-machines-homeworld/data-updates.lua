local dh = require("__biological-machines-core__.data-helper")
local th = require("trade-helper")



--MARKET RECIPES
local function make_trade(item_type, item_name, item_amount)
  local item_prototype = data.raw[item_type][item_name]
  local recipe_name = "bm-market-" .. item_name
  local trade_icons = {}

  if item_prototype.icon then
    table.insert(trade_icons, {
      icon = item_prototype.icon,
      scale = 0.28,
      shift = {4, 8},
    })
  else
    local item_icons = item_prototype.icons
    local i = 1
    while i < #item_icons do
      local scale = item_icons[i].scale or 0.5
      local tint = item_icons[i].tint or {1, 1, 1}
      local shift = item_icons[i].shift or {0, 0}
      local shift_x = 4 + shift[1] * 0.56 * 0.75
      local shift_y = 4 + shift[2] * 0.56 * 0.5
      table.insert(trade_icons, {
        icon = item_icons[i].icon,
        scale = scale * 0.56,
        tint = tint,
        shift = {shift_x, shift_y},
      })
      i = i + 1
    end
  end

  table.insert(trade_icons, {
    icon = "__biological-machines-k2-assets__/graphics/arrow-g.png",
  })
  table.insert(trade_icons, {
    icon = "__base__/graphics/icons/coin.png",
    scale = 0.28,
    shift = {-8, -8},
  })

  data:extend({{
    type = "recipe",
    name = recipe_name,
    localised_name = {"", {"item-name." .. item_name}, {"bm.market-recipe-suffix"}},
    icons = trade_icons,
    category = "bm-market",
    subgroup = "bm-homeworld",
    order = "c",
    enabled = false,
    energy_required = 1,
    ingredients = {{type = "item", name = "bm-credit", amount = th.initial_payout}},
    results = {{type = "item", name = item_name, amount = item_amount}}
  }})

  dh.add_recipe_unlock("bm-solar-system-discovery-homeworld", recipe_name)
  table.insert(data.raw["technology"]["bm-market-productivity"].effects, {
    type = "change-recipe-productivity",
    recipe = recipe_name,
    change = 0.1
  })
end

for item_name, item_amount in pairs(th.initial_trades) do
  if th.only_sell[item_name] == nil then
    make_trade("item", item_name, item_amount)
  end
end

for item_name, item_amount in pairs(th.only_buy) do
  make_trade("item", item_name, item_amount)
end



--RECYCLING RECIPES
data.raw["recipe"]["bm-super-credit-recycling"].results = {{type = "item", name = "bm-credit", amount = 200, probability = 0.25, ignored_by_stats = 1}}
