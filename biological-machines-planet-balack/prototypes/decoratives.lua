----------------------------------------------------------RUINS
local balack_ruin_data = {
  --["ruin-vault"] = "(min(bm_balack_spots, (1 - bm_balack_starting_vault_cone) / 2) < 0.015) * min(bm_balack_vaults_and_starting_vault, 1 - bm_balack_starting_mask)",
  --[[
  ["fulgoran-ruin-vault"] = {
    "simple-entity",
    "bm-balack-ruin-vault",
    "(min(bm_balack_spots, (1 - bm_balack_starting_vault_cone) / 2) < 0.015) * min(bm_balack_vaults_and_starting_vault, x * x + y * y - 200000)",
    util.spritesheets_to_pictures({{
      path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-vault",
      frame_count = 1,
      dice_y = 2,
    }}),
  },
  ]]
  ["fulgoran-ruin-colossal"] = {
    "simple-entity",
    "bm-balack-ruin-colossal",
    "0.0001 * bm_balack_artificial_mask + 0.001 * (bm_balack_decorative_machine_density - 4)",
    util.spritesheets_to_pictures({{
      path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-colossal",
      frame_count = 3,
      dice_y = 2,
    }}),
    "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-colossal.png",
  },
  ["fulgoran-ruin-huge"] = {
    "simple-entity",
    "bm-balack-ruin-huge",
    "0.0001 * bm_balack_artificial_mask + 0.002 * (bm_balack_decorative_machine_density - 3)",
    util.spritesheets_to_pictures({
      {
        path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-huge",
        frame_count = 8,
        dice_y = 2,
      },
      {
        path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-huge-tall",
        frame_count = 3,
        dice_y = 2,
      },
    }),
    "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-huge.png",
  },
  ["fulgoran-ruin-big"] = {
    "simple-entity",
    "bm-balack-ruin-big",
    "0.0001 * bm_balack_artificial_mask + 0.003 * (bm_balack_decorative_machine_density - 2)",
    util.spritesheets_to_pictures({{
      path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-big",
      frame_count = 7,
    }}),
    "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-big.png",
  },
  ["fulgoran-ruin-stonehenge"] = {
    "simple-entity",
    "bm-balack-ruin-stonehenge",
    "0.0005 * bm_balack_artificial_mask + 0.004 * (bm_balack_decorative_machine_density - 1.5)",
    util.spritesheets_to_pictures({{
      path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-stonehenge",
      frame_count = 8,
    }}),
    "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-stonehenge.png",
  },
  ["fulgoran-ruin-medium"] = {
    "simple-entity",
    "bm-balack-ruin-medium",
    "0.0001 * (0.1 * bm_balack_natural_mask )\z
                                + (0.001 + 0.006 * (bm_balack_decorative_machine_density - 0.3))\z
                                * (bm_balack_artificial_mask + 0.2 * bm_balack_mesa * max(0, bm_balack_scrap_medium))",
    util.spritesheets_to_pictures({
      {
        path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-medium",
        frame_count = 8,
      },
      {
        path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-medium-tall",
        frame_count = 4,
      },
    }),
    "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-medium.png",
  },
  ["fulgoran-ruin-small"] = {
    "simple-entity",
    "bm-balack-ruin-small",
    "0.0005 * (0.1 * bm_balack_natural_mask + bm_balack_mesa)\z
                                + (0.005 + 0.005 * (bm_balack_decorative_machine_density - 0.1))\z
                                * (bm_balack_artificial_mask + 0.2 * bm_balack_mesa * max(0, bm_balack_scrap_medium))",
    util.spritesheets_to_pictures({
      {
        path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-small",
        frame_count = 26,
      },
      {
        path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-small-tall",
        frame_count = 7,
      },
    }),
    "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-small.png",
  },
  ["fulgoran-ruin-tiny"] = {
    "optimized-decorative",
    "bm-balack-ruin-tiny",
    "0.0005 * bm_balack_oil_mask * (bm_balack_elevation > -10)\z
                                + (1 - bm_balack_oil_mask)\z
                                * (0.005 * (0.1 * bm_balack_natural_mask + fulgora_mesa)\z
                                   + (0.04 + 0.01 * fulgora_decorative_machine_density)\z
                                   * (fulgora_artificial_mask + 0.2 * fulgora_mesa * max(0, fulgora_scrap_medium)))",
    util.spritesheets_to_pictures({{
      path = "__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-tiny",
      frame_count = 35,
      scale = 0.3
    }}),
    "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-tiny.png",
  },
}
for key, entity_data in pairs(balack_ruin_data) do
  local new_entity = util.table.deepcopy(data.raw[entity_data[1]][key])
  new_entity.name = entity_data[2]
  new_entity.autoplace.probability_expression = entity_data[3]
  if key ~= "fulgoran-ruin-tiny" then
    new_entity.minable.results[1].name = "bm-balack-scrap"
  end
  new_entity.pictures = entity_data[4]
  new_entity.icon = entity_data[5]
  data:extend({new_entity})
