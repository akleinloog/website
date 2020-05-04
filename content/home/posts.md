+++
widget = "pages"
headless = true
active = true
weight = 20

title = "Recent Posts"
subtitle = ""

[content]
  page_type = "post"
  count = 5
  offset = 0
  order = "desc"

  [content.filters]
    tag = ""
    category = ""
    publication_type = ""
    author = ""
    exclude_featured = false
  
[design]
  # Toggle between the various page layout types.
  #   1 = List
  #   2 = Compact
  #   3 = Card
  #   4 = Citation (publication only)
  view = 2
  
[design.background]
  
[advanced]
 css_style = ""
 css_class = ""
+++
