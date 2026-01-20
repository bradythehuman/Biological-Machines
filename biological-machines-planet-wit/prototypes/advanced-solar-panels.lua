--BASE SOLAR/EQUIPMENT POWER PRODUCTION
--data.raw["solar-panel"]["solar-panel"].production = "50kW" --base 60kW
--data.raw["solar-panel-equipment"]["solar-panel-equipment"].power = "25kW" --base 30kW
data.raw["generator-equipment"]["fission-reactor-equipment"].power = "1.5MW" --base 750kW
data.raw["generator-equipment"]["fusion-reactor-equipment"].power = "5MW" --base 2.5MW



--ADVANCED SOLAR PANEL ENTITY
local adv_panel_item = util.table.deepcopy(data.raw["item"]["solar-panel"])
adv_panel_item.name = "bm-advanced-solar-panel"
adv_panel_item.icon = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-icon.png"
adv_panel_item.order = "d[solar-panel]-a[solar-panel]-a"
adv_panel_item.place_result = "bm-advanced-solar-panel"

local adv_panel_recipe = util.table.deepcopy(data.raw["recipe"]["solar-panel"])
adv_panel_recipe.name = "bm-advanced-solar-panel"
adv_panel_recipe.energy_required = 20
adv_panel_recipe.ingredients = {
  {type = "item", name = "solar-panel", amount = 1},
  {type = "item", name = "advanced-circuit", amount = 5},
  {type = "item", name = "bm-helium-power-cell", amount = 20},
  {type = "item", name = "superconductor", amount = 10}
}
adv_panel_recipe.results = {
  {type = "item", name = "bm-advanced-solar-panel", amount = 1}
}

local adv_panel_tech = util.table.deepcopy(data.raw["technology"]["solar-energy"])
adv_panel_tech.name = "bm-advanced-solar-energy"
adv_panel_tech.icon = "__biological-machines-planet-wit__/graphics/advanced-solar-energy.png"
adv_panel_tech.effects[1].recipe = "bm-advanced-solar-panel"
adv_panel_tech.prerequisites = {"solar-energy", "electromagnetic-science-pack"}
adv_panel_tech.unit = {
  count = 500,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"space-science-pack", 1},
    {"electromagnetic-science-pack", 1}
  },
  time = 60
}

local adv_panel_entity = util.table.deepcopy(data.raw["solar-panel"]["solar-panel"])
adv_panel_entity.name = "bm-advanced-solar-panel"
adv_panel_entity.icon = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-icon.png"
adv_panel_entity.minable = {mining_time = 0.1, result = "bm-advanced-solar-panel"}
adv_panel_entity.corpse = "bm-advanced-solar-panel-remnants"
adv_panel_entity.picture.layers[1].filename = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-entity.png"
adv_panel_entity.production = "240kW"

local adv_panel_remnants = util.table.deepcopy(data.raw["corpse"]["solar-panel-remnants"])
adv_panel_remnants.name = "bm-advanced-solar-panel-remnants"
adv_panel_remnants.icon = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-icon.png"
adv_panel_remnants.animation = make_rotated_animation_variations_from_sheet (2,
{
  filename = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-remnants.png",
  line_length = 1,
  width = 290,
  height = 282,
  direction_count = 1,
  shift = util.by_pixel(3.5, 0),
  scale = 0.5
})

data:extend({adv_panel_item, adv_panel_recipe, adv_panel_tech, adv_panel_entity, adv_panel_remnants})



--ADVANCED SOLAR PANEL EQUIPMENT
local adv_equip_item = util.table.deepcopy(data.raw["item"]["solar-panel-equipment"])
adv_equip_item.name = "bm-advanced-solar-panel-equipment"
adv_equip_item.icon = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-equipment-icon.png"
adv_equip_item.order = "a[energy-source]-a[solar-panel]-a"
adv_equip_item.place_as_equipment_result = "bm-advanced-solar-panel-equipment"

local adv_equip_recipe = util.table.deepcopy(data.raw["recipe"]["solar-panel-equipment"])
adv_equip_recipe.name = "bm-advanced-solar-panel-equipment"
adv_equip_recipe.energy_required = 20
adv_equip_recipe.ingredients = {
  {type = "item", name = "bm-advanced-solar-panel", amount = 1},
  {type = "item", name = "processing-unit", amount = 1},
  {type = "item", name = "low-density-structure", amount = 2}
}
adv_equip_recipe.results = {
  {type = "item", name = "bm-advanced-solar-panel-equipment", amount = 1}
}

local adv_equip_tech = util.table.deepcopy(data.raw["technology"]["solar-panel-equipment"])
adv_equip_tech.name = "bm-advanced-solar-panel-equipment"
adv_equip_tech.icons = util.technology_icon_constant_equipment("__biological-machines-planet-wit__/graphics/advanced-solar-panel-equipment-technology.png")
adv_equip_tech.effects[1].recipe = "bm-advanced-solar-panel-equipment"
adv_equip_tech.prerequisites = {"bm-advanced-solar-energy", "power-armor-mk2", "battery-mk3-equipment"}
adv_equip_tech.unit = {
  count = 500,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
    {"space-science-pack", 1},
    {"electromagnetic-science-pack", 1}
  },
  time = 60
}

local adv_equip_equip = util.table.deepcopy(data.raw["solar-panel-equipment"]["solar-panel-equipment"])
adv_equip_equip.name = "bm-advanced-solar-panel-equipment"
adv_equip_equip.icon = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-equipment-icon.png"
adv_equip_equip.sprite.filename = "__biological-machines-planet-wit__/graphics/advanced-solar-panel-equipment-equipment.png"
adv_equip_equip.power = "60kW"

data:extend({adv_equip_item, adv_equip_recipe, adv_equip_tech, adv_equip_equip})
