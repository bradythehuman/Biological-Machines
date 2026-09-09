local dh = require("__biological-machines-core__.data-helper")



--Add new datacells to lab
local new_datacells = {"bm-datacell-warp-path", "bm-datacell-solved-warp-path"}
for _, new_datacell in pairs(new_datacells) do
  table.insert(data.raw["lab"]["neural_computer"].inputs, new_datacell)
end



dh.add_prereq("bm-warp-drive", "bm-warp-space")
