Skyline::Configuration.configure do |config|
  config.assets_path = File.join(Rails.root,"tmp/upload")
  config.media_file_cache_path = File.join(Rails.root,"/tmp/media_files/cache")
  config.rss_section_cache_path = File.join(Rails.root,"/tmp/rss_sections/cache")
  
  # If you have a working configuration of Apache Solr
  # you can turn solr_indexing on to enable search functionality
  # in Skyline CMS.
  # As an example we've included the files schema.xml and solrconfig.xml
  # which we used with the 1.4 nightly builds
  
  # NOTE: ExtractingRequestHandler does not work out of the box on Solr 1.4
  # NOTE 2: to work with Rsolr you will need to add the following gems
  # gem "curb", "0.4.2.0"
  # gem "mwmitchell-rsolr", "0.8.8",      :require_as => "rsolr"
  # gem "mwmitchell-rsolr-ext", "0.7.35", :require_as => "rsolr-ext"
  config.solr_indexing = false
  
  config.sections[:default] -= ["content_item_section"]
  
  config.articles = ["NewsItem", "Product"]
  config.content_classes = ["CalendarItem"]
end
