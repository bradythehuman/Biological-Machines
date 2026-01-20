local empty_space_tile = util.table.deepcopy(data.raw.tile["empty-space"])
empty_space_tile.name = "bm-empty-space-2"
empty_space_tile.destroys_dropped_items = true
empty_space_tile.default_cover_tile = nil
--[[
empty_space_tile.collision_mask = {
  layers = {
    item=true, empty_space = true, ground_tile = true, player = true, car = true,
  },
  colliding_with_tiles_only = true,
  not_colliding_with_itself = true,
}
]]
empty_space_tile.collision_mask.colliding_with_tiles_only = true
empty_space_tile.collision_mask.not_colliding_with_itself = true
table.insert(out_of_map_tile_type_names, "bm-empty-space-2")

data:extend({empty_space_tile})
