--[[
atempting to add an entry which has already been added will break the prototype
if there is a chance of this, attempt to remove the entry before adding it
]]



--entity name can be string or table of strings
--amount can be int or table of ints (amount_min @ index 1 and amount_max @ index 2)
local function add_entity_drop(entity_type, entity_name, drop_name, amount)
  if type(entity_name) == "table" then
    for i=1, #entity_name do
      add_entity_drop(entity_type, entity_name[i], drop_name, amount)
    end
    return
  end

  local minable = data.raw[entity_type][entity_name].minable
  if minable.result then
    table.insert(minable.results, {type="item", name=minable.result, amount=minable.count})
    minable.result = nil
    minable.count = nil
  end

  if type(amount) == "number" then
    table.insert(minable.results, {type="item", name=drop_name, amount=amount})
  else
    table.insert(minable.results, {type="item", name=drop_name, amount_min=amount[1], amount_max=amount[2]})
  end
end

--entity name can be string or table of strings
local function remove_entity_drop(entity_type, entity_name, drop_name)
  if type(entity_name) == "table" then
    for i=1, #entity_name do
      remove_entity_drop(entity_type, entity_name[i], drop_name)
    end
    return
  end

  local minable = data.raw[entity_type][entity_name].minable
  if minable.result == drop_name then
    minable.result = nil
    minable.count = nil
  else
    local new_results = {}
    for _, result in pairs(minable.results) do
      if result.name ~= drop_name then
        table.insert(new_results, result)
      end
    end
    minable.results = new_results
  end
end



local function add_ingredient(recipe_name, ingredient_type, ingredient_name, amount)
  local ingredients = data.raw["recipe"][recipe_name].ingredients
  for _, ingredient in pairs(ingredients) do
    if ingredient.name == ingredient_name then
      ingredient.amount = amount
      return
    end
  end
  table.insert(ingredients, {type=ingredient_type, name=ingredient_name, amount=amount})
end

--recipe table must have recipe names as keys and amounts as values
local function add_ingredient_table(recipe_table, ingredient_type, ingredient_name)
  for recipe_name, amount in pairs(recipe_table) do
    add_ingredient(recipe_name, ingredient_type, ingredient_name, amount)
  end
end

--recipe name can be string or table of strings
local function remove_ingredient(recipe_name, ingredient_name)
  if type(recipe_name) == "table" then
    for i=1, #recipe_name do
      remove_ingredient(recipe_name[i], ingredient_name)
    end
    return
  end

  local recipe = data.raw["recipe"][recipe_name]
  local ingredients = recipe.ingredients
  if #ingredients == 0 then return end

  local new_ingredients = {}
  for _, ingredient in pairs(ingredients) do
    if ingredient.name ~= ingredient_name then
      table.insert(new_ingredients, ingredient)
    end
  end
  recipe.ingredients = new_ingredients
end



--recipe can be string or table of strings
local function add_recipe_unlock(tech_name, recipe)
  local tech_effects = data.raw["technology"][tech_name].effects
  if type(recipe) == "string" then
    table.insert(tech_effects, {type = "unlock-recipe", recipe = recipe})
    return
  elseif #recipe > 0 then
    for i=1, #recipe do
      table.insert(tech_effects, {type = "unlock-recipe", recipe = recipe[i]})
    end
  end
end

--recipe can be string or table of strings
local function remove_recipe_unlock(tech_name, recipe)
  local tech = data.raw["technology"][tech_name]
  if #tech.effects == 0 then return end

  local recipe_transformation = {}
  if type(recipe) == "string" then
    recipe_transformation[recipe] = true
  elseif #recipe > 0 then
    for i=1, #recipe do
      recipe_transformation[recipe[i]] = true
    end
  end

  local new_effects = {}
  for _, effect in pairs(tech.effects) do
    if recipe_transformation[effect.recipe] == nil then
      table.insert(new_effects, effect)
    end
  end
  tech.effects = new_effects
end



--tech name can be string or table of strings
--prereq can be string or table of strings
local function add_prereq(tech_name, prereq)
  if type(tech_name) == "table" then
    for i=1, #tech_name do
      add_prereq(tech_name[i], prereq)
    end
    return
  end
  local tech_prereqs = data.raw["technology"][tech_name].prerequisites
  if type(prereq) == "string" then
    table.insert(tech_prereqs, prereq)
    return
  end
  if #prereq == 0 then return end
  for i=1, #prereq do
    table.insert(tech_prereqs, prereq[i])
  end
end

--tech name can be string or table of strings
--prereq can be string or table of strings
local function remove_prereq(tech_name, prereq)
  if type(tech_name) == "table" then
    for i=1, #tech_name do
      remove_prereq(tech_name[i], prereq)
    end
    return
  end
  local tech = data.raw["technology"][tech_name]
  local tech_prereqs = tech.prerequisites
  if #tech_prereqs == 0 then return end

  local prereq_transformation = {}
  if type(prereq) == "string" then
    prereq_transformation[prereq] = true
  elseif #prereq > 0 then
    for i=1, #prereq do
      prereq_transformation[prereq[i]] = true
    end
  end

  local new_prereqs = {}
  for _, p in pairs(tech_prereqs) do
    if prereq_transformation[p] == nil then
      table.insert(new_prereqs, p)
    end
  end
  tech.prerequisites = new_prereqs
end

--item name can be string or table of strings
local function recycle_to_ingredients(item_name)
  local results = {}
  for _, ingredient in pairs(data.raw["recipe"][item_name].ingredients) do
    if ingredient.type == "item" then
      table.insert(results, {
        type = "item",
        name = ingredient.name,
        amount = ingredient.amount,
        probability = 0.25
      })
    end
  end
  data.raw["recipe"][item_name .. "-recycling"].results = results
end

--item name can be string or table of strings
local function recycle_to_self(item_name)
  data.raw["recipe"][item_name .. "-recycling"].results =
  {{type = "item", name = item_name, amount = 1, probability = 0.25}}
end

local function mod_override_setting(mod_name, setting_name)
  if mods[mod_name] then
    data:extend({
      {
        type = "bool-setting",
        name = setting_name,
        setting_type = "startup",
        default_value = true
      },
    })
  end
end

local function mod_override_require(mod_name, setting_name, require_name)
  if mods[mod_name] and settings.startup[setting_name].value then
    require(require_name)
  end
end



return {
  add_entity_drop = add_entity_drop, --entity_type, entity_name, drop_name, amount
  remove_entity_drop = remove_entity_drop, --entity_type, entity_name, drop_name
  add_ingredient = add_ingredient, --recipe_name, ingredient_type, ingredient_name, amount
  add_ingredient_table = add_ingredient_table, --recipe_table, ingredient_type, ingredient_name
  remove_ingredient = remove_ingredient, --recipe_name, ingredient_name
  add_recipe_unlock = add_recipe_unlock, --tech_name, recipe
  remove_recipe_unlock = remove_recipe_unlock, --tech_name, recipe
  add_prereq = add_prereq, --tech_name, prereq
  remove_prereq = remove_prereq, --tech_name, prereq
  recycle_to_ingredients = recycle_to_ingredients, --item_name
  recycle_to_self = recycle_to_self, --item_name
  mod_override_setting = mod_override_setting, --mod_name, setting_name
  mod_override_require =mod_override_require, --mod_name, setting_name, require_name
}
