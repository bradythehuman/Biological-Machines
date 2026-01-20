local dh = require("__biological-machines-core__.data-helper")



--adds nuclear/interstellar sci pack if bm tissue/wit is installed
local all_packs = util.table.deepcopy(data.raw.technology["research-productivity"].unit.ingredients)
if mods["biological-machines-planet-wit"] then
  table.insert(all_packs, {"bm-interstellar-science-pack", 1})
end
data.raw["technology"]["bm-warp-drive"].unit.ingredients = util.table.deepcopy(all_packs)
data.raw["technology"]["bm-warp-power-cell-productivity"].unit.ingredients = util.table.deepcopy(all_packs)



--[[
local location_prereqs = {
  --["cerys"] = "planetary-discovery-cerys",
}

if mods["biological-machines-planet-balack"] then
  location_prereqs["shattered-planet"] = "bm-planet-discovery-shattered-planet"
end



local function make_warp_location(location_prototype, alt_tech_name)
  local warp_name = "bm-warp-to-" .. location_prototype.name
  local localised_name = {"", {"bm-prefix.warp"}, " ", {"space-location-name." .. location_prototype.name}}
  --local localised_name = {"bm-prefix.warp", " planet ", {"space-location-name." .. "gleba"}}
  local small_warp_icons = {
    {
      icon = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-icon.png",
    },
    {
      icon = location_prototype.icon,
      scale = 16 / (location_prototype.icon_size or 64),
    }
  }
  local big_location_icon = {}
  if location_prototype.starmap_icon then
    big_location_icon.icon = location_prototype.starmap_icon
    big_location_icon.icon_size = location_prototype.starmap_icon_size
    big_location_icon.scale = 64 / (location_prototype.starmap_icon_size or 64)
  else
    big_location_icon.icon = location_prototype.icon
    big_location_icon.icon_size = location_prototype.starmap_icon_size
    big_location_icon.scale = 64 / (location_prototype.icon_size or 64)
  end
  local location_prereq = location_prereqs[location_prototype.name]
  local warp_prereqs = {"bm-warp-drive"}
  if location_prereq then
    table.insert(warp_prereqs, location_prereq)
    --TODO add extra science packs used in planet discovery
  end

  data:extend({
    {
      type = "recipe",
      name = warp_name,
      localised_name = localised_name,
      icons = small_warp_icons,
      category = "bm-warp-drive",
      subgroup = "bm-planet-warp",
      order = location_prototype.order,
      enabled = false,
      allow_productivity = false,
      allow_decomposition = false,
      energy_required = 10,
      ingredients = {{type = "item", name = "bm-warp-power-cell", amount = 1}},
      results = {{type = "item", name = warp_name, amount = 1}},
      result_is_always_fresh = true,
      hide_from_signal_gui = false,
    },
    {
      type = "item",
      name = warp_name,
      localised_name = localised_name,
      icons = small_warp_icons,
      subgroup = "bm-planet-warp",
      order = location_prototype.order,
      stack_size = 1,
      weight = 10000 * kg,
      hidden = true,
      hidden_in_factoriopedia = true,

      spoil_ticks = 2,
      spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
          type = "direct",
          action_delivery = {
            type = "projectile",
            projectile = warp_name,
            starting_speed = 1,
          }
        }
      },
    },
    {
      type = "projectile",
      name = warp_name,
      localised_name = localised_name,
      acceleration = 0,
      action = {
        type = "direct",
        action_delivery = {
          type = "instant",
          source_effects = {
            type = "script",
            effect_id = warp_name
          }
        }
      }
    },
  })

  if alt_tech_name then
    dh.add_recipe_unlock(alt_tech_name, warp_name)
  else
    data:extend({{
      type = "technology",
      name = warp_name,
      localised_name = localised_name,
      icons = {
        {
          icon = "__biological-machines-warp-drive__/graphics/quantum-stabilizer/quantum-stabilizer-icon-big.png",
          icon_size = 640,
        },
        big_location_icon,
      },
      essential = true,
      effects = {{type = "unlock-recipe", recipe = warp_name}},
      prerequisites = warp_prereqs,
      unit = {
        count = 1000,
        ingredients = util.table.deepcopy(all_packs),
        time = 120,
      }
    }})
  end
end

for _, planet_prototype in pairs(data.raw["planet"]) do
  if planet_prototype.name == "bm-dyson-sphere" then
    make_warp_location(planet_prototype, "bm-solar-system-discovery-homeworld")
  else
    make_warp_location(planet_prototype)
  end
end

for _, location_prototype in pairs(data.raw["space-location"]) do
  if location_prototype.name ~= "space-location-unknown"
  and location_prototype.name ~= "star" then
    make_warp_location(location_prototype)
  end
end
]]
