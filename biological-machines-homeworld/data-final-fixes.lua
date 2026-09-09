--Code taken from AsteroidBelt
--Code taken from Director_K1
if data.raw["utility-sprites"] and data.raw["utility-sprites"]["default"] then
  local utility_sprites = data.raw["utility-sprites"]["default"]
  local starmap_star = utility_sprites["starmap_star"] or {
    type = "sprite",
    priority = "extra-high-no-scale",
    flags = {"gui-icon"},
    layers = {
      {
        filename = "__core__/graphics/icons/starmap-star.png",
        size = 512,
        scale = 0.5,
        shift = { 0, 0 },
        draw_as_light = true,
      },
    },
  }
  starmap_star.layers = starmap_star.layers or {}

  --[[
  table.insert(starmap_star.layers, {
    filename = "__biological-machines-homeworld__/graphics/home-system-background.png",
    size = 1750,
    scale = 0.6,
    shift = {110 * 32 + 50, -35.8 * 32 + 45},
  })
  ]]

--[[
  table.insert(starmap_star.layers, {
    filename = "__biological-machines-homeworld__/graphics/debris-starmap-dark.png",
    size = 2436,
    scale = 0.44,
    shift = {110 * 32, -35.8 * 32},
  })
  ]]

  local solar_system_sprites = {
    {
      filename = "__biological-machines-homeworld__/graphics/debris-starmap-dark.png",
      size = 2436,
      scale = 0.44,
      shift = {110 * 32, -35.8 * 32},
    },
    {
			filename = "__core__/graphics/icons/starmap-star.png",
			size = 512,
			scale = 0.5,
			shift = { 0, 0 },
		},
  }

  for _, sprite in ipairs(solar_system_sprites) do
    table.insert(starmap_star.layers, sprite)
  end

  utility_sprites["starmap_star"] = starmap_star
end
