local hunger_interval = 60 --ticks
local max_preferences = 9

local base_sat_per_sec = settings.global["bm-sat-per-sec"].value
local injured_sat_per_sec = settings.global["bm-sat-per-sec"].value * settings.global["bm-injury-sat-scalar"].value

--local special_equipment_names = {"biological-recycler", "artificial-organs"}

local foods = {
  ["bm-berry"] = {saturation = 15, effect = "bm-energized"},
  ["bm-berry-paste"] = {saturation = 60, effect = "bm-energized"},
  ["nutrients"] = {saturation = 15, effect = "bm-malnourished"},
  ["bm-nutrient-paste"] = {saturation = 60, effect = "bm-malnourished"},
  ["raw-fish"] = {saturation = 120, effect = "bm-well-nourished"},
  ["bm-canned-fish"] = {saturation = 120, effect = "bm-well-nourished"},
  ["yumako"] = {saturation = 30, effect = nil},
  ["yumako-mash"] = {saturation = 15, effect = nil},
  ["jellynut"] = {saturation = 30, effect = nil},
  ["jelly"] = {saturation = 8, effect = nil},
  ["bioflux"] = {saturation = 120, effect = nil},
  ["bm-nutrient-slurry"] = {saturation = 120, effect = nil},
  ["bm-fortified-nutrient-slurry"] = {saturation = 120, effect = "bm-energized-2"},
  ["bm-demolisher-meat"] = {saturation = 240, effect = "bm-well-nourished-2"},
  ["bm-demolisher-meat-barrel"] = {saturation = 240, effect = "bm-well-nourished-2"},
  ["uranium-235"] = {saturation = 600, effect = "bm-artificial-biology"},
}

local food_wrappers = {
  ["bm-canned-fish"] = "bm-empty-can",
  ["bm-demolisher-meat-barrel"] = "bm-barrel"
}

local foods_to_i = {}
local i_to_foods = {}
local foods_i = 1
for food, _ in pairs(foods) do
  foods_to_i[food] = foods_i
  i_to_foods[foods_i] = food
  foods_i = foods_i + 1
end
foods_to_i["none"] = foods_i
i_to_foods[foods_i] = "none"

local wrapped_i_to_foods = {}
for i = 1, foods_i - 1 do
  wrapped_i_to_foods[i] = {
    "",
    {"item-name."..i_to_foods[i]},
    " (",
    foods[i_to_foods[i]].saturation,
    " sat)"
  }
end
wrapped_i_to_foods[foods_i] = {"bmh-gui.none"}

local bmh_i_to_dd = {}
local bmh_dd_to_i = {}
for i=1, max_preferences do
  bmh_i_to_dd[i] = "bmh_dd_" .. i
  bmh_dd_to_i["bmh_dd_" .. i] = i
end

local default_prefs = {
  foods_to_i["raw-fish"],
  foods_to_i["bm-berry"],
  foods_to_i["bm-nutrient-paste"],
  foods_to_i["bm-canned-fish"],
  foods_to_i["bm-berry-paste"],
  foods_to_i["none"],
  foods_to_i["none"],
  foods_to_i["none"],
  foods_to_i["none"],
  foods_to_i["none"],
}



local function is_hungry(i)
  --[[
  if storage.hungry[i] and storage.hungry[i].is_hungry_pause then
    return false
  end
  ]]
  return game.get_player(i).physical_controller_type  == defines.controllers.character
end

local function get_food_inventory(i) --i is player index
  local player = game.get_player(i)
  local platform = player.physical_surface.platform
  local character = player.character
  if platform then
    return platform.hub.get_inventory(defines.inventory.hub_main)
  elseif character then
    return character.get_inventory(defines.inventory.character_main)
  else
    return nil
  end
end

local function apply_sticker(c, sticker) --c is character
  if sticker then
    c.surface.create_entity({name = sticker, position = c.position, target = c})
  end
end

