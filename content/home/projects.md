+++
widget = "portfolio"
headless = true
active = true
weight = 30

title = "Projects"
subtitle = ""

[content]
  page_type = "project"
  filter_default = 0
  
  [[content.filter_button]]
    name = "All"
    tag = "*"
  
  [[content.filter_button]]
    name = "Open Source"
    tag = "Open Source"
  
  [[content.filter_button]]
    name = "Commercial"
    tag = "Commercial"

[design]

  columns = "2"

  # Toggle between the various page layout types.
  #   1 = List
  #   2 = Compact
  #   3 = Card
  #   5 = Showcase
  view = 3

  flip_alt_rows = false

[design.background]
  
[advanced]
 css_style = ""
 css_class = ""
+++

