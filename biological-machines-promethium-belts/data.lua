require("prototypes.particles")
require("prototypes.entity.explosions")
require("prototypes.entity.transport-belts")
require("prototypes.entity.remnants")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")

if mods["aai-loaders"] and settings.startup["aai-loaders-mode"].value ~= "graphics-only" then
  require("prototypes.aai-compatibility")
end

if mods["aai-loaders-sane"]then
  require("prototypes.sane-aai-compatibility")
end
