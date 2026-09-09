local panglite_incubator = util.table.deepcopy(data.raw.furnace["matter_printer"])
panglite_incubator.type = "assembling-machine"
--panglite_incubator.name = "bm-panglite-incubator"
panglite_incubator.localised_name = {"entity-name.bm-panglite-incubator"}
--panglite_incubator.minable = {mining_time = 0.2, result = "bm-panglite-incubator"}
panglite_incubator.crafting_categories = {"bm-panglite-incubator"}
panglite_incubator.surface_conditions = {{property = "pressure", min = 1401, max = 1401}}

data.raw.furnace["matter_printer"] = nil

data:extend({panglite_incubator})

--data.raw.furnace["matter_printer"].hidden = true
