local glass_shard = util.table.deepcopy(data.raw["resource"]["calcite"])
glass_shard.name = "bm-glass-shard"
glass_shard.icon = "__biological-machines-planet-wit__/graphics/glass-shard-icon.png"
glass_shard.minable.result = "bm-glass-shard"
glass_shard.stages.sheet.filename = "__biological-machines-planet-wit__/graphics/glass-shard-entity.png"
glass_shard.map_color = {0.34, 0.77, 0.68}
glass_shard.factoriopedia_simulation = nil

local copper_sulfate = util.table.deepcopy(data.raw["resource"]["stone"])
copper_sulfate.name = "bm-copper-sulfate"
copper_sulfate.icon = "__biological-machines-planet-wit__/graphics/copper-sulfate-icon.png"
copper_sulfate.minable.result = "bm-copper-sulfate"
copper_sulfate.stages.sheet.filename = "__biological-machines-planet-wit__/graphics/copper-sulfate-entity.png"
copper_sulfate.map_color = {0.17, 0.42, 0.82}
copper_sulfate.factoriopedia_simulation = nil
--copper_sulfate.autoplace.base_density = 200

local asteroid_ore = util.table.deepcopy(data.raw["resource"]["iron-ore"])
asteroid_ore.name = "bm-asteroid-ore"
asteroid_ore.icon = "__biological-machines-planet-wit__/graphics/asteroid-ore-icon.png"
asteroid_ore.stages.sheet.filename = "__biological-machines-planet-wit__/graphics/asteroid-ore-entity.png"
asteroid_ore.minable.mining_time = 10
asteroid_ore.minable.result = nil
asteroid_ore.minable.results = {
  {name = "metallic-asteroid-chunk", type = "item", amount = 1, probability = 0.4},
  {name = "carbonic-asteroid-chunk", type = "item", amount = 1, probability = 0.3},
  {name = "oxide-asteroid-chunk", type = "item", amount = 1, probability = 0.3}
}
--asteroid_ore.map_color = {0.17, 0.42, 0.82}
asteroid_ore.subgroup = "space-material"
asteroid_ore.order = "a"
asteroid_ore.factoriopedia_simulation = nil

local helium_vent = util.table.deepcopy(data.raw["resource"]["sulfuric-acid-geyser"])
helium_vent.name = "bm-helium-vent"
helium_vent.icon = "__biological-machines-planet-wit__/graphics/helium-vent-icon.png"
helium_vent.minable.results[1].name = "bm-helium"
helium_vent.stages.layers = {
  util.sprite_load("__biological-machines-planet-wit__/graphics/helium-vent-entity",
  {
    priority = "high",
    frame_count = 4,
    scale = 0.5,
  })
}
helium_vent.stateless_visualisation[1].animation.tint = util.multiply_color({r=0.90, g=0.65, b=0.65}, 0.3)
helium_vent.stateless_visualisation[2].animation.tint = util.multiply_color({r=1, g=0.45, b=0.5}, 0.5)
helium_vent.map_color = {1, 0.45, 0.5}

data:extend({
  glass_shard, copper_sulfate, asteroid_ore, helium_vent
})
