local contact = util.table.deepcopy(data.raw["night-vision-equipment"]["night-vision-equipment"])
contact.name = "bm-cybernetic-contact"
contact.sprite = {
  filename = "__biological-machines-radioactive-tissue__/graphics/cybernetic-contact.png",
  width = 64,
  height = 64,
  priority = "medium",
  scale = 0.5
}
contact.shape = {width = 1, height = 1, type = "full"}
data:extend({contact})
