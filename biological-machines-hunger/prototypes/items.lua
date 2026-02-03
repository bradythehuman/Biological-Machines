local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_effects = require("__space-age__.prototypes.item-effects")



local capsules = {"raw-fish", "yumako", "yumako-mash", "jellynut", "jelly", "bioflux"}
for _, name in pairs(capsules) do
  local item = data.raw["capsule"][name]
  item.type = "item"
  data.raw["capsule"][name] = nil
  data:extend({item})
end

data.raw["item"]["raw-fish"].stack_size = 50



data:extend({
  {
    type = "item",
    name = "bm-berry-paste",
    icon = "__biological-machines-hunger__/graphics/berry-paste.png",
    subgroup = "bm-processed-food",
    order = "b",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 50,
    weight = 2.5 * kg,

    fuel_category = "chemical",
    fuel_value = "500kJ",

    spoil_ticks = 4 * hour,
    spoil_result = "spoilage"
  },
  --[[
  {
    type = "item",
    name = "dehydrated-nutrients",
    icon = "__biological-machines-hunger__/graphics/dehydrated-nutrients.png",
    subgroup = "processed-food",
    order = "a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 100,
    weight = 1 * kg,

    fuel_category = "chemical",
    fuel_value = "50kJ",

    spoil_ticks = 2 * hour,
    spoil_result = "spoilage"
  },
  ]]
  {
    type = "item",
    name = "bm-nutrient-paste",
    icon = "__biological-machines-hunger__/graphics/nutrient-paste.png",
    subgroup = "bm-processed-food",
    order = "a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 50,
    weight = 2.5 * kg,

    fuel_category = "chemical",
    fuel_value = "500kJ",

    spoil_ticks = 4 * hour,
    spoil_result = "spoilage"
  },
  {
    type = "item",
    name = "bm-empty-can",
    icon = "__biological-machines-hunger__/graphics/empty-can.png",
    subgroup = "intermediate-product",
    order = "a[basic-intermediates]-d[empty-barrel]-a",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 50,
    weight =  2.5 * kg
  },
  {
    type = "item",
    name = "bm-canned-fish",
    icon = "__biological-machines-hunger__/graphics/closed-can.png",
    subgroup = "bm-processed-food",
    order = "c",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 50,
    weight =  5 * kg,

    spoil_ticks = 12 * hour,
    spoil_result = "bm-empty-can"
  },
  {
    type = "item",
    name = "bm-stingfrond",
    icon = "__biological-machines-hunger__/graphics/stingfrond-leaf.png",
    subgroup = "agriculture-processes",
    order = "b[agriculture]-d",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,
    default_import_location = "gleba",

    spoil_ticks = 1 * minute,
    spoil_result = "bm-stingfrond-seed"
  },
  {
    type = "item",
    name = "bm-stingfrond-seed",
    icon = "__biological-machines-hunger__/graphics/stingfrond-seed.png",
    subgroup = "agriculture-processes",
    order = "a[seeds]-e[stingfrond-seed]",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,
    default_import_location = "gleba",

    fuel_category = "chemical",
    fuel_value = "100kJ",

    plant_result = "bm-stingfrond-plant",
    place_result = "bm-stingfrond-plant"
  },
  {
    type = "item",
    name = "bm-nutrient-slurry",
    icon = "__biological-machines-hunger__/graphics/nutrient-slurry.png",
    subgroup = "bm-processed-food",
    order = "d",
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    stack_size = 100,
    weight = 1 / 300 * tons,
    default_import_location = "gleba",

    spoil_ticks = 4 * hour,
    spoil_result = "spoilage"
  },
  {
    type = "item",
    name = "bm-fluroflux",
    icon = "__biological-machines-hunger__/graphics/fluroflux.png",
    subgroup = "agriculture-products",
    order = "a[organic-processing]-b[bioflux]-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 100,
    weight = 2 * kg,
    default_import_location = "gleba",

    fuel_category = "food",
    fuel_value = "15MJ",

    spoil_ticks = 1 * hour,
    spoil_result = "spoilage"
  },
  {
    type = "item",
    name = "bm-fortified-nutrient-slurry",
    icon = "__biological-machines-hunger__/graphics/fortified-nutrient-slurry.png",
    subgroup = "bm-processed-food",
    order = "e",
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    stack_size = 100,
    weight = 1 / 300 * tons,
    default_import_location = "gleba",

    spoil_ticks = 4 * hour,
    spoil_result = "spoilage"
  },
  {
    type = "capsule",
    name = "bm-medkit",
    icon = "__biological-machines-k2-assets__/graphics/medkit.png",
    subgroup = "bm-processed-food",
    order = "f",
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    stack_size = 50,
    weight = 5 * kg,
    default_import_location = "gleba",

    spoil_ticks = 4 * hour,

    capsule_action = item_effects.yumako_regen
  },
  {
    type = "capsule",
    name = "bm-stims",
    icon = "__biological-machines-k2-assets__/graphics/stims.png",
    subgroup = "bm-processed-food",
    order = "f",
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    stack_size = 50,
    weight = 5 * kg,
    default_import_location = "gleba",

    spoil_ticks = 4 * hour,

    capsule_action = item_effects.jellynut_speed
  },
  {
    type = "item",
    name = "bm-demolisher-meat",
    icon = "__biological-machines-hunger__/graphics/demolisher-meat.png",
    subgroup = "raw-resource",
    order = "h[raw-fish]-a",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,
    default_import_location = "vulcanus",

    spoil_ticks = 1 * hour,
    spoil_result = "spoilage"
  },
  {
    type = "item",
    name = "bm-demolisher-meat-barrel",
    icons = {
      {
        icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
        icon_size = defines.default_icon_size
      },
      {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
        icon_size = defines.default_icon_size,
        tint = util.get_color_with_alpha({0.61, 0.11, 0.54}, 0.75, true)
      },
      {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
        icon_size = defines.default_icon_size,
        tint = util.get_color_with_alpha({0.94, 0.26, 0.91}, 0.75, true)
      }
    },
    subgroup = "bm-processed-food",
    order = "c-a",
    inventory_move_sound = item_sounds.metal_barrel_inventory_move,
    pick_sound = item_sounds.metal_barrel_inventory_pickup,
    drop_sound = item_sounds.metal_barrel_inventory_move,
    stack_size = 10,
    weight =  10 * kg,
    default_import_location = "vulcanus",

    spoil_ticks = 12 * hour,
    spoil_result = "barrel"
  },
  {
    type = "item",
    name = "bm-biological-recycler",
    icon = "__biological-machines-hunger__/graphics/biological-recycler.png",
    icon_size = 128,
    place_as_equipment_result = "bm-biological-recycler",
    subgroup = "utility-equipment",
    order = "f[night-vision]-a[night-vision-equipment]-b",
    inventory_move_sound = item_sounds.roboport_inventory_move,
    pick_sound = item_sounds.roboport_inventory_pickup,
    drop_sound = item_sounds.roboport_inventory_move,
    stack_size = 10,
    weight = 100 * kg,
    default_import_location = "fulgora",
  },
  {
    type = "item",
    name = "bm-artificial-organs",
    icon = "__biological-machines-core__/graphics/artificial-organs.png",
    icon_size = 256,
    subgroup = "utility-equipment",
    order = "f[night-vision]-a[night-vision-equipment]-c",
    place_as_equipment_result = "bm-artificial-organs",
    inventory_move_sound = item_sounds.roboport_inventory_move,
    pick_sound = item_sounds.roboport_inventory_pickup,
    drop_sound = item_sounds.roboport_inventory_move,
    stack_size = 5,
    weight = 200 * kg,
  },
})
