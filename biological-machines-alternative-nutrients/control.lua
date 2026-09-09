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