--[[
local function is_special(n)
  for _, special_name in pairs(special_equipment_names) do
    if n == special_name then
      return true
    end
  end
  return false
end

local function check_equipment(i, player)
  local armor = player.character.get_inventory(defines.inventory.character_armor)[1]
  for _, n in pairs(special_equipment_names) do
    if armor.is_armor == false or armor.grid == nil then --is this check neccesary?
      storage.special_equipment[i][n] = false
    else
      storage.special_equipment[i][n] = has_equipment(armor.grid, n)
    end
  end
end
]]

local function has_equipment(grid, n)
  for q, _ in pairs(prototypes.quality) do
    if grid.count({name = n, quality = q}) > 0 then
      return true
    end
  end
  return false
end

local function get_special_equipment(i, c)
  local armor = c.get_inventory(defines.inventory.character_armor)[1]
  if armor.is_armor and armor.grid then
    return {
      ["bm-biological-recycler"] = has_equipment(armor.grid, "bm-biological-recycler"),
      ["bm-artificial-organs"] = has_equipment(armor.grid, "bm-artificial-organs"),
    }
  else
    return {
      ["bm-biological-recycler"] = false,
      ["bm-artificial-organs"] = false,
    }
  end
end

local function build_interface(i)
  local player = game.get_player(i)
  local player_elements = storage.elements[i]
  local screen_element = player.gui.screen
  local main_frame = screen_element.add{
    type = "frame", name = "bmh_main_frame", caption = {"bmh-gui.title"}
  }
  main_frame.auto_center = true
  player.opened = main_frame
  player_elements.main_frame = main_frame

  local content_frame = main_frame.add{
    type = "frame",
    name = "bmh_content_frame",
    direction = "vertical",
    style = "bmh_content_frame"
  }
  content_frame.add{
    type = "label",
    name = label,
    caption = {"bmh-gui.description", base_sat_per_sec, injured_sat_per_sec}
  }

  for pref_i, selected_i in pairs(storage.hungry[i].prefs) do
    local controls_flow = content_frame.add{
      type = "flow",
      name = "pref_flow_"..pref_i,
      direction = "horizontal",
      style = "bmh_controls_flow"
    }
    controls_flow.add{
      type = "label", name = label, caption = {"bmh-gui.preference_"..pref_i}
    }
    controls_flow.add{
      type = "drop-down",
      name = bmh_i_to_dd[pref_i],
      items = wrapped_i_to_foods,
      selected_index = selected_i
    }
  end

  local saturation_flow = content_frame.add{
    type = "flow",
    name = "saturation_flow",
    direction = "horizontal",
    style = "bmh_controls_flow"
  }
  saturation_flow.add{
    type = "label",
    name = bmh_saturation_label,
    caption = {"bmh-gui.current_saturation"}
  }
  player_elements.sat_number = saturation_flow.add{
    type = "label",
    name = bmh_saturation_label,
    caption = storage.hungry[i].saturation
  }

  content_frame.add{
    type = "button",
    name = "bmh_dump_sat",
    caption = {"bmh-gui.dump-sat"},
  }

  --[[
  local equipment_flow = content_frame.add{type="flow", name="equipment_flow", direction="horizontal", style="bmh_controls_flow"}
  equipment_flow.add{type="label", name=bmh_saturation_label, caption={"bmh-gui.current_equipment"}}
  if storage.special_equipment[i]["biological-recycler"] then
    equipment_flow.add{type="label", name=bmh_saturation_label, caption={"bmh-gui.equipment_recycler"}}
  end
  if storage.special_equipment[i]["artificial-organs"] then
    equipment_flow.add{type="label", name=bmh_saturation_label, caption={"bmh-gui.equipment_organs"}}
  end
  ]]

  --[[
  local widget_flow = content_frame.add{type="flow", name="widget_flow", direction="horizontal", style="bmh_controls_flow"}
  widget_flow.add{type="label", name="widget_checkbox_text", caption={"bmh-gui.widget_checkbox_text"}}
  widget_flow.add{type="checkbox", name="widget_checkbox", state=storage.show_widget[i]}
  ]]
