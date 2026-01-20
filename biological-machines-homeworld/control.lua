local th = require("trade-helper")



--------------------------------------------------------LOCAL HELPERS
local function get_trade_count(item_name)
  return storage.trade_counts[item_name] or 0
end

local function get_tradable_count(item_name)
  return storage.tradable_counts[item_name] or 0
end

local function build_trade_gui(player_index)
  local player = game.get_player(player_index)

  local main = player.gui.relative.add({
    type = "frame",
    name = "bm_io_frame",
    direction = "vertical",
  })
  main.anchor = {
    gui = defines.relative_gui_type.container_gui,
    position = defines.relative_gui_position["right"],
  }

  for item_name, initial_amount in pairs(th.initial_trades) do
    local trade = main.add{
      type = "flow",
      direction = "horizontal",
    }
    trade.add{
      type = "sprite",
      sprite = "item." .. item_name,
    }
    local tradable_count = tostring(get_tradable_count(item_name))
    local trade_count = get_trade_count(item_name)
    local required_amount = tostring(th.scale_trade(initial_amount, trade_count))
    trade.add{
      type = "label",
      --name = "bm_trade_" .. trade_count,
      caption = tradable_count .. " / " .. required_amount .. " (" .. tostring(trade_count) .. ")",
    }
    --trade_count = trade_count + 1
  end

  main.style.top_padding = 8
  main.style.vertically_stretchable = false
  main.style.horizontally_stretchable = false
  storage.trade_gui[player_index] = {
    main = main,
  }
end

local function close_trade_gui(player_index)
  if not storage.trade_gui[player_index] then return end
  storage.trade_gui[player_index].main.destroy()
  storage.trade_gui[player_index] = nil
end

local function attempt_build_link(entity)
  local surface_index = entity.surface_index
  local existing_link = storage.energy_links[surface_index]
  if not existing_link or not existing_link.valid then
    storage.energy_links[surface_index] = entity
    return
  end
  local surface = entity.surface
  local entity_data = {
    type = "simple-entity-with-owner",
    name = "bm-inactive-interstellar-energy-link",
    force = entity.force,
    position = entity.position,
    create_build_effect_smoke = false,
  }
  entity.destroy()
  surface.create_entity(entity_data)
end



--------------------------------------------------------------EVENTS
script.on_init(function()
  if remote.interfaces.freeplay then
    remote.call('freeplay', "set_custom_intro_message", {"bm.intro-msg"})
  end

  if remote.interfaces.space_finish_script then
    remote.call("space_finish_script", "set_no_victory", true)
  end

  game.set_win_ending_info{
    title = {"bm.victory-title"},
    message = {"bm.victory-message", th.final_payout},
    --bullet_points = {},
    final_message = {"bm.victory-final"},
    image_path = "__base__/script/freeplay/victory-space-age.png",
  }
end)

script.on_event(defines.events.on_surface_created, function(event)
  local surface = game.get_surface(event.surface_index)
  if surface.name == "bm-dyson-sphere" then
    storage.input = surface.create_entity({name = "bm-station-input", position = {-20, -20}, force = "player"})
    storage.output = surface.create_entity({name = "bm-station-output", position = {20, -20}, force = "player"})
    surface.create_entity({name = "hidden-electric-energy-interface", position = {20, -20}})
    storage.trade_counts = {}
    storage.tradable_counts = {}
    storage.owed_credits = 0
    storage.trade_gui = {}
    storage.finished = {}
    storage.energy_links = {}
  end
end)

script.on_nth_tick(th.station_io_ticks, function(event)
  if storage.input == nil then return end
  local update_gui = false

  for item_name, initial_amount in pairs(th.initial_trades) do
    local input_amount = storage.input.get_item_count(item_name)
    if input_amount > 0 then
      storage.input.remove_item({name = item_name, count = input_amount})
      local tradable_count = get_tradable_count(item_name) + input_amount
      local trade_count = get_trade_count(item_name)
      local required_amount = th.scale_trade(initial_amount, trade_count)
      local payout = 0
      while tradable_count >= required_amount do
        tradable_count = tradable_count - required_amount
        trade_count = trade_count + 1
        required_amount = th.scale_trade(initial_amount, trade_count)
        payout = payout + th.initial_payout
      end
      storage.owed_credits = storage.owed_credits + payout
      storage.trade_counts[item_name] = trade_count
      storage.tradable_counts[item_name] = tradable_count
      update_gui = true
    end
  end

  for player_index, _ in pairs(storage.trade_gui) do
    close_trade_gui(player_index)
    build_trade_gui(player_index)
  end

  if storage.owed_credits > 0 then
    local paid_credits = storage.output.insert({name = "bm-credit", count = storage.owed_credits})
    storage.owed_credits = storage.owed_credits - paid_credits
  end
end)

script.on_event(defines.events.on_gui_opened, function(event)
	if event.entity == nil then return end

	if event.entity.name == "bm-station-input"
	or event.entity.name == "bm-station-output" then
		build_trade_gui(event.player_index)
	end
end)

script.on_event(defines.events.on_gui_closed, function(event)
	if not event.entity then return end
  if event.entity.name == "bm-station-input"
	or event.entity.name == "bm-station-output" then
    close_trade_gui(event.player_index)
	end
end)

script.on_event(defines.events.on_space_platform_changed_state, function(event)
  local platform = event.platform
  local location = platform.space_location
  if not location or location.name ~= "bm-new-system" then return end

  local surface = platform.surface
  local surface_index = surface.index
  --local force = game.forces["player"]
  local force = platform.force
  for _, player in pairs(game.players) do
    if player.hub and player.hub.surface_index == surface_index then
      platform.space_location = "solar-system-edge"
      force.print({"bm.final-platform-returned", platform.index})
      force.print({"bm.player-on-final-platform"})
      return
    end
  end

  if surface.count_entities_filtered{name = "bm-suspension-tank-filled"} == 0 then
    platform.space_location = "solar-system-edge"
    force.print({"bm.final-platform-returned", platform.index})
    force.print({"bm.no-clone-on-final-platform"})
    return
  end

  player_force.print({"bm.final-platform-removed", platform.index})

  if not storage.finished[force.name] then
    storage.finished[force.name] = true
    game.reset_game_state()
    game.enable_galaxy_of_fame_button = true
    game.set_game_state{
      game_finished = true,
      player_won = true,
      can_continue = true,
      victorious_force = force
    }
  end

  storage.owed_credits = storage.owed_credits + th.final_payout
  platform.destroy()
end)

script.on_event(defines.events.on_built_entity, function(event)
  attempt_build_link(event.entity)
end, {{filter = "name", name = "bm-interstellar-energy-link"}})

script.on_event(defines.events.on_robot_built_entity, function(event)
  attempt_build_link(event.entity)
end, {{filter = "name", name = "bm-interstellar-energy-link"}})

script.on_event(defines.events.on_space_platform_built_entity, function(event)
  attempt_build_link(event.entity)
end, {{filter = "name", name = "bm-interstellar-energy-link"}})
