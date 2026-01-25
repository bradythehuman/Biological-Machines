require ("util")



local tank_spawn_shift = {x = -0.9, y = 1.3}

local armor_names = {}
for armor_name, _ in
pairs(prototypes.get_item_filtered({{filter = "type", type = "armor"}})) do
	table.insert(armor_names, armor_name)
end



script.on_init(function()
	storage.tanks = {}
	storage.gui = {open_tank = {}, respawn = {}, hub = {}}
end)



local id_to_name = {
	["bm-clone-suspended"] = "bm-suspension-tank-filled",
	["bm-tank-prepared"] = "bm-suspension-tank-prepared",
	["bm-suspended-clone-died"] = "bm-suspension-tank",
	["bm-prepared-tank-died"] = "bm-suspension-tank",
}

local function connections_unwrapper(connections)
	local unwrapper = {}
	for i=1, #connections do
		table.insert(unwrapper, connections[i].target)
	end
	return unwrapper
end

local function connections_connector(tank, connections, wire_id)
	local connector = tank.get_wire_connector(defines.wire_connector_id.circuit_red, true)
	for i=1, #connections do
		if connections[i].valid then
			connector.connect_to(connections[i])
		end
	end
end

local function get_tank_id(tank)
	return tostring(tank.surface.index)..tostring(tank.position.x)..tostring(tank.position.y)
end

local function get_tank_name(tank_id)
	if storage.tanks[tank_id] then
		return storage.tanks[tank_id].name
	else
		return tank_id
	end
end

local function destroy_gui(player_index, gui_type)
	if not storage.gui[gui_type][player_index] then return end
	storage.gui[gui_type][player_index].main.destroy()
	storage.gui[gui_type][player_index] = nil
end

