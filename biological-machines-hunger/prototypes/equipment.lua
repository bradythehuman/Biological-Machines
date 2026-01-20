data:extend({
  {
    type = "battery-equipment",
    name = "bm-biological-recycler",
    sprite = {
      filename = "__biological-machines-hunger__/graphics/biological-recycler.png",
      width = 128,
      height = 128,
      priority = "medium",
      scale = 0.5
    },
    shape = {width = 2, height = 2, type = "full"},
    energy_source =
    {
      type = "electric",
      buffer_capacity = "100kJ",
      usage_priority = "primary-input",
      drain = "20kW"
    },
    categories = {"armor"}
  },
  {
    type = "battery-equipment",
    name = "bm-artificial-organs",
    sprite = {
      filename = "__biological-machines-core__/graphics/artificial-organs.png",
      width = 256,
      height = 256,
      priority = "medium",
      scale = 0.5
    },
    shape = {width = 4, height = 4, type = "full"},
    energy_source =
    {
      type = "electric",
      buffer_capacity = "1MJ",
      usage_priority = "primary-input",
      drain = "200kW"
    },
    categories = {"armor"}
  },
})
