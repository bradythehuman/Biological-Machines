local fill_icon = "__biological-machines-core__/graphics/offshore-dump/dump-fill.png"
local highlights_icon = "__biological-machines-core__/graphics/offshore-dump/dump-highlights.png"



----------------------------------------------FLUID DUMP RECIPES
data.raw["fluid"]["fusion-plasma"].auto_void = false



local function generate_void_recipe_icons(fluid, fluid_icon_shift)
  local icons = {
    {
      icon = fill_icon,
      tint = util.get_color_with_alpha(fluid.base_color, 1, true)
    },
    {
      icon = highlights_icon,
    },
  }
  local fluid_icons = fluid.icons
  if fluid_icons == nil then
    fluid_icons = {{icon=fluid.icon, icon_size=(fluid.icon_size or defines.default_icon_size)}}
  end
  icons = util.combine_icons(icons, fluid_icons, {scale = 0.5, shift = fluid_icon_shift}, fluid.icon_size or defines.default_icon_size)
  return icons
end

local function is_valid_fluid(fluid)
  if fluid.hidden or fluid.parameter then
    return false
  elseif fluid.auto_void == false then --auto_void may be used by third party mods to opt their fluids out of voiding
    return false
  elseif not (fluid.icon or fluid.icons) then
    log("Can't make void recipe for "..fluid.name..", it doesn't have any icon or icons.")
    return false
  end
  return true
end



for name, fluid in pairs(data.raw["fluid"]) do
  if is_valid_fluid(fluid) then
    data:extend({{
      type = "recipe",
      name = fluid.name .. "-void",
      localised_name = {"", fluid.localised_name or {"fluid-name." .. fluid.name}, " ", {"fluid-name.bm-spill"}},
      category = "bm-fluid-void",
      subgroup = "bm-fluid-void",
      order = fluid.order,
      icons = generate_void_recipe_icons(fluid, {7, -8}),
      --localised_name = {"item-name.spill", fluid.localised_name or {"fluid-name." .. fluid.name}},
      enabled = true,
      allow_productivity = false,
      allow_decomposition = false,
      show_amount_in_title = false,
      hide_from_player_crafting = true,
      factoriopedia_alternative = "bm-offshore-dump",
      hide_from_signal_gui = false,
      energy_required = 1,
      ingredients = {{type = "fluid", name = name, amount = 1200}},
      results = {}
    }})
  end
end



--------------------------------------------DUMP/PUMP PLACABILITY
for tile_name, tile in pairs(data.raw["tile"]) do
  local layers = tile.collision_mask.layers
  if layers.water_tile then
    layers.bm_fluid = true
  end
end

local pump_layers = data.raw["offshore-pump"]["offshore-pump"].tile_buildability_rules[2].required_tiles.layers
pump_layers.water_tile = nil
pump_layers.bm_fluid = true

if data.raw["furnace"]["bm-offshore-dump"] then
  local dump_layers = data.raw["furnace"]["bm-offshore-dump"].tile_buildability_rules[2].required_tiles.layers
  dump_layers.water_tile = nil
  dump_layers.bm_fluid = true
end
