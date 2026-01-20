--require ("util")



script.on_init(function()
	if remote.interfaces.freeplay
	and settings.startup["bm-shelter-override"]
	and settings.startup["bm-shelter-override"].value then
    local created_items = remote.call('freeplay',"get_created_items")
		created_items["kr-shelter"] = 1
    remote.call('freeplay', "set_created_items", created_items)
  end
end)
