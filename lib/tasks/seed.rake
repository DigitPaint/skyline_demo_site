namespace :db do
  desc "Run all seed files in db/fixtures/** (runs the skyline seeds first)"
  task :seed => "skyline:db:seed" do
    Dir[Rails.root + "db/fixtures/*.rb"].each do |f|
      load f
    end
  end
end