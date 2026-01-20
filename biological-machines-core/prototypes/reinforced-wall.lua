local item_sounds = require("__base__.prototypes.item_sounds")



----------------------------------------------------------ENTITIES
--local reinforced_tint = {0.95, 0.80, 1}
--local reinforced_tint = {0.45, 0.4, 0.5}
local reinforced_tint = {0.55, 0.5, 0.6}
local wall_pictures_names = {
  "single", "straight_vertical", "straight_horizontal",
  "corner_right_down", "corner_left_down", "t_up",
  "ending_right", "ending_left",
}

local reinforced_wall_entity = util.table.deepcopy(data.raw["wall"]["stone-wall"])
reinforced_wall_entity.name = "bm-reinforced-wall"
reinforced_wall_entity.icon = nil
reinforced_wall_entity.icons = {{
  icon = "__base__/graphics/icons/wall.png",
  tint = reinforced_tint,
}}
reinforced_wall_entity.minable = {mining_time = 0.2, result = "bm-reinforced-wall"}
reinforced_wall_entity.repair_speed_modifier = 5
reinforced_wall_entity.max_health = 1250

for _, picture_name in pairs(wall_pictures_names) do
  reinforced_wall_entity.pictures[picture_name].layers[1].tint = reinforced_tint
end
reinforced_wall_entity.pictures["filling"].tint = reinforced_tint
reinforced_wall_entity.pictures["water_connection_patch"].sheets[1].tint = reinforced_tint
reinforced_wall_entity.pictures["gate_connection_patch"].sheets[1].tint = reinforced_tint



local gate_pictures_names = {
  "vertical_animation", "horizontal_animation",
  "horizontal_rail_animation_left", "horizontal_rail_animation_right",
  "vertical_rail_animation_left", "vertical_rail_animation_right",
  "wall_patch",
}

local reinforced_gate_entity = util.table.deepcopy(data.raw["gate"]["gate"])
reinforced_gate_entity.name = "bm-reinforced-gate"
reinforced_gate_entity.icon = nil
reinforced_gate_entity.icons = {{
  icon = "__base__/graphics/icons/gate.png",
  tint = reinforced_tint,
}}
reinforced_gate_entity.minable = {mining_time = 0.2, result = "bm-reinforced-gate"}
reinforced_gate_entity.repair_speed_modifier = 5
reinforced_gate_entity.max_health = 1250
reinforced_gate_entity.opening_speed = 0.1

for _, picture_name in pairs(gate_pictures_names) do
  reinforced_gate_entity[picture_name].layers[1].tint = reinforced_tint
end



data:extend({
  reinforced_wall_entity, reinforced_gate_entity,

  ----------------------------------------------------------ITEMS
  {
    type = "item",
    name = "bm-reinforced-wall",
    icons = {{
      icon = "__base__/graphics/icons/wall.png",
      tint = reinforced_tint,
    }},
    subgroup = "defensive-structure",
    order = "a[wall]-b[gate]-a",
    inventory_move_sound = item_sounds.concrete_inventory_move,
    pick_sound = item_sounds.concrete_inventory_pickup,
    drop_sound = item_sounds.concrete_inventory_move,
    place_result = "bm-reinforced-wall",
    stack_size = 100,
    weight = 20 * kg,
  },
  {
    type = "item",
    name = "bm-reinforced-gate",
    icons = {{
      icon = "__base__/graphics/icons/gate.png",
      tint = reinforced_tint,
    }},
    subgroup = "defensive-structure",
    order = "a[wall]-b[gate]-b",
    inventory_move_sound = item_sounds.concrete_inventory_move,
    pick_sound = item_sounds.concrete_inventory_pickup,
    drop_sound = item_sounds.concrete_inventory_move,
    place_result = "bm-reinforced-gate",
    stack_size = 50,
    weight = 40 * kg,
  },

  --------------------------------------------------------RECIPES
  {
    type = "recipe",
    name = "bm-reinforced-wall",
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "refined-concrete", amount = 5},
      {type = "item", name = "tungsten-plate", amount = 1},
    },
    results = {{type = "item", name = "bm-reinforced-wall", amount = 1}}
  },
  {
    type = "recipe",
    name = "bm-reinforced-gate",
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-reinforced-wall", amount = 1},
      {type = "item", name = "tungsten-plate", amount = 1},
      {type = "item", name = "electronic-circuit", amount = 2},
    },
    results = {{type = "item", name = "bm-reinforced-gate", amount = 1}}
  },

  ------------------------------------------------------TECHNOLOGY
  {
    type = "technology",
    name = "bm-reinforced-wall",
    icons = {{
      icon = "__base__/graphics/technology/stone-wall.png",
      icon_size = 256,
      tint = reinforced_tint,
    }},
    effects = {
      {type = "unlock-recipe", recipe = "bm-reinforced-wall"},
      {type = "unlock-recipe", recipe = "bm-reinforced-gate"},
    },
    prerequisites = {"gate", "military-3", "metallurgic-science-pack"},
    unit =   {
      count = 500,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
      },
      time = 60
    }
  },
})
