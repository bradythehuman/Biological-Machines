require("prototypes.robotics-facility-updates")

local dh = require("__biological-machines-core__.data-helper")



dh.recycle_to_self("stone-brick")



if not mods["biological-machines-industry"]
or not settings.startup["bm-rails-from-landfill"].value then
  dh.recycle_to_self("rail")
end



data.raw.item["fluorine-barrel"].default_import_location = "aquilo"