end

local function toggle_interface(i)
  local player_elements = storage.elements[i]
  if player_elements.main_frame == nil then
    build_interface(i)
  else
    player_elements.main_frame.destroy()
    storage.elements[i] = {}
  end
end

local function update_interface(i)
  local player_elements = storage.elements[i]
  if player_elements.main_frame == nil then return end
  player_elements.sat_number.caption = storage.hungry[i].saturation
end

local function destroy_widget(i)
  local player_widgets = storage.widgets[i]
  if player_widgets.widget_frame then
    player_widgets.widget_frame.destroy()
    storage.widgets[i].widget_frame = nil
  end
end

--local oops = true
local function build_widget(i)
  update_interface(i)
  --[[
  if oops then
    storage.hungry[i].food = "none"

    storage.show_widget = {}
    storage.widgets = {}

    storage.widgets[1] = {}
    storage.show_widget[1] = true

    oops = false
  end
  ]]

  --if storage.show_widget[i] == false then destroy_widget(i) return end

  local player = game.get_player(i)

  if player.controller_type ~= defines.controllers.character or
  settings.get_player_settings(i)["bm-show-widget"].value == false then
    destroy_widget(i)
    return
  end

  local player_widgets = storage.widgets[i]
  local screen_element = player.gui.screen
  local widget_frame = nil

  if player_widgets.widget_frame then
    player_widgets.widget_frame.clear()
    widget_frame = player_widgets.widget_frame
  else
    widget_frame = screen_element.add{
      type = "frame",
      name = "bmh_widget_frame",
      direction = "vertical",
      style = "bmh_widget_frame"
    }
    player_widgets.widget_frame = widget_frame
    widget_frame.location = {0, player.display_resolution.height - ((96 + 60) * player.display_scale)}
    widget_frame.ignored_by_interaction = true
  end

  local curr_food = storage.hungry[i].food
  local curr_qual = storage.hungry[i].quality

  if curr_food == "none" then
    local sat_percent = math.min(1, math.max(0, storage.hungry[i].saturation / 120))
    widget_frame.add{type="sprite-button", sprite=("bm-food-icon-red"), style="bmh_widget_slot"}
    widget_frame.add{type="progressbar", value=0, style="bmh_widget_progressbar"}
    widget_frame.add{type="progressbar", value=sat_percent, style="bmh_widget_progressbar"}
  elseif curr_food == "bm-artificial-organs" or curr_food == "bm-biological-recycler" then
    widget_frame.add{type="sprite-button", sprite=("item/" .. curr_food), style="bmh_widget_slot"}
    widget_frame.add{type="progressbar", value=1, style="bmh_widget_progressbar"}
    widget_frame.add{type="progressbar", value=1, style="bmh_widget_progressbar"}
  else
    local curr_num = storage.hungry[i].food_inventory.get_item_count({name=curr_food, quality=curr_qual})
    local curr_stack = storage.hungry[i].food_inventory.find_item_stack({name=curr_food, quality=curr_qual})
    local curr_spoil = 0
    if curr_stack then
      curr_spoil = 1 - curr_stack.spoil_percent
    end
    local sat_percent = math.min(1, math.max(0, storage.hungry[i].saturation / foods[curr_food].saturation))
    widget_frame.add{type="sprite-button", sprite=("item/" .. curr_food), number=curr_num, quality=curr_qual, style="bmh_widget_slot"}
    widget_frame.add{type="progressbar", value=curr_spoil, style="bmh_widget_progressbar"}
    widget_frame.add{type="progressbar", value=sat_percent, style="bmh_widget_progressbar"}
  end
end

local function eat_until_full(i)
  local hunger = storage.hungry[i]
  while hunger.saturation < 0 do
    if hunger.food_inventory.remove({name = hunger.food, quality = hunger.quality}) == 1 then
      hunger.saturation = hunger.saturation + foods[hunger.food].saturation
    else
      hunger.saturation = 0
    end
  end
