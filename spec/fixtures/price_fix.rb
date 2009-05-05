Price.fixture(:link_price) {{
  :feature_title => "Price per Link",
  :amount => 0.10,
  :name => "link_price"
}}

Price.fixture(:ab_test_price) {{
  :feature_title => "Price per Page",
  :amount => 1.00,
  :name => "ab_test_price"
}}

Price.fixture(:content_type_price) {{
  :feature_title => "Price for Content Type",
  :amount => 0.50,
  :name => "flat_page"
}}