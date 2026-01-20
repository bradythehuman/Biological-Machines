local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



data.raw["capsule"]["poison-capsule"].capsule_action.attack_parameters.ammo_category = "bm-poison"

local poison_rounds = util.table.deepcopy(data.raw["ammo"]["piercing-rounds-magazine"])
poison_rounds.name = "bm-poison-rounds-magazine"
poison_rounds.icon = "__biological-machines-radioactive-tissue__/graphics/poison-rounds-magazine.png"
table.insert(poison_rounds.ammo_type.action.action_delivery.target_effects, {type = "damage", damage = {amount = 12, type = "poison"}})
poison_rounds.order = "a[basic-clips]-b[piercing-rounds-magazine]-a"
poison_rounds.ammo_category = "bm-poison-bullet"

local poison_mine = util.table.deepcopy(data.raw["item"]["land-mine"])
poison_mine.name = "bm-poison-mine"
poison_mine.icon = "__biological-machines-radioactive-tissue__/graphics/poison-mine.png"
poison_mine.place_result = "bm-poison-mine"

local bullet_munchers = {"pistol", "submachine-gun", "vehicle-machine-gun", "tank-machine-gun"}
for _, muncher in pairs(bullet_munchers) do
  local attack_parameters = data.raw["gun"][muncher].attack_parameters
  attack_parameters.ammo_categories = {"bullet", "bm-poison-bullet"}
  attack_parameters.ammo_category = nil
end
local attack_parameters = data.raw["ammo-turret"]["gun-turret"].attack_parameters
attack_parameters.ammo_categories = {"bullet", "bm-poison-bullet"}
attack_parameters.ammo_category = nil

local u_235 = data.raw["item"]["uranium-235"]
u_235.fuel_category = "bm-radioactive-mineral"
u_235.fuel_value = "4GJ" --1 u-235 = 40GJ in reactor w/o neighbor bonus (assuming reprocessing)

data:extend({
  poison_rounds, poison_mine,
  {
    type = "item",
    name = "bm-radioactive-tissue",
    icon = "__biological-machines-radioactive-tissue__/graphics/radioactive-tissue.png",
    subgroup = "bm-cultivation",
    order = "c-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 100 * kg,

    fuel_category = "chemical",
    fuel_value = "1GJ", --16GJ in heating tower == fuel cell w/o neighbor bonus (in power per uranium)
    fuel_emissions_multiplier = 2,

    spoil_ticks = 1 * hour,
  },
  {
    type = "item",
    name = "bm-hardened-tissue",
    icon = "__biological-machines-radioactive-tissue__/graphics/hardened-tissue.png",
    subgroup = "bm-cultivation",
    order = "c-c",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 10,
    weight = 100 * kg,

    spoil_ticks = 1 * minute,
    spoil_result = "uranium-235"
  },
  {
    type = "tool",
    name = "bm-nuclear-military-science-pack",
    icon = "__biological-machines-radioactive-tissue__/graphics/nuclear-military-science-pack.png",
    subgroup = "science-pack",
    order = "g[space-science-pack]-a",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    weight = 1 * kg,
    durability = 1
  },
  {
    type = "fluid",
    name = "bm-poison",
    icon = "__biological-machines-radioactive-tissue__/graphics/poison.png",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2kJ",
    base_color = {0.05, 0.35, 0.40},
    flow_color = {0.1, 0.65, 0.75}
  },
  {
    type = "fluid",
    name = "bm-radioactive-biosludge",
    icon = "__biological-machines-radioactive-tissue__/graphics/radioactive-biosludge.png",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2kJ",
    base_color = {0.17, 0.09, 0.01},
    flow_color = {0.70, 0.40, 0.0}
  },
  {
    type = "item",
    name = "bm-military-assembling-machine",
    --icons = {{icon = "__base__/graphics/icons/assembling-machine-3.png", tint = {1, 0.5, 1, 1}}},
    icon = "__biological-machines-k2-assets__/graphics/aam-icon.png",
    subgroup = "production-machine",
    order = "c[assembling-machine-3]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "bm-military-assembling-machine",
    stack_size = 20,
    weight = 200 * kg
  },
  {
    type = "item",
    name = "bm-cybernetic-contact",
    icon = "__biological-machines-radioactive-tissue__/graphics/cybernetic-contact.png",
    place_as_equipment_result = "bm-cybernetic-contact",
    subgroup = "utility-equipment",
    order = "f[night-vision]-a[night-vision-equipment]-a",
    inventory_move_sound = item_sounds.electric_small_inventory_move,
    pick_sound = item_sounds.electric_small_inventory_pickup,
    drop_sound = item_sounds.electric_small_inventory_move,
    stack_size = 20
  },
})
