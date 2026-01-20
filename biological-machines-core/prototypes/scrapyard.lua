local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")

data:extend{
  {
    type = "furnace",
    name = "bm-scrapyard",
    icon = "__biological-machines-core__/graphics/scrapyard-icon.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "bm-scrapyard"},
    max_health = 300,
    impact_category = "metal-large",
    resistances = {{type = "fire", percent = 80}},
    crafting_categories = {"recycling", "recycling-or-hand-crafting"},
    result_inventory_size = 12,
    crafting_speed = 0.125, --recycler is 0.5
    source_inventory_size = 1,
    custom_input_slot_tooltip_key = "recycler-input-slot-tooltip",
    cant_insert_at_source_message_key = "inventory-restriction.cant-be-recycled",
    allowed_effects = {"consumption", "speed", "pollution"},
    effect_receiver = {uses_module_effects = false, uses_beacon_effects = false, uses_surface_effects = true},
    energy_usage = "180kW", --can i delete this w/o problems?
    energy_source = {
      type = "void",
      emissions_per_minute = {pollution = 25}, --recycler is 2
      render_no_power_icon = false,
      render_no_network_icon = false
    },

    --AUDIO
    open_sound = sounds.metal_large_open,
    close_sound = sounds.metal_large_close,
    working_sound = {
      sound = {filename = "__quality__/sound/recycler/recycler-loop.ogg", volume = 0.7},
      sound_accents = {
        {sound = {variations = sound_variations("__quality__/sound/recycler/recycler-jaw-move", 5, 0.45), audible_distance_modifier = 0.2}, frame = 14},
        {sound = {variations = sound_variations("__quality__/sound/recycler/recycler-vox", 5, 0.2), audible_distance_modifier = 0.3}, frame = 20},
        {sound = {variations = sound_variations("__quality__/sound/recycler/recycler-mechanic", 3, 0.3), audible_distance_modifier = 0.3}, frame = 45},
        {sound = {variations = sound_variations("__quality__/sound/recycler/recycler-jaw-move", 5, 0.45), audible_distance_modifier = 0.2}, frame = 60},
        {sound = {variations = sound_variations("__quality__/sound/recycler/recycler-trash", 5, 0.6), audible_distance_modifier = 0.3}, frame = 61},
        {sound = {variations = sound_variations("__quality__/sound/recycler/recycler-jaw-shut", 6, 0.3), audible_distance_modifier = 0.6}, frame = 63},
      },
      max_sounds_per_prototype = 2,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },

    --GRAPHICS
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__biological-machines-core__/graphics/scrapyard-entity.png",
            priority = "extra-high",
            width = 610,
            height = 610,
            scale = 0.5
         },
        }
      }
    },
    icon_draw_specification = {shift = {0, -0.55}},
    icons_positioning = {
      {inventory_index = defines.inventory.furnace_modules, shift = {0, 0.2}}
    },
    vector_to_place_result = {0, -4.85}, --needs change
    collision_box = {{-4.20, -4.20}, {4.20, 4.20}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    circuit_wire_max_distance = furnace_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["recycler"],
    circuit_connector_flipped = circuit_connector_definitions["recycler-flipped"],
    dying_explosion = "recycler-explosion",
    corpse = ""
  },
  {
    type = "item",
    name = "bm-scrapyard",
    icon = "__biological-machines-core__/graphics/scrapyard-icon.png",
    subgroup = "smelting-machine",
    order = "d[foundry]-a",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    place_result = "bm-scrapyard",
    stack_size = 1,
    weight = 10 * tons
  },
  {
    type = "recipe",
    name = "bm-scrapyard",
    icon = "__biological-machines-core__/graphics/scrapyard-icon.png",
    category = "crafting",
    subgroup = "smelting-machine",
    order = "d[foundry]-a",
    enabled = false,
    energy_required = 10,
    ingredients = {{type = "item", name = "landfill", amount = 20}},
    results = {{type = "item", name = "bm-scrapyard", amount = 1}}
  },
  {
    type = "technology",
    name = "bm-scrapyard",
    icon = "__biological-machines-core__/graphics/scrapyard-research.png",
    icon_size = 256,
    effects = {{type = "unlock-recipe", recipe = "bm-scrapyard"}},
    prerequisites = {"landfill"},
    unit = {
      count = 50,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 15
    }
  },
}
