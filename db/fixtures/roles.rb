if !Object.const_defined?(:Rails)
  require File.dirname(__FILE__) + "/../../config/environment"
end

def log(str)
  puts str if !Object.const_defined?(:SILENT_SEED) || SILENT_SEED == false
end

# ======================================
# = Definition of implementation roles =
# ======================================

log "\n== Creating roles"

Skyline::Role.seed_many(:name,[
  {:name => "admin"},
  {:name => "editor"}
])

mappings = {
  :admin => %w{media_dir_create 
              media_dir_update 
              media_dir_delete 
              media_file_create 
              media_file_update 
              media_file_delete
              page_index
              page_create
              page_show
              page_update
              page_lock
              page_delete
              article_index
              article_create
              article_show
              article_update
              article_delete
              variant_create
              variant_delete
              settings_update
              user_create
              user_update
              user_show
              user_delete
              tinymce_edit_html
              variant_force_edit},
              
  :editor => %w{media_dir_create 
              media_dir_update
              media_dir_delete
              media_file_create
              media_file_update
              media_file_delete
              page_index
              page_create
              page_show
              page_update
              page_delete
              article_index
              article_create
              article_show
              article_update
              article_delete              
              variant_create
              variant_delete
              tinymce_edit_html
              variant_force_edit}
              
}

log "\n== Mapping Rights to Roles"

mappings.each do |role_name,rights|
  role = Skyline::Role.find_by_name(role_name.to_s)
  rights = Skyline::Right.find_all_by_name(rights)
  log " - Role : #{role_name}"
  rights.each do |r|
    log "    - #{r.name}"
  end
  role.rights = rights
  role.save!
end