end

local function initialize_prefs(i)
  local old_prefs = storage.hungry[i].prefs
  if old_prefs == nil then
    old_prefs = {}
  end
  local new_prefs = {}
  for pref_i=1, settings.get_player_settings(i)["bm-pref-count"].value do
    new_prefs[pref_i] = old_prefs[pref_i] or default_prefs[pref_i]
  end
  storage.hungry[i].prefs = new_prefs
end

local function initialize_player(i)
  storage.hungry[i] = {
  is_hungry = is_hungry(i),
  --prefs = {foods_to_i["raw-fish"], foods_to_i["berry"], foods_to_i["nutrient-paste"]},
  saturation = 0,
  effect = nil,
  food = nil,
  quality = nil,
  food_inventory = get_food_inventory(i)
  }
  initialize_prefs(i)

  --[[
  storage.special_equipment[i] = {}
  for _, n in pairs(special_equipment_names) do
  storage.special_equipment[i][n] = false
  end
  ]]

  storage.elements[i] = {}
  storage.widgets[i] = {}
  storage.show_widget[i] = true
end

--setup
script.on_init(function()
  if remote.interfaces.freeplay then
    local created_items = remote.call('freeplay',"get_created_items")
    created_items["bm-nutrient-paste"] = 10
    remote.call('freeplay', "set_created_items", created_items)
    local respawn_items = remote.call('freeplay',"get_respawn_items")
    respawn_items["bm-nutrient-paste"] = 10
    remote.call('freeplay', "set_respawn_items", respawn_items)
  end

  storage.hungry = {}
  --storage.special_equipment = {}
  storage.elements = {}
  storage.widgets = {}
  storage.show_widget = {}

  for i, _ in pairs(game.players) do
    initialize_player(i)
  end

  --[[
  storage.custom_events = remote.call("bm_custom_events", "custom_events")
  if script.active_mods["biological-machines-radioactive-tissue"] then
    --add event respawn_menu_opened which pauses hunger until respawn_in_tank is called. use respawn event
    script.on_event(storage.custom_events.respawn_in_tank, function(event)
      local i = event.player_index
      storage.hungry[i].food_inventory = get_food_inventory(i)
    end)
  end
  ]]
end)

--[[
script.on_load(function()
  if script.active_mods["biological-machines-radioactive-tissue"] then
    --add event respawn_menu_opened which pauses hunger until respawn_in_tank is called. use respawn event
    script.on_event(storage.custom_events.respawn_in_tank, function(event)
      local i = event.player_index
      storage.hungry[i].food_inventory = get_food_inventory(i)
    end)
  end
end)
]]

script.on_event(defines.events.on_player_created, function(event)
  initialize_player(event.player_index)
end)

--updates storage.hungry
script.on_event(defines.events.on_player_joined_game, function(event)
  local i = event.player_index
  storage.hungry[i].is_hungry = is_hungry(i)
  storage.hungry[i].food_inventory = get_food_inventory(i)
end)

script.on_event(defines.events.on_player_died, function(event)
  storage.hungry[event.player_index].is_hungry = false
end)

script.on_event(defines.events.on_player_respawned, function(event)
  local i = event.player_index
  --[[
  if script.active_mods["biological-machines-radioactive-tissue"] then
    storage.hungry[i].is_hungry_pause = true
  end
  ]]
  storage.hungry[i].saturation = 0
  storage.hungry[i].is_hungry = is_hungry(i)
  storage.hungry[i].food_inventory = get_food_inventory(i)
end)

script.on_event(defines.events.on_player_left_game, function(event)
  storage.hungry[event.player_index].is_hungry = false
end)

script.on_event(defines.events.on_player_removed, function(event)
  local i = event.player_index
  storage.hungry[i] = nil
  --storage.special_equipment[i] = nil
  storage.elements[i] = nil
  storage.widgets[i] = nil
end)

