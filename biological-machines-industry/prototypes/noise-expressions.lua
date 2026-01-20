local stone_ap = data.raw["resource"]["stone"].autoplace
stone_ap.richness_expression = "1.5 * " .. stone_ap.richness_expression

local gleba_stone_le = data.raw["noise-expression"]["gleba_stone_richness"].local_expressions
gleba_stone_le.richness = "2 * control:gleba_stone:richness"
gleba_stone_le.frequency =  "2 * control:gleba_stone:frequency"

local vulcanus_coal_richness = data.raw["noise-expression"]["vulcanus_coal_richness"]
vulcanus_coal_richness.expression = "2 * "..vulcanus_coal_richness.expression


data:extend({
  {
    type = "noise-expression",
    name = "vulcanus_starting_potash",
    expression = "starting_spot_at_angle{ angle = vulcanus_ashlands_angle + 45 * vulcanus_starting_direction,\z
                                          distance = 120 * vulcanus_starting_area_radius,\z
                                          radius = 20 * potash_size,\z
                                          x_distortion = 0.5 * vulcanus_resource_wobble_y,\z
                                          y_distortion = 0.5 * vulcanus_resource_wobble_x}"
  },
  {
    type = "noise-expression",
    name = "potash_size",
    expression = "slider_rescale(control:potash:size, 2)"
  },
  {
    type = "noise-expression",
    name = "potash_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    -- vulcanus place spots for coal = 782349
    expression = "max(vulcanus_starting_potash,\z
                      min(1 - vulcanus_starting_circle,\z
                          vulcanus_place_non_metal_spots(496827, 12, 1,\z
                                                         potash_size * min(1.2, vulcanus_ore_dist) * 25,\z
                                                         control:potash:frequency,\z
                                                         vulcanus_ashlands_resource_favorability)))"
  },
  {
    type = "noise-expression",
    name = "potash_probability",
    expression = "(control:potash:size > 0) * (1000 * ((1 + potash_region) * random_penalty_between(0.9, 1, 1) - 1))"
  },
  {
    type = "noise-expression",
    name = "potash_richness",
    expression = "potash_region * random_penalty_between(0.9, 1, 1)\z
                  * 18000 * vulcanus_starting_area_multiplier\z
                  * control:potash:richness / potash_size"
  },
})