local function build_respawn_gui(player_index, selected_dd_id)
	local player = game.get_player(player_index)
	local drop_down_options = {{"bm-gui.respawn-dd-option"}}
	local drop_down_id = {"respawn"}
	local ddi = 2
	for tank_id, stored_data in pairs(storage.tanks) do
		if not stored_data.tank.valid then
			storage.tanks[tank_id] = nil
		elseif stored_data.clone_qual then
			drop_down_options[ddi] = stored_data.name
			drop_down_id[ddi] = tank_id
			ddi = ddi + 1
		end
	end

	local selected_dd_index = 1
	ddi = 1
	while ddi <= #drop_down_id do
		if selected_dd_id == drop_down_id[ddi] then
			selected_dd_index = ddi
			ddi = #drop_down_id + 1
		end
		ddi = ddi + 1
	end
	local selected_position = {0, 0}
	local selected_surface_index = 0
	if selected_dd_index == 1 then
		selected_surface_index = player.surface_index
		selected_position = player.position
		--selected_position = player.force.get_spawn_position(selected_surface_index)
	else
		local tank = storage.tanks[drop_down_id[selected_dd_index]].tank
		selected_surface_index = tank.surface_index
		selected_position = tank.position
	end

	local screen_element = player.gui.screen
	local main = screen_element.add{
    type = "frame",
		name = "bm_respawn_main",
		direction = "vertical",
		caption = {"bm-gui.respawn-title"},
  }
  main.auto_center = true
  player.opened = main
	camera_frame = main.add{
    type = "frame",
    name = "bm_camera_frame",
    direction = "vertical",
		style = "inside_shallow_frame",
  }
	local camera_element = camera_frame.add{
		type = "camera",
		name = "bm_respawn_camera",
		position = selected_position,
		surface_index = selected_surface_index,
		zoom = 1.5,
	}
	local camera_style = camera_element.style
	camera_style.minimal_width = 600
	camera_style.minimal_height = 600
	local content = main.add{
    type = "frame",
    name = "bm_respawn_content",
    direction = "horizontal",
		style = "inside_shallow_frame_with_padding",
  }
	--content.style.horizontal_spacing = 15
	local drop_down_element = content.add{
		type = "drop-down",
		name = "bm_respawn_drop_down",
		items = drop_down_options,
		selected_index = selected_dd_index
	}
	local surface = game.get_surface(selected_surface_index)
	local surface_name = ""
	local sprite_path = ""
	local platform_sprite_path = ""
	if surface.planet then
		surface_name = surface.planet.prototype.localised_name
		sprite_path = "space-location."..surface.name
	else
		local platform = surface.platform
		surface_name = platform.name
		sprite_path = "surface.space-platform"
		if platform.space_location then
			platform_sprite_path = "space-location."..platform.space_location.name
		elseif platform.space_connection then
			platform_sprite_path = "space-connection."..platform.space_connection.name
		end
	end
	content.add{
		type="label", name=label, caption={
			"bm-gui.respawn_label", selected_position.x, selected_position.y, surface_name
		}
	}
	content.add{
    type = "sprite",
    name = "bm_respawn_sprite",
		sprite = sprite_path
  }
	if platform_sprite_path ~= "" then
		content.add{
	    type = "sprite",
	    name = "bm_respawn_platform_sprite",
			sprite = platform_sprite_path
	  }
	end

	local dialog = main.add{
    type = "flow",
    name = "bm_respawn_dialog",
    direction = "horizontal",
		style = "dialog_buttons_horizontal_flow"
  }
	dialog.add{
		type = "empty-widget",
		style = "draggable_space",
	}
	dialog.add{
		type = "button",
		name = "bm_confirm_respawn",
		style = "confirm_button",
		caption = {"bm-gui.confirm-respawn"}
	}
	dialog.style.horizontal_align = "center"

	storage.gui.respawn[player.index] = {
		main = main,
		drop_down_element = drop_down_element,
		drop_down_options = drop_down_options,
		drop_down_id = drop_down_id,
		--character = player.character
	}

	if player.controller_type == defines.controllers.character then
		player.character.destructible = false
		player.set_controller({
	    type = defines.controllers.cutscene,
	    start_position = player.position,
	    start_zoom = 2,
	    waypoints = {{position = player.position, transition_time = 1000000, time_to_wait = 1000000}}
	  })
	end

	--[[
	local character = player.character
	character.destructible = false
	character.character_running_speed_modifier = -1
	character.character_crafting_speed_modifier = -1
	character.character_mining_speed_modifier = -1
	]]
	--[[
	character.character_build_distance_bonus = -1
	character.character_reach_distance_bonus = -1
	character.character_resource_reach_distance_bonus = -1
	character.character_item_pickup_distance_bonus = -1
	character.character_loot_pickup_distance_bonus = -1
	]]
end

local function rebuild_respawn_gui(player_index)
	local stored_respawn = storage.gui.respawn[player_index]
	local selected_index = stored_respawn.drop_down_element.selected_index
	local selected_dd_id = stored_respawn.drop_down_id[selected_index]
	destroy_gui(player_index, "respawn")
	build_respawn_gui(player_index, selected_dd_id)
end

local function attempt_rebuild_respawn_guis()
	for player_index, _ in pairs(storage.gui.respawn) do
		rebuild_respawn_gui(player_index)
	end
end

