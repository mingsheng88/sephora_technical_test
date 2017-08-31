JSONAPI.configure do |config|
  config.json_key_format = :underscored_key
  config.route_format = :underscored_route
  config.default_paginator = :paged
  config.top_level_meta_include_page_count = true
  config.top_level_meta_page_count_key = :page_count
end
