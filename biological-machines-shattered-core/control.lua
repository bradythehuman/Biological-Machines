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



script.on_event(defines.events.on_surface_created, function(event)
  local surface = game.get_surface(event.surface_index)
  if surface.name == "shattered-planet" then
    storage.shattered_planet = surface
    storage.asteroids = {}

    surface.create_entity({name = "hidden-electric-energy-interface", position = {0, 10}})
  end
end)



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
