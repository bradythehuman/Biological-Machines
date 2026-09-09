script.on_event(defines.events.on_player_created, function(event)
  local player = game.get_player(event.player_index)
  if player == nil then return end
  game.create_surface("bm-dyson-sphere")
  player.teleport({x=0,y=0}, "bm-dyson-sphere")
end)