local function transform_tank(tank, new_name)
	local tank_id = get_tank_id(tank)
	local surface = tank.surface
	local tank_data = {
		name = new_name,
		position = tank.position,
		direction = tank.direction,
		quality = tank.quality,
		force = tank.force,
	}

	if new_name ~= "bm-suspension-tank" and tank.name == "bm-suspension-tank" then
		local recipe, quality = tank.get_recipe()
		local control = tank.get_or_create_control_behavior()
		storage.tanks[tank_id] = {
			recipe = recipe.name,
			--quality = quality.name,
			quality = quality,
			control = {
				circuit_set_recipe = control.circuit_set_recipe,
				circuit_read_contents = control.circuit_read_contents,
				include_in_crafting = control.include_in_crafting,
				include_fuel = control.include_fuel,
				circuit_read_ingredients = control.circuit_read_ingredients,
				circuit_read_recipe_finished = control.circuit_read_recipe_finished,
				circuit_recipe_finished_signal = util.table.deepcopy(control.circuit_recipe_finished_signal),
				circuit_read_working = control.circuit_read_working,
				circuit_working_signal = util.table.deepcopy(control.circuit_working_signal),
				circuit_enable_disable = control.circuit_enable_disable,
				circuit_condition = util.table.deepcopy(control.circuit_condition),
				connect_to_logistic_network = control.connect_to_logistic_network,
				logistic_condition = util.table.deepcopy(control.logistic_condition),
			},
			connections = {
				red = connections_unwrapper(tank.get_wire_connector(defines.wire_connector_id.circuit_red, true).real_connections),
				green = connections_unwrapper(tank.get_wire_connector(defines.wire_connector_id.circuit_green, true).real_connections)
			},
			direction = tank.direction,
			name = get_tank_name(tank_id),
		}
	end

	local stored_data = storage.tanks[tank_id]

	if new_name == "bm-suspension-tank-filled" and tank.name == "bm-suspension-tank" then
		stored_data.clone_qual = storage.tanks[tank_id].quality
	else
		stored_data.clone_qual = nil
	end

	tank.destroy()
	local new_tank = surface.create_entity(tank_data)
	stored_data.tank = new_tank

	if new_name == "bm-suspension-tank" then
		new_tank.set_recipe(stored_data.recipe, stored_data.quality)
		local control = new_tank.get_or_create_control_behavior()
		for k, v in pairs(stored_data.control) do
			control[k] = v
		end
		connections_connector(new_tank, stored_data.connections["red"], defines.wire_connector_id.circuit_red)
		connections_connector(new_tank, stored_data.connections["green"], defines.wire_connector_id.circuit_green)
	end

	if new_name ~= "bm-suspension-tank-prepared" then
		new_tank.direction = stored_data.direction
	end
end

local function destroy_tank_data(event)
	storage.tanks[get_tank_id(event.entity)] = nil
end

local function check_tanks_valid()
	for tank_id, stored_data in pairs(storage.tanks) do
		if not stored_data.tank.valid then
			storage.tanks[tank_id] = nil
		end
	end
end



script.on_event(defines.events.on_script_trigger_effect, function(event)
	local new_name = id_to_name[event.effect_id]
	if not new_name then return end
	local tank = event.target_entity or event.source_entity
	if tank == nil or tank.name ~= "bm-suspension-tank" then return end
	transform_tank(tank, new_name)
	if new_name == "bm-suspension-tank-filled" then
		attempt_rebuild_respawn_guis()
	end
end)



script.on_event(defines.events.on_gui_opened, function(event)
	if event.entity == nil then return end
	local player_index = event.player_index
	local player = game.get_player(player_index)

	if event.entity.name == "bm-suspension-tank-prepared"
	or event.entity.name == "bm-suspension-tank-filled" then
		if storage.gui["open_tank"][player_index] then
			destroy_gui(player_index, "open_tank")
		end
		local tank_id = get_tank_id(event.entity)
		local main = player.gui.relative.add({
	    type = "frame",
	    name = "bm_tank_frame",
	    direction = "vertical",
	  })
	  main.anchor = {
	    gui = defines.relative_gui_type.assembling_machine_gui,
	    position = defines.relative_gui_position["right"],
	  }
		if event.entity.name == "bm-suspension-tank-prepared" then
			main.add{type="button", name="bm_tank_enter", caption={"bm-gui.enter-tank"}}
		end
		main.add{type="button", name="bm_tank_dump", caption={"bm-gui.dump-tank"}}
		main.add{
			type = "textfield",
			name = "bm_tank_name",
			text = get_tank_name(tank_id)
		}
		main.style.top_padding = 8
	  main.style.vertically_stretchable = false
	  main.style.horizontally_stretchable = false
		storage.gui.open_tank[event.player_index] = {
			main = main,
			tank_id = tank_id,
			entity = event.entity,
		}

	elseif event.entity.name == "space-platform-hub"
	and player.physical_controller_type == defines.controllers.character
	and event.entity.surface_index == player.character.surface_index then
		if storage.gui["hub"][player_index] then
			destroy_gui(player_index, "hub")
		end
		local main = player.gui.relative.add({
	    type = "frame",
	    name = "bm_platform_hub_frame",
	    direction = "horizontal",
	  })
	  main.anchor = {
	    gui = defines.relative_gui_type.space_platform_hub_gui,
	    position = defines.relative_gui_position["bottom"],
	  }
		main.add{
			type = "button",
			name = "bm_hub_player_empty",
			caption = {"bm-gui.hub-player-empty"},
			tooltip = {"bm-gui.hub-player-empty-tooltip"},
		}
		main.add{
			type = "button",
			name = "bm_hub_player_insert",
			caption = {"bm-gui.hub-player-insert"},
			tooltip = {"bm-gui.hub-player-insert-tooltip"},
		}
		storage.gui.hub[event.player_index] = {
			main = main,
			entity = event.entity,
		}
	end
end)

