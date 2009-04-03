Link.fixture {{
  :source_page      => source = Page.gen(:root),
  :destination_page => Page.gen(:zero_depth, :parent => source),
  :height           => Kernel.rand(800),
  :width            => Kernel.rand(480),
  :x_coord          => Kernel.rand(480),
  :y_coord          => Kernel.rand(800)
}}

Link.fixture(:for_create) {{
  :height   => Kernel.rand(600),
  :width    => Kernel.rand(400),
  :x_coord  => Kernel.rand(480),
  :y_coord  => Kernel.rand(800)
}}