end



data:extend({
  {
    --type = "simple-entity",
    type = "turret",
    name = "bm-balack-ruin-attractor",
    icon = "__biological-machines-planet-balack__/graphics/icons/fulgoran-ruin-attractor.png",
    flags = {"placeable-neutral", "player-creation", "not-upgradable"},
    subgroup = "grass",
    order = "b[decorative]-l[rock]-d[fulgora]-d[fulgoran-ruin-attractor]",
    autoplace = {
      order = "a",
      probability_expression = "1000 * ((abs(x) == 7) * (y == 0) + (x == 0) * (abs(y) == 7))",
      force = "player",
    },
    max_health = 100,
    dying_explosion = "medium-electric-pole-explosion",
    collision_box = {{-1.21, -1.21}, {1.21, 1.21}},
    selection_box = {{-1.21, -1.21}, {1.21, 1.21}},
    drawing_box_vertical_extension = 4,
    --open_sound = sounds.electric_network_open,
    --close_sound = sounds.electric_network_close,
    stateless_visualisation = {
      period = 0,
      animation = {
        sheet =
          util.sprite_load("__biological-machines-planet-balack__/graphics/decorative/fulgoran-ruin/fulgoran-ruin-attractor",
          {
            frame_count = 1,
            shift = {0, 0.5},
            scale = 0.5,
            variation_count = 4,
          })
      },
    },
    water_reflection = {
      pictures = {
        filename = "__space-age__/graphics/entity/lightning-rod/lightning-rod.png",
        priority = "extra-high",
        width = 12,
        height = 28,
        shift = util.by_pixel(0, 55),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    },
    --allowed_effects = {},
    --emissions_per_second = {pollution = 5},
    --is_military_target = true,
    energy_source = {type = "void"},
    --attack_parameters = util.table.deepcopy(data.raw["electric-turret"]["tesla-turret"].attack_parameters),
    attack_parameters = {
      type = "beam",
      ammo_category = "beam",
      cooldown = 20,
      cooldown_deviation = 0.2,
      range = 30,
      range_mode = "center-to-bounding-box",
      damage_modifier = 50,
      sound = make_laser_sounds(),
      ammo_type = {
        action = {
          type = "direct",
          action_delivery = {
            type = "beam",
            beam = "electric-beam",
            max_length = 40,
            duration = 20,
            --source_offset = {0.15, -0.5},
            source_offset = {0, -4},
          }
        }
      }
    },
    call_for_help_radius = 40,
    folded_animation = {north = {
      filenames = {"__biological-machines-planet-balack__/graphics/dummy.png"},
      lines_per_file = 1,
      size = 64,
    }},
    graphics_set = {},
  },
})

table.insert(bm_add_full_resistences, data.raw["turret"]["bm-balack-ruin-attractor"])



-------------------------------------------------------------ROCKS / CLIFF
local balack_rock_data = {
  ["big-fulgora-rock"] = {
    "simple-entity",
    "bm-big-balack-rock",
    "(1 - bm_balack_oil_mask) * (bm_balack_natural_mask + bm_balack_mesa)\z
                              * min(0.05,\z
                                    - 2.1 + bm_balack_rock - 0.5 * bm_balack_mix_oil + 0.7 * bm_balack_basis_oil)",
  },
  ["medium-fulgora-rock"] = {
    "optimized-decorative",
    "bm-medium-balack-rock",
    "(1 - bm_balack_oil_mask) * (bm_balack_natural_mask + bm_balack_mesa)\z
                              * min(0.15,\z
                                    - 1.8 + bm_balack_rock - 0.5 * bm_balack_mix_oil + 0.7 * bm_balack_basis_oil)",
  },
  ["small-fulgora-rock"] = {
    "optimized-decorative",
    "bm-small-balack-rock",
    "(1 - bm_balack_oil_mask) * (bm_balack_natural_mask + bm_balack_mesa)\z
                              * min(0.25,\z
                                    - 1.5 + bm_balack_rock - 0.5 * bm_balack_mix_oil + 0.7 * bm_balack_basis_oil)",

  },
  ["tiny-fulgora-rock"] = {
    "optimized-decorative",
    "bm-tiny-balack-rock",
    "(1 - bm_balack_oil_mask) * (bm_balack_natural_mask + bm_balack_mesa)\z
                              * min(0.35,\z
                                    - 1.2 + bm_balack_rock - 0.5 * bm_balack_mix_oil + 0.7 * bm_balack_basis_oil)",

  },
}
for key, entity_data in pairs(balack_rock_data) do
  local new_entity = util.table.deepcopy(data.raw[entity_data[1]][key])
  new_entity.name = entity_data[2]
  new_entity.autoplace.probability_expression = entity_data[3]
  for j, picture in pairs(new_entity.pictures) do
    picture.filename = "__biological-machines-planet-balack__/graphics/decorative/fulgora-rock/" .. key .. "-".. string.format("%02d", j) ..".png"
  end
  if key == "big-fulgora-rock" then
    new_entity.map_color = {r = 60, g = 57, b = 57}
  end
  data:extend({new_entity})
end

data.raw["simple-entity"]["bm-big-balack-rock"].icon = "__biological-machines-planet-balack__/graphics/icons/big-fulgora-rock.png",



data:extend({
 scaled_cliff({
   mod_name = "__biological-machines-planet-balack__",
   name = "bm-cliff-balack",
   map_color = {r = 63, g = 60, b = 60},
   suffix = "balack",
   subfolder = "balack",
   scale = 1.0,
   has_lower_layer = true,
   sprite_size_multiplier = 2,
   factoriopedia_simulation = nil
 }),
})



------------------------------------------------------------DECORATIVES
local balack_decorative_data = {
  ["urchin-cactus"] = {
    name = "bm-balack-urchin-cactus",
    type = "optimized-decorative",
    tint = {0.5, 0.5, 0.5},
    --proability = "min(0.1, bm_balack_natural_mask * max(0, bm_balack_scrap_medium - bm_balack_rock - 0.75))",
    proability = "min(0.2, bm_balack_natural_mask * max(0, bm_balack_scrap_medium - bm_balack_rock - 0.25))",
    --density = 2,
    density = 1,
    restriction = nil,
  },
  ["wispy-lichen"] = {
    name = "bm-balack-wispy-lichen",
    type = "optimized-decorative",
    tint = {0.45, 0.36, 0.45},
    --proability = "min(0.1, fulgora_natural_mask * max(0, fulgora_scrap_medium + fulgora_rock - fulgora_basis_oil - 2.5))",
    proability = "min(0.14, fulgora_natural_mask * max(0, fulgora_scrap_medium + fulgora_rock - fulgora_basis_oil - 1.6))",
    density = 1,
    restriction = {"bm-balack-n-rock", "bm-balack-n-sand", "bm-balack-n-dunes", "bm-balack-n-dust", "bm-balack-oil-shallow"},
  },
  ["water-cane"] = {
    name = "bm-balack-water-cane",
    type = "tree",
    tint = {0.5, 0.65, 1},
    --proability = "min(0.1, fulgora_natural_mask * max(0, fulgora_scrap_medium + fulgora_rock - fulgora_basis_oil - 2.5))",
    proability = "- 0.3 + multioctave_noise{x = x * 4,\z
                                    y = y * 4,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_tree_small',\z
                                    octaves = 3,\z
                                    input_scale = 1/18}",
    density = 1,
    restriction = {"bm-balack-oil-shallow"},
  },
  ["ashland-lichen-tree"] = {
    name = "bm-balack-lichen-tree",
    type = "tree",
    tint = nil,
    proability = "- 0.3 + multioctave_noise{x = x * 4,\z
                                    y = y * 4,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_tree_small',\z
                                    octaves = 3,\z
                                    input_scale = 1/18}\z
                             - bm_bio_cube_buffer",
    density = 1,
    restriction = {"bm-balack-n-rock", "bm-balack-n-sand", "bm-balack-n-dunes"},
  },
  ["white-carpet-grass"] = {
    name = "bm-balack-carpet-grass",
    type = "optimized-decorative",
    tint = {0.4, 0.39, 0.4},
    proability = "- 0.75 + multioctave_noise{x = x * 10,\z
                                    y = y * 10,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_carpet_small',\z
                                    octaves = 3,\z
                                    input_scale = 1/18}",
    density = 1,
    restriction = {"bm-balack-n-rock", "bm-balack-n-sand", "bm-balack-n-dunes", "bm-balack-n-dust"},
  },
  ["brambles"] = {
    name = "bm-balack-brambles",
    type = "optimized-decorative",
    tint = {0.6, 0.6, 0.6},
    proability = "- 0.1 + multioctave_noise{x = x * 20,\z
                                    y = y * 20,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_brambles_small',\z
                                    octaves = 6,\z
                                    input_scale = 1/9}",
    density = 1,
    restriction = {"bm-balack-n-dust"},
  },
  ["blood-grape"] = {
    name = "bm-balack-blood-grape",
    type = "optimized-decorative",
    tint = {0.4, 0.4, 0.4},
    proability = "- 1.1 + multioctave_noise{x = x * 20,\z
                                    y = y * 20,\z
                                    persistence = 0.7,\z
                                    seed0 = map_seed,\z
                                    seed1 = 'bm_balack_grape_small',\z
                                    octaves = 6,\z
                                    input_scale = 1/9}",
    density = 1,
    restriction = {"bm-balack-n-dust"},
  },
}
local tintable_plant_parts = {"trunk", "leaves", "normal"}
for key, decorative_data in pairs(balack_decorative_data) do
  local new_decorative = util.table.deepcopy(data.raw[decorative_data.type][key])
  new_decorative.name = decorative_data.name
  new_decorative.autoplace.probability_expression = decorative_data.proability
  new_decorative.autoplace.placement_density  = decorative_data.density
  new_decorative.autoplace.tile_restriction = decorative_data.restriction

  if key == "water-cane" then
    new_decorative.emissions_per_second = nil
    for _, variation in pairs(new_decorative.variations) do
      for i=1, #tintable_plant_parts do
        variation[tintable_plant_parts[i]].tint = decorative_data.tint
      end
    end
  else
    for _, picture in pairs(new_decorative.pictures) do
      picture.tint = decorative_data.tint
    end
  end

  if key == "ashland-lichen-tree" or key == "water-cane" then
    --new_decorative.map_color = {0.2, 0.2, 0.2, 0.5}
    new_decorative.map_color = {0.15, 0.15, 0.15, 0.4}
  end

  data:extend({new_decorative})
end
