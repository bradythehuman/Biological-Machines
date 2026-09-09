if settings.startup["moshine-data-colors"] and settings.startup["moshine-data-colors"].value == false then
  if data.raw.item["bm-datacell-warp-path"] then
    data.raw.item["bm-datacell-warp-path"].localised_name = {"item-name.bm-datacell-warp-path_nocolor"}
  end
  if data.raw.item["bm-datacell-solved-warp-path"] then
    data.raw.item["bm-datacell-solved-warp-path"].localised_name = {"item-name.bm-datacell-solved-warp-path_nocolor"}
  end

  if data.raw.fluid["bm-solved-warp-path-data"] then
    data.raw.fluid["bm-solved-warp-path-data"].localised_name = {"fluid-name.bm-solved-warp-path-data_nocolor"}
  end

  if data.raw.recipe["bm-datacell-solved-warp-path"] then
    data.raw.recipe["bm-datacell-solved-warp-path"].localised_name = {"recipe-name.bm-datacell-solved-warp-path_nocolor"}
  end
  if data.raw.recipe["bm-datacell-remove-solved-warp-path"] then
    data.raw.recipe["bm-datacell-remove-solved-warp-path"].localised_name = {"recipe-name.bm-datacell-remove-solved-warp-path_nocolor"}
  end
end