script.on_event(defines.events.on_player_controller_changed, function(event)
  local i = event.player_index
  storage.hungry[i].is_hungry = is_hungry(i)
  storage.hungry[i].food_inventory = get_food_inventory(i)
  if storage.hungry[i].food then
    build_widget(i)
  end
end)

script.on_event(defines.events.on_player_changed_surface, function(event)
  local i = event.player_index
  storage.hungry[i].food_inventory = get_food_inventory(i)
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  if event.setting == "bmh-pref-count" then
    if event.player_index then
      initialize_prefs(event.player_index)
    else
      for i, _ in pairs(game.players) do
        initialize_prefs(i)
      end
    end
  elseif event.setting == "bmh-sat-per-sec"
  or event.setting == "bmh-injury-sat-scalar" then
    base_sat_per_sec = settings.global["bm-sat-per-sec"].value
    injured_sat_per_sec = settings.global["bm-sat-per-sec"].value
    * settings.global["bm-injury-sat-scalar"].value
  end
end)

if script.active_mods["biological-machines-cloning"] then
  --add event respawn_menu_opened which pauses hunger until respawn_in_tank is called. use respawn event
  script.on_event(defines.events.script_raised_built, function(event)
    if event.entity.type ~= "character" or event.entity.player == nil then
      return
    end
    local i = event.entity.player.index
    --[[
    storage.hungry[i].is_hungry_pause = nil
    ]]
    storage.hungry[i].is_hungry = is_hungry(i)
    storage.hungry[i].food_inventory = get_food_inventory(i)

    if storage.hungry[i].food_inventory.get_item_count("bm-nutrient-paste") == 0 then
      storage.hungry[i].saturation = 120
      storage.hungry[i].food = "none"
    else
      storage.hungry[i].saturation = 0
    end
  end)
end

--updates storage.special_equipment
--[[
script.on_event(defines.events.on_equipment_inserted, function(event)
  local player = event.grid.player_owner
  if player == nil then return end --checks if grid is on player armor
  local i = player.index
  if is_special(event.equipment.name) and storage.hungry[i].is_hungry then
    check_equipment(i, player)
  end
end)

script.on_event(defines.events.on_equipment_removed, function(event)
  local player = event.grid.player_owner
  if player == nil then return end --checks if grid is on player armor
  local i = player.index
  if is_special(event.equipment) and storage.hungry[i].is_hungry then
    check_equipment(i, player)
  end
end)

script.on_event(defines.events.on_player_armor_inventory_changed, function(event)
  local i = event.player_index
  if storage.hungry[i].is_hungry then
    local player = game.get_player(i)
    check_equipment(i, player)
  end
end)

script.on_event(defines.events.on_player_fast_transferred, function(event)
    check_equipment(event.player_index, game.get_player(i))
end)
]]

--update gui elements
script.on_event("bmh_toggle_interface", function(event)
    toggle_interface(event.player_index)
end)

script.on_event(defines.events.on_lua_shortcut, function(event)
    if event.prototype_name == "bm-hunger" then
      toggle_interface(event.player_index)
    end
end)

script.on_event(defines.events.on_gui_closed, function(event)
    --is this first check neccesary?
    if event.element and event.element.name == "bmh_main_frame" then
        toggle_interface(event.player_index)
    end
end)

script.on_event(defines.events.on_gui_selection_state_changed, function(event)
  --check if element is from this mod
  if event.element.parent.parent.name == "bmh_content_frame" then
    local player_prefs = storage.hungry[event.player_index].prefs
    local pref_i = bmh_dd_to_i[event.element.name]
    player_prefs[pref_i] = event.element.selected_index
  end
end)

script.on_event(defines.events.on_gui_click, function(event)
  --check if element is from this mod
  if event.element.name == "bmh_dump_sat" then
    storage.hungry[event.player_index].saturation = 0
  end
end)

