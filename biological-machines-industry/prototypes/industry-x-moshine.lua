local dh = require("__biological-machines-core__.data-helper")



dh.add_prereq("moshine-tech-data-processor-building", "utility-science-pack")



--MULTI ORE
data.raw.resource["multi-ore_dummy_neodymium"].icon = "__biological-machines-industry__/graphics/multi-ore-new.png"

local sand_dummy = data.raw.resource["multi-ore_dummy_sand"]
sand_dummy.icon = "__biological-machines-industry__/graphics/multi-ore-new.png"
sand_dummy.minable.results = {{type = "item", name = "bm-sand", amount = 1, independent_probability = 1 /1000}}

local multi_ore = data.raw.resource["multi-ore"]
multi_ore.icon = "__biological-machines-industry__/graphics/multi-ore-new.png"
multi_ore.minable.results = {
  {type = "item", name = "bm-sand", amount = 1, independent_probability = 28 /100},
  {type = "item", name = "neodymium", amount = 1020, independent_probability = 0.003 /100},
  {type = "item", name = "coal", amount = 1, independent_probability = 20 /100},
  {type = "item", name = "iron-ore", amount = 1, independent_probability = 4 /100},
  {type = "item", name = "copper-ore", amount = 1, independent_probability = 8 /100},
  { type = "item", name = "bm-lime", amount = 1, independent_probability = 2 /100},
}



--SAND/GLASS
dh.remove_ingredient("silicon", "sand")
dh.add_ingredient("silicon", "item", "bm-sand", 5)

data.raw.item["sand"].hidden = true

data.raw.item["glass"].hidden = true
data.raw.recipe["glass"].hidden = true
data.raw.technology["moshine-tech-glass"].hidden = true

dh.remove_prereq("moshine-tech-data-extractor", "moshine-tech-glass")

dh.remove_ingredient("optical-cable", "glass")
dh.add_ingredient("optical-cable", "item", "bm-glass-plate", 1)

dh.remove_ingredient("ai-trainer", "glass")
dh.add_ingredient("ai-trainer", "item", "bm-glass-plate", 100)

dh.remove_ingredient("3d-data-storage", "glass")
dh.add_ingredient("3d-data-storage", "item", "bm-glass-plate", 5)



--STONE BRICK
data.raw.recipe["concrete-from-molten-iron-and-sand"].hidden = true
data.raw.technology["moshine-concrete-from-molten-iron-and-sand"].hidden = true

dh.remove_prereq("moshine-tech-cosmicscanner-construction1", "moshine-concrete-from-molten-iron-and-sand")

data:extend({
  {
    type = "recipe",
    name = "bm-brick-from-sand",
    icons = {
      {
        icon = "__base__/graphics/icons/stone-brick.png",
        --scale = 0.4,
        shift = {0, -4},
      },
      {
        --icon = "__biological-machines-industry__/graphics/cement-mix.png",
        icon = "__base__/graphics/icons/fluid/water.png",
        scale = 0.25,
        shift = {-8, 8},
        draw_background = true,
      },
      {
        icon = "__biological-machines-k2-assets__/graphics/sand.png",
        scale = 0.25,
        shift = {8, 8},
        draw_background = true,
      },
    },
    categories = {"crafting-with-fluid"},
    --subgroup = "bm-wit-processes",
    --order = "c-d",
    subgroup = "terrain",
    order = "a[stone-brick]-b",
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 4,
    ingredients = {
      {type = "fluid", name = "water", amount = 10},
      {type = "item", name = "bm-cement-mix", amount = 1},
      {type = "item", name = "bm-sand", amount = 4},
    },
    results = {{type = "item", name = "stone-brick", amount = 2}},
  },
})

dh.add_recipe_unlock("planet-discovery-moshine", "bm-brick-from-sand")



--PETROLEUM
data.raw.recipe["petroleum-from-sand-sulfur-steam-carbon"].hidden = true
data.raw.technology["moshine-petroleum-from-sand-sulfur-steam-carbon"].hidden = true

