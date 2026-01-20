local styles = data.raw["gui-style"].default
styles["bmh_content_frame"] = {
    type = "frame_style",
    parent = "inside_shallow_frame_with_padding",
    vertically_stretchable = "on",
    horizontally_stretchable = "on",
    vertical_flow_style = {
      type = "vertical_flow_style",
      vertical_spacing = 8
    },
}
styles["bmh_controls_flow"] = {
    type = "horizontal_flow_style",
    vertical_align = "center",
    horizontal_spacing = 8
}
styles["bmh_widget_frame"] = {
  type = "frame_style",
  padding = 0,
  use_header_filler = false,
  header_flow_style =
  {
    type = "horizontal_flow_style",
    parent = "frame_header_flow",
    bottom_padding = 4
  },
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 2
  },
}
styles["bmh_widget_slot"] = {
  type = "button_style",
  parent = "button",
  size = 40,
  padding = 0,
  default_graphical_set = {
    base = {border = 4, position = {0, 424}, size = 80}
  },
  pie_progress_color = {0.98, 0.66, 0.22, 0.5}
}
styles["bmh_widget_progressbar"] = {
  type = "progressbar_style",
  bar_width = 4,
  width = 40,
  padding = 0,
  height = 4,
  --top_padding = -4,
  bottom_padding = 4,
  color = {1, 1, 1},
  --[[
  other_colors = {
    {less_than = 0.10, color = {r = 1}},
    {less_than = 0.25, color = {1, 0.5, 0.25}},
    {less_than = 1, color = {1, 1, 1}}
  },
  ]]
  bar = {position = {415, 48}, corner_size = 8}
}



data:extend({
    {
        type = "custom-input",
        name = "bmh_toggle_interface",
        key_sequence = "CONTROL + H",
        order = "a"
    },
    {
    type = "shortcut",
    name = "bm-hunger",
    order = "z",
    action = "lua",
    localised_name = {"shortcut.bm-hunger"},
    associated_control_input = "bmh_toggle_interface",
    icon = "__biological-machines-hunger__/graphics/hunger-shortcut.png",
    icon_size = 56,
    small_icon = "__biological-machines-hunger__/graphics/hunger-shortcut-small.png",
    small_icon_size = 24
  }
})