--[[
script.on_event(defines.events.on_gui_checked_state_changed, function(event)
  if event.element.name == "widget_checkbox" then
    storage.show_widget[event.player_index] = not storage.show_widget[event.player_index]
  end
end)
]]

--hunger tick
script.on_nth_tick(hunger_interval, function(event)
  for i, hunger in pairs(storage.hungry) do
    if hunger.is_hungry and game.get_player(i) and game.get_player(i).character then
      local s
      local c = game.get_player(i).character
      if c.get_health_ratio() < 1 then
        s = hunger.saturation - injured_sat_per_sec
      else
        s = hunger.saturation - base_sat_per_sec
      end

      if hunger.saturation > 0 then
        hunger.saturation = s
        apply_sticker(c, hunger.effect)
        build_widget(i)
        return
      end

      local special_equipment = get_special_equipment(i, c)
      for pref_i=1, #hunger.prefs do
        local food = i_to_foods[hunger.prefs[pref_i]]
        if food ~= "none" then
          for q, _ in pairs(prototypes.quality) do
            if food ~= "uranium-235"
            and hunger.food_inventory.remove({name = food, quality = q}) == 1 then
              hunger.saturation = s + foods[food].saturation
              hunger.effect = foods[food].effect
              hunger.food = food
              hunger.quality = q
              apply_sticker(c, hunger.effect)
              if food_wrappers[food] then
                hunger.food_inventory.insert({name = food_wrappers[food], quality = q})
              end
              eat_until_full(i)
              build_widget(i)
              return
            elseif food == "uranium-235"
            and special_equipment["bm-artificial-organs"]
            and hunger.food_inventory.remove({name = "uranium-235", quality = q}) == 1 then
              local food_data = foods["uranium-235"]
              hunger.saturation = s + foods[food].saturation
              hunger.effect = foods[food].effect
              hunger.food = food
              hunger.quality = q
              apply_sticker(c, hunger.effect)
              eat_until_full(i)
              build_widget(i)
              return
            end
          end
        end
      end

      if special_equipment["bm-artificial-organs"] then
        hunger.food = "bm-artificial-organs"
      elseif special_equipment["bm-biological-recycler"] then
        hunger.food = "bm-biological-recycler"
        apply_sticker(c, "bm-malnourished")
      else
        hunger.food = "none"
        apply_sticker(c, "bm-starving")
        --[[
        log(c.name.."   "..c.health.."   "..tostring(c.driving))
        if game.get_player(i).physical_vehicle then
          log(game.get_player(i).physical_vehicle.name)
        end
        ]]
        --c.damage(0.1 * hunger_interval, "enemy", "starvation")
        c.health = c.health -  0.1 * hunger_interval
        c.tick_of_last_damage = event.tick
        if c.health <= 0 then
          c.die()
        end
      end
      hunger.saturation = 0
      hunger.quality = "normal"
      build_widget(i)
    else
      destroy_widget(i)
    end
  end
end)



script.on_event(defines.events.on_post_entity_died, function(event)
  --check if surface is space platform, move items into hub, destroy corpse
  local surface = game.get_surface(event.surface_index)
  local platform = surface.platform
  if not platform then return end
  local platform_inventory = platform.hub.get_inventory(defines.inventory.hub_main)
  local corpse = event.corpses[1]
  local corpse_inventory = corpse.get_inventory(defines.inventory.character_corpse)
  local i = 1
  while i <= #corpse_inventory do
    if corpse_inventory[i].valid_for_read then
      local empty_stack = platform_inventory.find_empty_stack()
      if empty_stack then
        empty_stack.swap_stack(corpse_inventory[i])
      else
        surface.spill_inventory{
          position = platform.hub.position,
          inventory = corpse_inventory,
          force = platform.force,
          max_radius = 20,
          drop_full_stack = true,
        }
        i = #corpse_inventory
      end
    end
    i = i + 1
  end
  corpse_inventory.clear()
  corpse.destroy()
end, {{filter = "type", type = "character"}})
