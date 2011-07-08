Skyline::Configuration.configure do |config|
  config.assets_path = File.join(Rails.root,"tmp/upload")
  config.media_file_cache_path = File.join(Rails.root,"/tmp/media_files/cache")
  config.rss_section_cache_path = File.join(Rails.root,"/tmp/rss_sections/cache")
  
  config.sections[:default] -= ["content_item_section"]
  
  config.articles = ["NewsItem", "Product"]
  config.content_classes = ["CalendarItem"]
end