data:extend({
  {
    type = "recipe",
    name = "bm-heavy-oil-steam-cracking",
    categories = {"chemistry"},
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {type = "fluid", name = "steam", amount = 30},
      {type = "fluid", name = "heavy-oil", amount = 40},
    },
    results =
    {
      {type = "fluid", name = "light-oil", amount = 20},
      {type = "item", name = "bm-tar", amount = 1, independent_probability = 0.25},
    },
    allow_productivity = true,
    main_product = "",
    icons = {
      {
        icon = "__base__/graphics/icons/fluid/steam.png",
        scale = 0.3,
        shift = {0, -4},
      },
      {
        icon = "__base__/graphics/icons/fluid/heavy-oil-cracking.png",
        scale = 0.4,
        shift = {0, 3},
        draw_background = true,
      },
    },
    subgroup = "moshine-processes",
    order = "ga",
    crafting_machine_tint =
    {
      primary = {r = 1.000, g = 0.642, b = 0.261, a = 1.000}, -- #ffa342ff
      secondary = {r = 1.000, g = 0.722, b = 0.376, a = 1.000}, -- #ffb85fff
      tertiary = {r = 0.854, g = 0.659, b = 0.576, a = 1.000}, -- #d9a892ff
      quaternary = {r = 1.000, g = 0.494, b = 0.271, a = 1.000}, -- #ff7e45ff
    },
    surface_conditions = {{property = "pressure", min = 701, max = 701}},
  },

  {
    type = "recipe",
    name = "bm-light-oil-steam-cracking",
    categories = {"chemistry"},
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {type = "fluid", name = "steam", amount = 30},
      {type = "fluid", name = "light-oil", amount = 30},
    },
    results =
    {
      {type = "fluid", name = "petroleum-gas", amount = 10},
      {type = "item", name = "bm-tar", amount = 1, independent_probability = 0.5},
    },
    allow_productivity = true,
    main_product = "",
    icons = {
      {
        icon = "__base__/graphics/icons/fluid/steam.png",
        scale = 0.3,
        shift = {0, -4},
      },
      {
        icon = "__base__/graphics/icons/fluid/light-oil-cracking.png",
        scale = 0.4,
        shift = {0, 3},
        draw_background = true,
      },
    },
    subgroup = "moshine-processes",
    order = "gb",
    crafting_machine_tint =
    {
      primary = {r = 0.764, g = 0.596, b = 0.780, a = 1.000}, -- #c298c6ff
      secondary = {r = 0.762, g = 0.551, b = 0.844, a = 1.000}, -- #c28cd7ff
      tertiary = {r = 0.895, g = 0.773, b = 0.596, a = 1.000}, -- #e4c597ff
      quaternary = {r = 1.000, g = 0.734, b = 0.290, a = 1.000}, -- #ffbb49ff
    },
    surface_conditions = {{property = "pressure", min = 701, max = 701}},
  },
  {
    type = "recipe",
    name = "bm-plastic-from-carbon",
    categories = {"chemistry"},
    icons = {
      {
        icon = "__space-age__/graphics/icons/carbon.png",
        scale = 0.25,
        shift = {8, -9}
      },
      {
        icon = "__base__/graphics/icons/plastic-bar.png",
        --shift = {0, -4},
        draw_background = true,
      },
    },
    subgroup = "moshine-processes",
    order = "g",
    enabled = false,
    ingredients = {
      {type = "fluid", name = "steam", amount = 20},
      {type = "fluid", name = "petroleum-gas", amount = 8},
      {type = "item", name = "carbon", amount = 2},
    },
    energy_required = 1,
    results = {
      {type = "item", name = "plastic-bar", amount = 2},
    },
    allow_decomposition = false,
    auto_recycle = false,
    allow_productivity = true,
    surface_conditions = {{property = "pressure", min = 701, max = 701}},
  },
})

dh.add_recipe_unlock("planet-discovery-moshine", "bm-heavy-oil-steam-cracking")
dh.add_recipe_unlock("planet-discovery-moshine", "bm-light-oil-steam-cracking")
dh.add_recipe_unlock("planet-discovery-moshine", "bm-plastic-from-carbon")



--MAGNET
if data.raw.item["long-stack-inserter"] then
  dh.add_ingredient("long-stack-inserter", "item", "magnet", 2)
end

--[[
local add_magnet = {
  [""] = 2,
}
dh.add_ingredient_table(add_magnet, "item", "magnet")
]]