script.on_event(defines.events.on_gui_closed, function(event)
	if not event.entity then return end
	if event.entity.name == "bm-suspension-tank-prepared"
	or event.entity.name == "bm-suspension-tank-filled" then
		destroy_gui(event.player_index, "open_tank")
	end
	if event.entity.name == "space-platform-hub" then
		destroy_gui(event.player_index, "hub")
	end
end)

script.on_event(defines.events.on_gui_text_changed, function(event)
	local stored_gui = storage.gui.open_tank[event.player_index]
	if event.element.name == "bm_tank_name" then
		storage.tanks[stored_gui.tank_id].name = event.text
	end
end)

local inventories = {
	"character_main", "character_guns", "character_ammo",
	"character_armor", "character_trash"
}

script.on_event(defines.events.on_gui_click, function(event)
	if event.element.name == "bm_tank_enter" then
		--check if character is able to enter tank. if not, explaination and return
		local player = game.get_player(event.player_index)
		local valid_in_hub = false
		if player.hub
		and player.physical_controller_type == defines.controllers.character then
			valid_in_hub = true
		end

		if not valid_in_hub
		and player.controller_type ~= defines.controllers.character then
			player.create_local_flying_text{
				text = {"bm-gui.controller-type"},
				position = player.position,
				create_at_cursor = true,
				time_to_live = 300,
				speed = 0.5,
			}
			return
		end
		local old_character = player.character
		if not valid_in_hub and old_character.driving then
			player.create_local_flying_text{
				text = {"bm-gui.exit-vehicle"},
				position = player.position,
				create_at_cursor = true,
				time_to_live = 300,
				speed = 0.5,
			}
			return
		end
		for i=1, #inventories do
			local inventory = old_character.get_inventory(defines.inventory[inventories[i]])
			if inventory.count_empty_stacks(true, true) < #inventory then
				player.create_local_flying_text{
					text = {"bm-gui.empty-inventory"},
					position = player.position,
					create_at_cursor = true,
					time_to_live = 600,
					speed = 0.5,
				}
				return
			end
		end

		local tank = storage.gui.open_tank[event.player_index].entity
		local tank_id = get_tank_id(tank)
		transform_tank(tank, "bm-suspension-tank-filled")
		destroy_gui(event.player_index, "open_tank")
		local stored_data = storage.tanks[tank_id]
		stored_data.clone_qual = old_character.quality

		--old_character.die()
		player.character = nil
		player.create_character({name = "character", quality = "normal"})
		-- teleport to planet spawnpoint. if on platform teleport to nauvis spawnpoint
		if valid_in_hub then
			local spawn_surface = game.get_surface(1)
			local spawn_position = spawn_surface.find_non_colliding_position("character",
				player.force.get_spawn_position(spawn_surface), 0, 0.1
			)
			player.teleport(spawn_position, 1)
		else
			local spawn_surface = player.surface
			local spawn_position = spawn_surface.find_non_colliding_position("character",
				player.force.get_spawn_position(spawn_surface), 0, 0.1
			)
			player.teleport(spawn_position)
		end
		local respawn_items = remote.call('freeplay',"get_respawn_items")
		local main_inventory = player.get_main_inventory()
		for item_name, item_count in pairs(respawn_items) do
			main_inventory.insert({name = item_name, count = item_count})
		end
		old_character.destroy()
		attempt_rebuild_respawn_guis()
		build_respawn_gui(event.player_index, "respawn")

	elseif event.element.name == "bm_tank_dump" then
		local tank = storage.gui.open_tank[event.player_index].entity
		transform_tank(tank, "bm-suspension-tank")
		destroy_gui(event.player_index, "open_tank")
		attempt_rebuild_respawn_guis()

	elseif event.element.name == "bm_confirm_respawn" then
		local player = game.get_player(event.player_index)
		player.set_controller({
        type = defines.controllers.character,
        character = player.cutscene_character
    })
		local old_character = player.character
		old_character.destructible = true
		local stored_gui = storage.gui.respawn[event.player_index]
		local tank_id = stored_gui.drop_down_id[stored_gui.drop_down_element.selected_index]
		if tank_id == "respawn" then
			--[[
			old_character.character_running_speed_modifier = 0
			old_character.character_crafting_speed_modifier = 0
			old_character.character_mining_speed_modifier = 0
			]]
			--[[
			character.character_build_distance_bonus = 0
			character.character_reach_distance_bonus = 0
			character.character_resource_reach_distance_bonus = 0
			character.character_item_pickup_distance_bonus = 0
			character.character_loot_pickup_distance_bonus = 0
			]]
			script.raise_script_built{entity = player.character}
			destroy_gui(event.player_index, "respawn")
			return
		end

		local stored_tank = storage.tanks[tank_id]
		if stored_tank.clone_qual == nil then
			destroy_gui(event.player_index, "respawn")
			build_respawn_gui(event.player_index, "respawn")
			player.create_local_flying_text{
				text = {"bm-gui.invalid-clone"},
				position = player.position,
				create_at_cursor = true,
				time_to_live = 600,
				speed = 0.5,
			}
			return
		end

		local tank = stored_tank.tank
		--[[
		player.character = tank.surface.create_entity{
			name = "character",
			position = tank.position,
			quality = stored_tank.clone_qual,
			force = player.character.force,
			fast_replace = true,
			raise_built = true,
		}
		]]
		player.character = nil
		player.create_character({name="character", quality=stored_tank.clone_qual})
		--[[
		player.set_controller({
			type = defines.controllers.character,
			character = player.character,
		})
		--]]
		platform = game.get_surface(tank.surface_index).platform
		if platform then
			player.enter_space_platform(platform)
		else
			player.teleport({tank.position.x + tank_spawn_shift.x, tank.position.y + tank_spawn_shift.y}, tank.surface_index)
		end

		local new_character = player.character
		local quality_level = stored_tank.clone_qual.level
		new_character.character_running_speed_modifier = 0.1 * quality_level
		new_character.character_crafting_speed_modifier = 0.5 * quality_level
		new_character.character_mining_speed_modifier = 0.5 * quality_level
		--[[
		player.character.teleport({
			position = tank.position,
			surface = tank.surface_index,
		})
		]]
		old_character.destroy()
		script.raise_script_built{entity = player.character}
		transform_tank(tank, "bm-suspension-tank")

		for other_player_index, other_respawn_data in pairs(storage.gui.respawn) do
			if event.player_index ~= other_player_index then
				local invalid_index = nil
				for index, value in pairs(other_respawn_data.drop_down_id) do
					if value == tank_id then
						invalid_index = index
					end
				end
				if invalid_index
				and other_respawn_data.drop_down_element.selected_index == invalid_index then
					destroy_gui(other_player_index, "respawn")
					build_respawn_gui(other_player_index, "respawn")
				end
			end
		end
		destroy_gui(event.player_index, "respawn")
		attempt_rebuild_respawn_guis()
		--[[
		script.raise_event(storage.custom_events.respawn_in_tank, {
			player_index = event.player_index
		})
		]]

	---[[
	elseif event.element.name == "bm_hub_player_empty" then
		local player = game.get_player(event.player_index)
		local hub = storage.gui.hub[event.player_index].entity
		local hub_inventory = hub.get_inventory(defines.inventory.hub_main)
		local player_inventories = {
			character_guns = player.character.get_inventory(defines.inventory.character_guns),
			character_ammo = player.character.get_inventory(defines.inventory.character_ammo),
			character_armor = player.character.get_inventory(defines.inventory.character_armor),
		}
		for _, inventory_object in pairs(player_inventories) do
			local i = 1
			while i <= #inventory_object do
				if inventory_object[i].valid_for_read then
					local empty_stack = hub_inventory.find_empty_stack()
					if empty_stack then
		        empty_stack.swap_stack(inventory_object[i])
		      else
		        surface.spill_inventory{
		          position = hub.position,
		          inventory = corpse_inventory,
		          force = player.force,
		          max_radius = 20,
		          drop_full_stack = true,
		        }
						i = #inventory_object
		      end
				end
				i = i + 1
			end
		end

	elseif event.element.name == "bm_hub_player_insert" then
		local player = game.get_player(event.player_index)
		local armor_inventory = player.character.get_inventory(defines.inventory.character_armor)
		local hub = storage.gui.hub[event.player_index].entity
		local hub_inventory = hub.get_inventory(defines.inventory.hub_main)
		for i=1, #armor_names do
			local armor_stack = hub_inventory.find_item_stack(armor_names[i])
			if armor_stack then
				armor_stack.swap_stack(armor_inventory[1])
				return
			end
		end
	--]]
	end
end)

