require 'fileutils'
require 'pathname'

namespace :demo do
  verbose(true)
  
  desc "Setup the database and files for the demo"
  task :setup => :environment do
    Rake::Task["demo:reset"].execute
  end
  
  desc "Reset database and files" 
  task :reset => :environment do
    c = ActiveRecord::Base.establish_connection
    config = c.spec.config
    
    mysql = find_binary_in_path("mysql", "mysql5")

    extra = ""    
    if config[:host]
      extra << "-h #{config[:host]}"
    elsif config[:socket]
      extra << "-S #{config[:socket]}"
    end
    
    system "#{mysql} --user=#{config[:username]} --password=#{config[:password]} #{extra}  #{config[:database]} < #{Rails.root + "db/fixtures/skyline_demo.sql"}"
    
    file_path = Skyline::Configuration.assets_path
    
    FileUtils.rm_rf file_path
    FileUtils.cp_r Rails.root + "db/fixtures/upload", file_path
  end
  
  def find_binary_in_path(*names)
    ENV['PATH'].split(/:/).uniq.each do |p|
      names.each do |n| 
        path = (Pathname.new(p) + n).expand_path
        return path.to_s if path.exist?
      end
    end
  end
end