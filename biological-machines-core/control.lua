--------------------------------------------------ALTERNATIVE NUTRIENTS
local drinkable_barrels = {["bm-nutrient-wine-barrel"] = 1, ["bm-ethanol-barrel"] = 2}

if prototypes.item["bm-nutrient-wine-barrel"] then
	script.on_event(defines.events.on_player_used_capsule, function(event)
		local effect_modifier = drinkable_barrels[event.item.name]
		if effect_modifier then
			local player = game.get_player(event.player_index)
			local c = player.character
			local s = c.surface
			local p = c.position
			s.create_entity({name = "bm-drunk-"..effect_modifier, position = p, target = c})
			s.create_entity({name = "bm-hungover-"..effect_modifier, position = p, target = c})
			player.get_main_inventory().insert({name="barrel", quality=event.quality})
		end
	end)
end



----------------------------------------------------------BOT START
local function equip_armour(index)
  storage.equipped = storage.equipped or {}
  if storage.equipped[index] then return end

  local player = game.get_player(index)
  if player and player.valid then
    local character = player.character
    if character and character.valid then
      local armor_slot = character.get_inventory(defines.inventory.character_armor)
      if armor_slot and armor_slot.insert{name="bm-survival-armor", count=1} then
        -- Only add equipment if the survival harness was successfully inserterted into character's armour slot
        local grid = character.grid
        if grid then
          local roboport = grid.put{name="personal-roboport-equipment"}
          if roboport then
            roboport.energy = roboport.max_energy
          end
          local battery = grid.put{name="battery-equipment"}
          if battery then
            battery.energy = battery.max_energy
          end
          grid.put{name="solar-panel-equipment"}
          grid.put{name="solar-panel-equipment"}
          grid.put{name="solar-panel-equipment"}
        end
        character.insert{name="construction-robot", count=10}
				-- Flag player as equipped so this isn't run again
				storage.equipped[index] = true
      end
    end
  end
end

if prototypes.item["bm-survival-armor"] then
	---[[
	script.on_event(defines.events.on_cutscene_cancelled, function(event)
	  equip_armour(event.player_index)
	end)
	--]]

	---[[
	script.on_event(defines.events.on_player_created, function(event)
	  equip_armour(event.player_index)
	end)
	--]]
end
