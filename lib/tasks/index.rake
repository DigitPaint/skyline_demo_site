namespace :solr do
  desc "Index all Pages"
  task :index => :environment do
    if Skyline::Configuration.solr_indexing
      solr = RSolr.connect
  		solr.delete_by_query('*:*')
  		solr.commit
      solr.optimize
    
      pages = Skyline::Page.all
      pages.each do |p|
        p.add_index
      end
    
      media_file_observer = Skyline::MediaFileObserver.instance
    
      media_files = Skyline::MediaFile.all
      media_files.each do |f|
        media_file_observer.index(f)
      end

      NewsItem.all.map &:add_index    
    end
  end
end