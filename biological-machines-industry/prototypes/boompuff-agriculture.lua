local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local entity_sounds = require("__base__.prototypes.entity.sounds")
local dh = require("__biological-machines-core__.data-helper")



--------------------------------------------------------BOOMPUFF
--ENTITIES
local tight_explosion = util.table.deepcopy(data.raw["explosion"]["boompuff-explosion"])
tight_explosion.name = "bm-tight-boompuff-explosion"
tight_explosion.created_effect.distance = 0.5 --base 3
tight_explosion.created_effect.distance_deviation = 0.5 --base 2

data.raw["tree"]["boompuff"].minable.results = {
  {type = "item", name = "wood", amount = 4},
  {type = "item", name = "bm-puff-sac", amount = 3}
}
local boompuff_plant = util.table.deepcopy(data.raw["tree"]["boompuff"])
boompuff_plant.type = "plant"
boompuff_plant.name = "bm-boompuff-plant"
boompuff_plant.surface_conditions = {{property = "pressure", min = 2000, max = 2000}}
boompuff_plant.autoplace = {
  probability_expression = 0,
  tile_restriction = {
    "midland-yellow-crust", "midland-yellow-crust-2",
    "midland-yellow-crust-3", "midland-yellow-crust-4"
  }
}
boompuff_plant.growth_ticks = 10 * minute
boompuff_plant.harvest_emissions = {spores = 15}
boompuff_plant.dying_explosion = {name = "bm-tight-boompuff-explosion"}
boompuff_plant.remains_when_mined = "bm-tight-boompuff-explosion"
boompuff_plant.agricultural_tower_tint = {
      primary = {r = 0.968, g = 0.381, b = 0.259, a = 1.000}, -- #f66142ff
      secondary = {r = 1.000, g = 0.978, b = 0.513, a = 1.000}, -- #fff982ff
}
boompuff_plant.created_effect = nil

local sac_projectile = util.table.deepcopy(data.raw["projectile"]["grenade"])
sac_projectile.name = "bm-puff-sac"
sac_projectile.animation.filename = "__biological-machines-industry__/graphics/boompuff-grenade.png"
sac_projectile.action = {{
  type = "direct",
  action_delivery = {
    type = "instant",
    target_effects = {{
      type = "create-entity",
      entity_name = "bm-tight-boompuff-explosion"
    }}
  }
}}

