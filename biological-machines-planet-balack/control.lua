script.on_event(defines.events.on_surface_created, function(event)
  local surface = game.get_surface(event.surface_index)
  if surface.name == "bm-balack" then
    --surface.freeze_daytime = true
    --surface.daytime = 0.4

    surface.dusk = 0.5 / surface.ticks_per_day
    surface.evening = 1 / surface.ticks_per_day
    surface.dawn = 1
    surface.morning = (surface.ticks_per_day - 0.5) / surface.ticks_per_day
    --surface.morning = 0.99

    --surface.set_pollution({0, 0}, 100000)
    game.forces["enemy"].set_evolution_factor(1, event.surface_index)
    storage.balack = surface
  elseif surface.name == "shattered-planet"
  and settings.startup["bm-shattered-core"].value then
    storage.shattered_planet = surface
    storage.asteroids = {}

    surface.create_entity({name = "hidden-electric-energy-interface", position = {0, 10}})
  end
end)

script.on_event(defines.events.on_player_changed_surface, function(event)
  if not event.surface_index then return end
  local surface = game.surfaces[event.surface_index]
  if surface.name == "bm-balack" then
    --game.players[event.player_index].enable_flashlight()
  end
end)

local balack_pentapod_table = {
  ["bm-balack-stomper-pentapod"] = true,
  ["big-wriggler-pentapod"] = true,
}

--[[
local balack_enemy_table = {
  ["bm-balack-stomper-pentapod"] = true,
  ["big-wriggler-pentapod"] = true,
  ["bm-balack-big-snapper"] = true,
  ["bm-balack-behemoth-snapper"] = true,
  ["bm-balack-behemoth-worm"] = true,
}
]]

local function move_balack_enemies(radius)
  if not (storage.balack and storage.balack.valid) then return end
  local enemies = storage.balack.find_enemy_units({0, 0}, radius)
  if balack_pentapod_table then
    for _, enemy in pairs(enemies) do
      enemy.commandable.set_command({
        type = defines.command.go_to_location,
        destination = {0, 0},
        distraction = defines.distraction.by_anything,
      })
      --[[
      if balack_pentapod_table[enemy.name] then
        enemy.commandable.set_command({
          type = defines.command.go_to_location,
          destination = {0, 0},
          distraction = defines.distraction.by_anything,
        })
      end
      ]]
    end
  end
end

local function target_balack_enemies(radius)
  if not (storage.balack and storage.balack.valid) then return end
  local bio_cube = nil
  for quality_name, _ in pairs(prototypes.quality) do
    if not bio_cube then
      bio_cube = storage.balack.find_entity(
        {name = "bm-bio-cube", quality = quality_name}, {0, 0}
      )
    end
  end
  if not bio_cube then return end
  local enemies = storage.balack.find_enemy_units({0, 0}, radius)
  for _, enemy in pairs(enemies) do
    enemy.commandable.set_command({
      type = defines.command.attack,
      target = bio_cube,
      distraction = defines.distraction.by_anything,
    })
  end
end

script.on_nth_tick(60 * 60 * 12, function(event)
  move_balack_enemies(325)
end)

script.on_nth_tick(60 * 60 * 3, function(event)
  move_balack_enemies(200)
end)

script.on_nth_tick(60 * 45, function(event)
  target_balack_enemies(20)
end)

local function spawn_promethium_asteroid(spawn_angle, velocity_scalar)
  local velocity_angle = spawn_angle + math.pi * (1 + (math.random() - 0.5) / 5)
  local asteroid = storage.shattered_planet.create_entity({
    name = "bm-unstable-promethium-asteroid",
    position = {
      x = 125 * math.cos(spawn_angle),
      y = 125 * math.sin(spawn_angle)
    },
    velocity = {
      x = velocity_scalar * math.cos(velocity_angle),
      y = velocity_scalar * math.sin(velocity_angle)
    }
  })
  table.insert(storage.asteroids, {
    asteroid = asteroid,
    timer = 10 * (0.9 * math.random() + math.min(0.15, 1 - 12 * velocity_scalar)),
  })
end

if settings.startup["bm-shattered-core"].value then
  script.on_nth_tick(60 * 6, function(event)
    if not storage.shattered_planet or not storage.shattered_planet.valid then
      return
    end

    for asteroid_index, asteroid_data in pairs(storage.asteroids) do
      asteroid_data.timer = asteroid_data.timer - 1
      if asteroid_data.timer < 0 then
        if asteroid_data.asteroid.valid then
          asteroid_data.asteroid.die()
        end
        storage.asteroids[asteroid_index] = nil
      end
    end

    if math.random() > 0.2 then return end
    local spawn_angle = 2 * math.pi * math.random()
    local velocity_scalar = 0.025 + 0.1 * math.random()
    spawn_promethium_asteroid(spawn_angle, velocity_scalar)

    if math.random() > 0.15 then return end
    spawn_promethium_asteroid(spawn_angle - 0.03 * math.pi, 1.15 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle, 1.3 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle + 0.03 * math.pi, 1.15 * velocity_scalar)

    if math.random() > 0.1 then return end
    spawn_promethium_asteroid(spawn_angle - 0.04 * math.pi, 1 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle - 0.02 * math.pi, 1.3 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle - 0.01 * math.pi, 1.45 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle, 1.6 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle + 0.01 * math.pi, 1.45 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle + 0.02 * math.pi, 1.3 * velocity_scalar)
    spawn_promethium_asteroid(spawn_angle + 0.04 * math.pi, 1 * velocity_scalar)
  end)
end

script.on_event(defines.events.on_player_mined_entity, function(event)
  event.entity.die()
end, {{filter = "name", name = "bm-balack-stomper-shell"}})

script.on_event(defines.events.on_robot_mined_entity, function(event)
  event.entity.die()
end, {{filter = "name", name = "bm-balack-stomper-shell"}})

--[[
script.on_event(defines.events.on_unit_group_finished_gathering , function(event)
  if not (storage.balack and storage.balack.valid)
  or storage.balack ~= event.group.surface then
    return
  end
  event.group.set_command({
    type = defines.command.go_to_location,
    destination = {0, 0},
    distraction = defines.distraction.by_anything,
  })
end)

script.on_event(defines.events.on_unit_removed_from_group, function(event)
  if not (storage.balack and storage.balack.valid)
  or storage.balack ~= event.unit.surface then
    return
  end
  event.unit.commandable.set_command({
    type = defines.command.go_to_location,
    destination = {0, 0},
    distraction = defines.distraction.by_anything,
  })
end)
]]