script.on_event(defines.events.on_gui_selection_state_changed, function(event)
	if event.element.name == "bm_respawn_drop_down" then
		rebuild_respawn_gui(event.player_index)
	end
end)



script.on_event(defines.events.on_entity_died, function(event)
	local entity_name = event.entity.name
	if entity_name == "bm-suspension-tank" then
		destroy_tank_data(event)
	elseif entity_name == "bm-suspension-tank-filled" then
		attempt_rebuild_respawn_guis()
	end
end, {
	{filter = "name", name = "bm-suspension-tank"},
	{filter = "name", name = "bm-suspension-tank-filled"}
})

script.on_event(defines.events.on_player_mined_entity,
function(event) destroy_tank_data(event) end,
{
	{filter = "name", name = "bm-suspension-tank"},
	{filter = "name", name = "bm-suspension-tank-filled"},
	{filter = "name", name = "bm-suspension-tank-prepared"}
})

script.on_event(defines.events.on_robot_mined_entity,
function(event) destroy_tank_data(event) end,
{
	{filter = "name", name = "bm-suspension-tank"},
	{filter = "name", name = "bm-suspension-tank-filled"},
	{filter = "name", name = "bm-suspension-tank-prepared"}
})

script.on_event(defines.events.on_space_platform_mined_entity,
function(event) destroy_tank_data(event) end,
{
	{filter = "name", name = "bm-suspension-tank"},
	{filter = "name", name = "bm-suspension-tank-filled"},
	{filter = "name", name = "bm-suspension-tank-prepared"}
})



script.on_event(defines.events.on_player_respawned, function(event)
	build_respawn_gui(event.player_index, "respawn")
end)



script.on_event(defines.events.on_surface_cleared, function(event)
	check_tanks_valid()
end)

script.on_event(defines.events.on_surface_deleted, function(event)
	check_tanks_valid()
end)
