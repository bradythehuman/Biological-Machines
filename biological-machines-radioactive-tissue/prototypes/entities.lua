require ("util")
require ("__base__.prototypes.entity.pipecovers")
require ("circuit-connector-sprites")
require ("__base__.prototypes.entity.assemblerpipes")
--local hit_effects = require("__base__.prototypes.entity.hit-effects")



--ADD ENEMY RESISTANCES
local function add_percent_resist(units, unit_type, percent, resist_type)
  local resistance = {percent = percent, type = resist_type}
  for i=1, #units do
    table.insert(data.raw[unit_type][units[i]].resistances, resistance)
  end
end

local gleba_50_unit = {
  "small-wriggler-pentapod", "small-wriggler-pentapod-premature",
  "medium-wriggler-pentapod", "medium-wriggler-pentapod-premature",
  "big-wriggler-pentapod", "big-wriggler-pentapod-premature"
}
add_percent_resist(gleba_50_unit, "unit", 50, "poison")

local gleba_50_spider = {
   "small-strafer-pentapod", "medium-strafer-pentapod", "big-strafer-pentapod"
}
add_percent_resist(gleba_50_spider, "spider-unit", 50, "poison")

local gleba_80_spider = {
  "small-stomper-pentapod", "medium-stomper-pentapod", "big-stomper-pentapod"
}
add_percent_resist(gleba_80_spider, "spider-unit", 80, "poison")

local spawners = {
  "biter-spawner", "spitter-spawner", "gleba-spawner", "gleba-spawner-small"
}
add_percent_resist(spawners, "unit-spawner", 80, "poison")



--ALTER ENEMY RESISTANCES
local bhm_wrm_rst = data.raw["turret"]["behemoth-worm-turret"].resistances
for i=1, #bhm_wrm_rst do
  local type = bhm_wrm_rst[i].type
  if type == "explosion" then
    bhm_wrm_rst[i].decrease = 15
    bhm_wrm_rst[i].percent = 50
  elseif type == "physical" then
    bhm_wrm_rst[i].decrease = 15
  end
end

local demo_heads = {"small-demolisher", "medium-demolisher", "big-demolisher"}
for i=1, #demo_heads do
  local demo_rst = data.raw["segmented-unit"][demo_heads[i]].resistances
  for i=1, #demo_rst do
    local type = demo_rst[i].type
    if type == "explosion" then
      demo_rst[i].percent = 80
    elseif type == "physical" then
      demo_rst[i].decrease = 5
    end
  end
end

local demo_bodies = {}
local segments = data.raw["segment"]
for i=1, #segments do
  if string.find(segments[i], "demolisher") ~= nil then
    table.insert(demo_bodies, segments[i])
  end
end
for i=1, #demo_bodies do
  local type = demo_bodies[i].type
  if type == "physical" then
    demo_rst[i].decrease = 10
  end
end



--ADD POISON MINE
local poison_mine = util.table.deepcopy(data.raw["land-mine"]["land-mine"])
poison_mine.name = "bm-poison-mine"
poison_mine.picture_safe.filename = "__biological-machines-radioactive-tissue__/graphics/poison-mine.png"
poison_mine.picture_set.filename = "__biological-machines-radioactive-tissue__/graphics/poison-mine-set.png"
poison_mine.minable.result = "bm-poison-mine"
poison_mine.trigger_radius = 3.5 --land mine is 2.5
poison_mine.ammo_category = "bm-poison"
poison_mine.action.action_delivery.source_effects = {
  {
    type = "nested-result",
    affects_target = true,
    action = util.table.deepcopy(data.raw["projectile"]["poison-capsule"].action)
  },
  {
    type = "damage",
    damage = { amount = 1000, type = "explosion"}
  }
}
data:extend({poison_mine})



--ADD MILITARY ASSEMBLER
local military_assembler  = require("__biological-machines-k2-assets__/prototypes/aam.lua")
military_assembler.name = "bm-military-assembling-machine"
military_assembler.minable = {mining_time = 1, result = "bm-military-assembling-machine"}
military_assembler.crafting_categories = {"bm-military-crafting", "bm-military-crafting-with-fluid"}
military_assembler.crafting_speed = 2.5
--[[
military_assembler.energy_source = {
  type = "burner",
  fuel_categories = {"radioactive-mineral"},
  fuel_inventory_size = 1,
  emissions_per_minute = {pollution = 5}
}
]]
military_assembler.energy_usage = "0.925MW"
military_assembler.effect_receiver = {base_effect = {productivity = 0.5}}
military_assembler.module_slots = 4
military_assembler.allowed_effects = {
  "consumption",
  "speed",
  "productivity",
  "pollution",
  "quality"
}
military_assembler.corpse = "bm-medium-random-pipes-remnant"

local military_assembler_remnants  = require("__biological-machines-k2-assets__/prototypes/aam-remnants.lua")
military_assembler_remnants.name = "bm-medium-random-pipes-remnant"

data:extend({military_assembler, military_assembler_remnants})



for i=1, 3 do
  local cc = data.raw["assembling-machine"]["assembling-machine-" .. i].crafting_categories
  table.insert(cc, "bm-military-crafting")
  if i > 1 then
    table.insert(cc, "bm-military-crafting-with-fluid")
  end
end

table.insert(data.raw["character"]["character"].crafting_categories, "bm-military-crafting")



--RADIOACTIVE TWEAKS
table.insert(data.raw["lab"]["lab"].inputs, "bm-nuclear-military-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "bm-nuclear-military-science-pack")

data.raw["lab"]["biolab"].energy_source = {
  type = "burner",
  fuel_categories = {"bm-radioactive-mineral"},
  fuel_inventory_size = 1,
  emissions_per_minute = {pollution = 8}
}


local tissue_loot = {{item = "bm-radioactive-tissue", count_min = 1, count_max = 9}}
data.raw["unit-spawner"]["biter-spawner"].loot = tissue_loot
data.raw["unit-spawner"]["spitter-spawner"].loot = tissue_loot
