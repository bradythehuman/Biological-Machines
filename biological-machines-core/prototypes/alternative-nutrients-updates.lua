local dh = require("__biological-machines-core__.data-helper")



data.raw["recipe"]["bm-hydrocarbon-bacteria-recycling"].results =
{{type = "item", name = "bm-hydrocarbon-bacteria", amount = 1, probability = 0.25}}



if mods["biological-machines-planet-wit"] then
  dh.add_recipe_unlock("bm-asteroid-deposit", {"bm-hydrocarbon-bacteria", "bm-hydrocarbon-bacteria-cultivation"})
end



local function alchohol_capsule(fluid_name, drunk_level)
  local barrel = util.table.deepcopy(data.raw["item"][fluid_name .. "-barrel"])
  barrel.type = "capsule"
  barrel.capsule_action = {
    type = "use-on-self",
    attack_parameters = {
      type = "projectile",
      activation_type = "consume",
      ammo_category = "capsule",
      cooldown = 1 * minute,
      range = 0,
      ammo_type = {
        target_type = "position",
        action = {
          type = "direct",
          action_delivery = {
            type = "instant",
            target_effects = {
              --[[
              {
                type = "create-sticker",
                sticker = "drunk-" .. drunk_level
              },
              {
                type = "create-sticker",
                sticker = "hungover-" .. drunk_level
              }
              ]]
              {
                type = "play-sound",
                sound = {filename = "__base__/sound/pipe.ogg", volume = 0.5}
              }
            }
          }
        }
      }
    }
  }
  data:extend({barrel})
  data.raw["item"][fluid_name .. "-barrel"] = nil
end

alchohol_capsule("bm-nutrient-wine", 1)
alchohol_capsule("bm-ethanol", 2)