data:extend({
  tight_explosion, boompuff_plant, sac_projectile,

  --ITEMS
  {
    type = "capsule",
    name = "bm-puff-sac",
    icon = "__biological-machines-industry__/graphics/puff-sac.png",
    subgroup = "agriculture-processes",
    order = "b[agriculture]-f",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,
    default_import_location = "gleba",

    capsule_action = {
      type = "throw",
      attack_parameters = {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "grenade",
        cooldown = 30,
        projectile_creation_distance = 0.6,
        range = 20,
        ammo_type = {
          target_type = "position",
          action = {
            {
              type = "direct",
              action_delivery = {
                type = "projectile",
                projectile = "bm-puff-sac",
                starting_speed = 0.2
              }
            },
            {
              type = "direct",
              action_delivery = {
                type = "instant",
                target_effects = {
                  {
                    type = "play-sound",
                    sound = entity_sounds.throw_projectile
                  },
                  {
                    type = "play-sound",
                    sound = space_age_item_sounds.agriculture_inventory_move
                  }
                }
              }
            }
          }
        }
      }
    },

    spoil_ticks = 10 * minute,
    spoil_to_trigger_result = {
      items_per_trigger = 1,
      trigger = {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {{
            type = "create-entity",
            entity_name = "bm-tight-boompuff-explosion"
          }}
        }
      },
    },
  },
  {
    type = "item",
    name = "bm-puff-seed",
    localised_name = {"item-name.bm-puff-seed"},
    icon = "__biological-machines-industry__/graphics/puff-seed.png",
    subgroup = "agriculture-processes",
    order = "a[seeds]-f-b",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,
    default_import_location = "gleba",

    fuel_category = "chemical",
    fuel_value = "1MJ",

    plant_result = "bm-boompuff-plant",
    place_result = "bm-boompuff-plant"
  },
  {
    type = "fluid",
    name = "bm-puff-gas",
    icon = "__biological-machines-industry__/graphics/puff-gas.png",
    subgroup = "fluid",
    default_temperature = 25,
    base_color = {1.0, 0.978, 0.513},
    flow_color = {0.968, 0.381, 0.259}
  },

  --RECIPES
  {
    type = "recipe",
    name = "bm-puff-seed",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/puff-gas.png",
      },
      {
        icon = "__biological-machines-industry__/graphics/puff-seed.png",
        scale = 0.4,
      },
    },
    category = "organic-or-chemistry",
    subgroup = "agriculture-processes",
    order = "a[seeds]-f-a",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-puff-sac", amount = 1}
    },
    results = {
      {type = "item", name = "spoilage", amount = 5},
      {type = "item", name = "bm-puff-seed", amount = 1},
      {type = "fluid", name = "bm-puff-gas", amount = 50}
    },
    crafting_machine_tint = {
      primary = {r = 0.968, g = 0.381, b = 0.259, a = 1.000}, -- #f66142ff
      secondary = {r = 1.000, g = 0.978, b = 0.513, a = 1.000}, -- #fff982ff
    },
    primary_result = "bm-puff-seed",
  },
  {
    type = "recipe",
    name = "bm-grenade-from-puff-gas",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/puff-gas.png",
      },
      {
        icon = "__base__/graphics/icons/grenade.png",
        scale = 0.3,
      },
    },
    --icon = "__biological-machines-industry__/graphics/grenade-from-puff-gas.png",
    category = "crafting-with-fluid",
    subgroup = "capsule",
    auto_recycle = false,
    enabled = false,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 5},
      {type = "fluid", name = "bm-puff-gas", amount = 20}
    },
    results = {
      {type = "item", name = "grenade", amount = 1}
    },
    crafting_machine_tint = {
      primary = {r = 0.968, g = 0.381, b = 0.259, a = 1.000}, -- #f66142ff
      secondary = {r = 1.000, g = 0.978, b = 0.513, a = 1.000}, -- #fff982ff
    }
  },
  {
    type = "recipe",
    name = "bm-explosives-from-puff-gas",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/puff-gas.png",
      },
      {
        icon = "__base__/graphics/icons/explosives.png",
        scale = 0.3,
      },
    },
    --icon = "__biological-machines-industry__/graphics/explosives-from-puff-gas.png",
    category = "organic-or-chemistry",
    subgroup = "agriculture-products",
    order = "f",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 4,
    ingredients = {
      {type = "item", name = "plastic-bar", amount = 1},
      {type = "item", name = "carbon", amount = 1},
      {type = "fluid", name = "bm-puff-gas", amount = 50}
    },
    results = {
      {type = "item", name = "explosives", amount = 2}
    },
    crafting_machine_tint = {
      primary = {r = 0.968, g = 0.381, b = 0.259, a = 1.000}, -- #f66142ff
      secondary = {r = 1.000, g = 0.978, b = 0.513, a = 1.000}, -- #fff982ff
    }
  },
  {
    type = "recipe",
    name = "bm-seed-oil-from-puffs",
    icons = {
      {
        icon = "__biological-machines-industry__/graphics/seed-oil.png",
        scale = 0.4,
        shift = {0, 3}
      },
      {
        icon = "__biological-machines-industry__/graphics/puff-seed.png",
        scale = 0.45,
        shift = {0, -10}
      },
    },
    category = "crafting-with-fluid",
    subgroup = "bm-biological-fluid-recipes",
    order = "a-g",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "bm-puff-seed", amount = 2}
    },
    results = {
      {type = "fluid", name = "bm-seed-oil", amount = 10},
      {type = "item", name = "spoilage", amount = 2}
    }
  },

  --TECHNOLOGY
  {
    type = "technology",
    name = "bm-boompuff",
    icon = "__biological-machines-industry__/graphics/boompuff-research.png",
    icon_size = 256,
    effects = {
      {type = "unlock-recipe", recipe = "bm-puff-seed"},
      {type = "unlock-recipe", recipe = "bm-grenade-from-puff-gas"},
      {type = "unlock-recipe", recipe = "bm-explosives-from-puff-gas"},
      {type = "unlock-recipe", recipe = "bm-napalm"},
      {type = "unlock-recipe", recipe = "bm-napalm-ammo"}
    },
    prerequisites = {"production-science-pack", "agricultural-science-pack"},
    unit = {
      count = 1000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"agricultural-science-pack", 1}
      },
      time = 60
    }
  }
})



---------------------------------------------------------FLAMETHROWER AMMO
--ENTITIES
local hand_stream_2 = util.table.deepcopy(data.raw["stream"]["handheld-flamethrower-fire-stream"])
hand_stream_2.name = "bm-handheld-flamethrower-fire-stream-2"
hand_stream_2.action[1].action_delivery.target_effects[2].damage.amount = 2.25 --base 2

local tank_stream_2 = util.table.deepcopy(data.raw["stream"]["tank-flamethrower-fire-stream"])
tank_stream_2.name = "bm-tank-flamethrower-fire-stream-2"
tank_stream_2.action[1].action_delivery.target_effects[1].damage.amount = 7.875 --base 7

local hand_stream_3 = util.table.deepcopy(data.raw["stream"]["handheld-flamethrower-fire-stream"])
hand_stream_3.name = "bm-handheld-flamethrower-fire-stream-3"
hand_stream_3.action[1].action_delivery.target_effects[2].damage.amount = 3 --base 2

