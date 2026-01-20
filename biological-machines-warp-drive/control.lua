script.on_event(defines.events.on_script_trigger_effect, function(event)
  if event.effect_id ~= "bm-warp" then return end
  local surface = game.get_surface(event.surface_index)
  local platform = surface.platform
  local connection = platform.space_connection

  if platform.speed <= 0 or not connection then
    local drive = surface.find_entity("bm-warp-drive", event.source_position)
    if not drive or not drive.valid then return end
    local _, quality = drive.get_recipe()
    drive.get_inventory(defines.inventory.crafter_input).insert(
      {name = "bm-warp-power-cell", count = 1, quality = quality}
    )
    return
  end

  if connection.from == platform.last_visited_space_location then
    platform.space_location = connection.to
  else
    platform.space_location = connection.from
  end

  platform.clear_ejected_items()
  for _, asteroid in pairs(surface.find_entities_filtered({type = "asteroid"})) do
    asteroid.destroy{}
  end
end)
