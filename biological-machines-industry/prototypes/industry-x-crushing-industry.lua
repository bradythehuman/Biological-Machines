local dh = require("__biological-machines-core__.data-helper")


data.raw.recipe["bm-slag-crushing"].icon = nil
data.raw.recipe["bm-slag-crushing"].icons = CrushingIndustry.make_crushing_icons("bm-slag")

data.raw.recipe["bm-stone-crushing"].icon = nil
data.raw.recipe["bm-stone-crushing"].icons = data.raw.recipe["sand"].icons
data.raw.item["sand"] = nil
data.raw.recipe["sand"] = nil
dh.remove_recipe_unlock("steam-power", "sand")

local remove_sand = {"holmium-solution", "electrolyte"}
dh.remove_ingredient(remove_sand, "sand")
local add_sand = {
  ["holmium-solution"] = 2,
  ["electrolyte"] = 1
}
dh.add_ingredient_table(add_sand, "item", "bm-sand")

data.raw.recipe["bm-stone-crushing"].category = "basic-crushing"
data.raw.recipe["bm-slag-crushing"].category = "basic-crushing"



local function crushing_recipe(recipe_name, energy, input_name, output_name)
  local recipe_prototype = data.raw.recipe[recipe_name]
  recipe_prototype.energy_required = energy
  recipe_prototype.ingredients = {{type = "item", name = input_name, amount = 20}}
  recipe_prototype.results = {
    {type = "item", name = input_name, amount = 4},
    {type = "item", name = output_name, amount = 20},
  }
end



-----------------------------------------------------------------ORE CRUSHING
if settings.startup["crushing-industry-ore"].value then
  crushing_recipe("crushed-iron-ore", 10, "iron-ore", "crushed-iron-ore")
  crushing_recipe("crushed-copper-ore", 10, "copper-ore", "crushed-copper-ore")
  crushing_recipe("holmium-powder", 10, "holmium-ore", "holmium-powder")
  crushing_recipe("crushed-tungsten-ore", 25, "tungsten-ore", "crushed-tungsten-ore")

  dh.add_recipe_unlock("ore-crushing", "electric-crusher")

  dh.remove_recipe_unlock("advanced-material-processing", "bm-slag-crushing")
  dh.add_recipe_unlock("ore-crushing", "bm-slag-crushing")

  dh.remove_recipe_unlock("ore-crushing", "crushed-iron-ore")
  dh.add_recipe_unlock("steel-processing", "crushed-iron-ore")

  data.raw.recipe["bm-steel-mix"].category = "crafting"
  dh.remove_ingredient("bm-steel-mix", "iron-ore")
  dh.add_ingredient("bm-steel-mix", "item", "crushed-iron-ore", 5)

  data.raw.recipe["bm-cement-mix"].category = "crafting"
  dh.remove_ingredient("bm-cement-mix", "iron-ore")
  dh.add_ingredient("bm-cement-mix", "item", "crushed-iron-ore", 1)

  dh.remove_ingredient("concrete", "crushed-iron-ore")

  dh.add_ingredient("molten-iron", "item", "crushed-iron-ore", 50)
  dh.add_ingredient("molten-copper", "item", "crushed-copper-ore", 50)
  dh.add_ingredient("holmium-solution", "item", "holmium-powder", 2)
  dh.add_ingredient("crushed-tungsten-carbide", "item", "crushed-tungsten-ore", 2)
  dh.add_ingredient("tungsten-plate", "item", "crushed-tungsten-ore", 4)

  table.insert(BM_ADD_SLAG, {name = "crushed-iron-smelting", prob = 0.01})
  table.insert(BM_ADD_SLAG, {name = "crushed-copper-smelting", prob = 0.01})

  --BIG CRUSHER
  if settings.startup["crushing-industry-big-crusher"].value then
    data:extend({{type = "recipe-category", name = "hard-crushing"}})
    data.raw.recipe["crushed-tungsten-ore"].category = "hard-crushing"

    local big_crusher = data.raw["assembling-machine"]["big-crusher"]
    big_crusher.crafting_categories = util.table.deepcopy(big_crusher.crafting_categories)
    table.insert(big_crusher.crafting_categories, "hard-crushing")

    --[[
    local new_categories = {}
    for _, category_name in pairs(data.raw["assembling-machine"]["big-crusher"].crafting_categories) do
      if category_name ~= "crushing" then
        table.insert(new_categories, category_name)
      end
    end
    table.insert(new_categories, "hard-crushing")
    data.raw["assembling-machine"]["big-crusher"].crafting_categories = new_categories
    ]]
  end
end



---------------------------------------------------------------BIG CRUSHER
if settings.startup["crushing-industry-big-crusher"].value then
  --data.raw["assembling-machine"]["big-crusher"].module_slots = 2
end



-----------------------------------------------------------------COAL CRUSHING
if settings.startup["crushing-industry-coal"].value then
  crushing_recipe("crushed-coal", 10, "coal", "crushed-coal")

  data.raw.recipe["crushed-grenade"] = nil
  dh.remove_recipe_unlock("oil-processing", "crushed-grenade")

  dh.add_ingredient("coal-liquefaction", "item", "crushed-coal", 10)
  dh.add_ingredient("plastic-bar", "item", "crushed-coal", 1)
  dh.add_ingredient("explosives", "item", "crushed-coal", 1)
  dh.add_ingredient("carbon", "item", "crushed-coal", 2)
  dh.add_ingredient("slowdown-capsule", "item", "crushed-coal", 5)

  if not mods["biological-machines-radioactive-tissue"] then
    dh.add_ingredient("poison-capsule", "item", "crushed-coal", 10)
  end
end



-----------------------------------------------------------------OPTICAL FIBER
if settings.startup["crushing-industry-optical-fiber"].value then
  data:extend({
    {
      type = "item",
      name = "optical-fiber",
      icon = "__crushing-industry__/graphics/icons/optical-fiber.png",
      subgroup = "intermediate-product",
      order = "a[basic-intermediates]-c[copper-cable]b",
      stack_size = 50,
      weight = 10 * kg,
    },
		{
			type = "recipe",
			name = "optical-fiber",
			category = "electronics-or-assembling",
			enabled = false,
			allow_productivity = true,
			energy_required = 2,
			ingredients = {
				{type="item", name="plastic-bar", amount=1},
				{type="item", name="copper-plate", amount=2},
				{type="item", name="bm-glass-plate", amount=2}
			},
			results = {{type="item", name="optical-fiber", amount=4}}
		}
	})

  dh.add_recipe_unlock("plastics", "optical-fiber")

  dh.add_ingredient("advanced-circuit", "item", "plastic-bar", 1)
  dh.add_ingredient("processing-unit", "item", "electronic-circuit", 15)

  local remove_iron_plate = {"advanced-circuit", "beacon"}
  dh.remove_ingredient(remove_iron_plate, "copper-cable")

  local add_optical = {
    ["advanced-circuit"] = 4,
    ["processing-unit"] = 5,
    ["selector-combinator"] = 5,
    ["roboport"] = 45,
    ["personal-roboport-equipment"] = 10,
    ["beacon"] = 10,
  }
  dh.add_ingredient_table(add_optical, "item",  "optical-fiber")
end