local tank_stream_3 = util.table.deepcopy(data.raw["stream"]["tank-flamethrower-fire-stream"])
tank_stream_3.name = "bm-tank-flamethrower-fire-stream-3"
tank_stream_3.action[1].action_delivery.target_effects[1].damage.amount = 10.5 --base 7

flamethrower_fluids = data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids
table.insert(flamethrower_fluids, {type = "bm-napalm", damage_modifier = 1.35})

data:extend({hand_stream_2, tank_stream_2, hand_stream_3, tank_stream_3})

--ITEMS
local crude_ammo = data.raw["ammo"]["flamethrower-ammo"]

local light_ammo = util.table.deepcopy(crude_ammo)
light_ammo.name = "bm-light-oil-ammo"
light_ammo.icon = "__biological-machines-industry__/graphics/light-oil-ammo.png"
light_ammo.order = "e[flamethrower]-a"
light_ammo.ammo_type[1].action.action_delivery.stream = "bm-handheld-flamethrower-fire-stream-2"
light_ammo.ammo_type[2].action.action_delivery.stream = "bm-tank-flamethrower-fire-stream-2"

local napalm_ammo = util.table.deepcopy(crude_ammo)
napalm_ammo.name = "bm-napalm-ammo"
napalm_ammo.icon = "__biological-machines-industry__/graphics/napalm-ammo.png"
napalm_ammo.order = "e[flamethrower]-b"
napalm_ammo.default_import_location = "gleba"
napalm_ammo.ammo_type[1].action.action_delivery.stream = "bm-handheld-flamethrower-fire-stream-3"
napalm_ammo.ammo_type[2].action.action_delivery.stream = "bm-tank-flamethrower-fire-stream-3"

crude_ammo.icon = "__biological-machines-industry__/graphics/crude-oil-ammo.png"

data:extend({
  light_ammo, napalm_ammo,
  {
    type = "fluid",
    name = "bm-napalm",
    icon = "__biological-machines-industry__/graphics/napalm.png",
    subgroup = "fluid",
    default_temperature = 25,
    base_color = {0.91, 0.27, 0.0},
    flow_color = {1.0, 0.72, 0.5}
  }
})

--RECIPES
local crude_ammo_recipe = data.raw["recipe"]["flamethrower-ammo"]
crude_ammo_recipe.ingredients = {
  {type = "item", name = "steel-plate", amount = 2},
  {type = "fluid", name = "crude-oil", amount = 100}
}

local light_ammo_recipe = util.table.deepcopy(crude_ammo_recipe)
light_ammo_recipe.name = "bm-light-oil-ammo"
light_ammo_recipe.icon = "__biological-machines-industry__/graphics/light-oil-ammo.png"
light_ammo_recipe.ingredients = {
  {type = "item", name = "steel-plate", amount = 2},
  {type = "fluid", name = "light-oil", amount = 100}
}
light_ammo_recipe.results = {{type = "item", name = "bm-light-oil-ammo", amount = 1}}
light_ammo_recipe.crafting_machine_tint = {
  primary = {1, 0.73, 0.07},
  secondary = {0.57, 0.33, 0}
}

local napalm_ammo_recipe = util.table.deepcopy(crude_ammo_recipe)
napalm_ammo_recipe.name = "bm-napalm-ammo"
napalm_ammo_recipe.icon = "__biological-machines-industry__/graphics/napalm-ammo.png"
napalm_ammo_recipe.ingredients = {
  {type = "item", name = "steel-plate", amount = 2},
  {type = "fluid", name = "bm-napalm", amount = 100}
}
napalm_ammo_recipe.results = {{type = "item", name = "bm-napalm-ammo", amount = 1}}
napalm_ammo_recipe.crafting_machine_tint = {
  primary = {1.0, 0.72, 0.5},
  secondary = {0.91, 0.27, 0.0}
}

data:extend({
  light_ammo_recipe, napalm_ammo_recipe,
  {
    type = "recipe",
    name = "bm-napalm",
    icon = "__biological-machines-industry__/graphics/napalm.png",
    category = "organic-or-chemistry",
    subgroup = "bm-biological-fluid-recipes",
    order = "c-b",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    allow_decomposition = false,
    energy_required = 2,
    ingredients = {
      {type = "fluid", name = "light-oil", amount = 50},
      {type = "fluid", name = "bm-puff-gas", amount = 35},
      {type = "item", name = "jelly", amount = 10}
    },
    results = {
      {type = "fluid", name = "bm-napalm", amount = 50}
    },
    crafting_machine_tint = {
      primary = {0.91, 0.27, 0.0},
      secondary = {1.0, 0.72, 0.5}
    }
  }
})

--TECHNOLOGY
dh.add_recipe_unlock("flamethrower", "bm-light-oil-ammo")
