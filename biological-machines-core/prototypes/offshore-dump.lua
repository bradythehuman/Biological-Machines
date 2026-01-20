local land_area = {{-1, -0.8}, {1, 0.8}}

table.insert(data.raw["technology"]["steam-power"].effects, {type = "unlock-recipe", recipe = "bm-offshore-dump"})

data:extend({
  {
    type = "collision-layer",
    name = "bm_fluid"
  },
  {
    type = "recipe-category",
    name = "bm-fluid-void",
  },
  {
    type = "item-subgroup",
    name = "bm-fluid-void",
    group = "intermediate-products",
    order = "fa",
  },
  {
    type = "furnace",
    name = "bm-offshore-dump",
    icon = "__biological-machines-core__/graphics/offshore-dump/offshore-dump-icon.png",
    collision_mask = {layers={object=true, train=true, is_object=true, is_lower_object=true}}, -- collide just with object-layer and train-layer which don't collide with water, this allows us to build on 1 tile wide ground
    flags = {"placeable-neutral", "player-creation", "filter-directions"},
    tile_buildability_rules = {
      {
        area = land_area,
        required_tiles = {
          layers = {
            ground_tile = true
          }
        },
        colliding_tiles = {
          layers = {
            water_tile = true,
            --fluid = true,
            empty_space = true
          }
        },
        remove_on_collision = true
      },
      {
        area = {{-1, -2.5}, {1, -1.5}},
        required_tiles = {
          layers = {
            water_tile = true,
            --fluid = true,
            empty_space = true
          }
        },
        colliding_tiles = {layers={}}
      }
    },
    minable = {mining_time = 0.1, result = "bm-offshore-dump"},
    max_health = 300,
    circuit_wire_max_distance = 9,
    circuit_connector = circuit_connector_definitions["offshore-pump"],
    fast_replaceable_group = "offshore-pump",
    corpse = "offshore-pump-remnants",
    dying_explosion = "offshore-pump-explosion",
    fluid_source_offset = {0, -1},
    crafting_speed = 1,
    resistances = {
      {type = "fire", percent = 70},
      {type = "impact", percent = 30}
    },
    impact_category = "metal",
    pumping_speed = 20,
    tile_width = 3,
    tile_height = 2,
    collision_box = land_area,
    selection_box = {{-1.2, -0.99}, {1.2, 0.99}},
    fluid_boxes = {
      {
        volume = 1200,
        pipe_covers = pipecoverspictures(),
        production_type = "input",
        pipe_connections =
        {
          {
            position = {0, 0.5},
            direction = defines.direction.south,
            flow_direction = "input"
          }
        }
      }
    },
    --open_sound = sounds.machine_open,
    --close_sound = sounds.machine_close,
    working_sound = {
      sound = {
        filename = "__base__/sound/offshore-pump.ogg",
        volume = 0.5,
        modifiers = volume_multiplier("tips-and-tricks", 1.1),
        audible_distance_modifier = 0.7,
      },
      match_volume_to_activity = true,
      max_sounds_per_prototype = 3,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    crafting_categories = {"bm-fluid-void"},
    result_inventory_size = 0,
    energy_usage = "100kW",
    source_inventory_size = 0,
    energy_source = {
      type = "void",
      emissions_per_minute = {pollution = 100},
      render_no_power_icon = false,
      render_no_network_icon = false
    },
    --[[
    module_slots = 2,
    icons_positioning = {
      {inventory_index = defines.inventory.furnace_modules, max_icons_per_row = 2}
    },
    icon_draw_specification = {shift = {0, -0.5}},
    allowed_effects = {"speed", "pollution", "quality"},
    ]]
    perceived_performance = {maximum = 2},
    always_draw_fluid = true,
    graphics_set = {
      base_render_layer = "ground-patch",
      animation = {
        north = {
          filename = "__biological-machines-core__/graphics/offshore-dump/offshore-dump_North.png",
          priority = "high",
          line_length = 1,
          frame_count = 1,
          animation_speed = 0.25,
          width = 220,
          height = 225,
          shift = util.by_pixel(7, 11),
          scale = 0.5,
        },
        east = {
          filename = "__biological-machines-core__/graphics/offshore-dump/offshore-dump_East.png",
          priority = "high",
          line_length = 1,
          frame_count = 1,
          animation_speed = 0.25,
          width = 250,
          height = 190,
          shift = util.by_pixel(4, 10),
          scale = 0.5
        },
        south = {
          filename = "__biological-machines-core__/graphics/offshore-dump/offshore-dump_South.png",
          priority = "high",
          line_length = 1,
          frame_count = 1,
          animation_speed = 0.25,
          width = 220,
          height = 225,
          shift = util.by_pixel(5, 9),
          scale = 0.5
        },
        west = {
          filename = "__biological-machines-core__/graphics/offshore-dump/offshore-dump_West.png",
          priority = "high",
          line_length = 1,
          frame_count = 1,
          animation_speed = 0.25,
          width = 250,
          height = 190,
          shift = util.by_pixel(-1, 14),
          scale = 0.5
        },
      },
      working_visualisations = {
        {
          fadeout = true,
          north_animation = {
            layers = {
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                priority = "low",
                line_length = 8,
                width = 210,
                height = 224,
                frame_count = 26,
                shift = util.by_pixel(0, -64),
                scale = 0.5
              },
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                priority = "low",
                line_length = 8,
                width = 266,
                height = 188,
                frame_count = 26,
                shift = util.by_pixel(0, -64),
                draw_as_shadow = true,
                scale = 0.5
              }
            }
          },
          east_animation = {
            layers = {
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                priority = "low",
                line_length = 8,
                width = 210,
                height = 224,
                frame_count = 26,
                shift = util.by_pixel(64, 32),
                scale = 0.5
              },
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                priority = "low",
                line_length = 8,
                width = 266,
                height = 188,
                frame_count = 26,
                shift = util.by_pixel(64, 32),
                draw_as_shadow = true,
                scale = 0.5
              }
            }
          },
          south_animation = {
            layers = {
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                priority = "high",
                line_length = 8,
                width = 210,
                height = 224,
                frame_count = 26,
                shift = util.by_pixel(0, 64),
                scale = 0.5
              },
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                priority = "high",
                line_length = 8,
                width = 266,
                height = 188,
                frame_count = 26,
                shift = util.by_pixel(0, 64),
                draw_as_shadow = true,
                scale = 0.5
              }
            }
          },
          west_animation = {
            layers = {
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                priority = "low",
                line_length = 8,
                width = 210,
                height = 224,
                frame_count = 26,
                shift = util.by_pixel(-64, 32),
                scale = 0.5
              },
              {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                priority = "low",
                line_length = 8,
                width = 266,
                height = 188,
                frame_count = 26,
                shift = util.by_pixel(-64, 32),
                draw_as_shadow = true,
                scale = 0.5
              }
            }
          }
        }
      }
    }
  },
  {
    type = "item",
    name = "bm-offshore-dump",
    icon = "__biological-machines-core__/graphics/offshore-dump/offshore-dump-icon.png",
    subgroup = "extraction-machine",
    order = "b[fluids]-a[offshore-pump]-a",
    place_result = "bm-offshore-dump",
    stack_size = 20,
    weight = 50 * kg
  },
  {
    type = "recipe",
    name = "bm-offshore-dump",
    enabled = false,
    energy_required = 3,
    ingredients = {
      {type = "item", name = "pipe", amount = 3},
      {type = "item", name = "iron-gear-wheel", amount = 2},
      {type = "item", name = "stone-brick", amount = 5}
    },
    results = {{type = "item", name = "bm-offshore-dump", amount = 1}}
  }
})
