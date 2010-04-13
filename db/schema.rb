# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100330132355) do

  create_table "calendar_items", :force => true do |t|
    t.string   "title"
    t.datetime "calendar_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_item_data", :force => true do |t|
    t.text     "teaser"
    t.string   "title"
    t.string   "url_part"
    t.text     "body"
    t.integer  "image_id"
    t.integer  "integer"
    t.date     "publication_date"
    t.boolean  "published",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_products", :force => true do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.string  "title"
    t.decimal "price"
    t.integer "amount"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "town"
    t.string   "country"
    t.string   "email"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_data", :force => true do |t|
    t.text     "title"
    t.text     "url_part"
    t.text     "teaser"
    t.integer  "image_id"
    t.integer  "integer"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string "page"
    t.text   "data"
  end

  create_table "skyline_article_versions", :force => true do |t|
    t.string   "type",                                    :null => false
    t.integer  "article_id",                              :null => false
    t.integer  "variant_id"
    t.integer  "version",                  :default => 1, :null => false
    t.string   "name",                                    :null => false
    t.integer  "creator_id"
    t.integer  "last_updated_by_id"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_editor_id"
    t.datetime "current_editor_timestamp"
    t.datetime "current_editor_since"
    t.integer  "data_id"
    t.string   "data_type"
  end

  add_index "skyline_article_versions", ["type", "article_id", "version"], :name => "index_skyline_page_versions_on_type_and_page_id_and_version"

  create_table "skyline_articles", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "published_publication_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",                        :default => false, :null => false
    t.string   "url_part",                      :default => ""
    t.boolean  "persistent",                    :default => false, :null => false
    t.string   "identifier"
    t.string   "type"
    t.integer  "published_publication_data_id"
    t.integer  "default_variant_id"
    t.integer  "default_variant_data_id"
  end

  add_index "skyline_articles", ["parent_id", "position"], :name => "index_skyline_pages_on_page_id_and_position"
  add_index "skyline_articles", ["parent_id"], :name => "index_skyline_pages_on_page_id_and_in_navigation"

  create_table "skyline_associated_tags", :force => true do |t|
    t.integer "taggable_id"
    t.integer "tag_id"
    t.string  "taggable_type", :default => "", :null => false
  end

  create_table "skyline_grants", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "skyline_link_section_links", :force => true do |t|
    t.integer  "link_section_id", :null => false
    t.integer  "linked_id"
    t.string   "title"
    t.integer  "position",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skyline_link_section_links", ["link_section_id", "position"], :name => "index_skyline_link_section_links_on_link_section_id_and_position"

  create_table "skyline_media_cache", :force => true do |t|
    t.string  "url"
    t.string  "object_type"
    t.integer "object_id"
  end

  create_table "skyline_media_nodes", :force => true do |t|
    t.integer "parent_id"
    t.string  "type"
    t.string  "name"
    t.string  "content_type"
    t.integer "size"
    t.string  "path"
    t.text    "description"
    t.string  "file_type"
    t.integer "width"
    t.integer "height"
    t.string  "title"
    t.date    "date"
  end

  create_table "skyline_page_data", :force => true do |t|
    t.string  "url_part"
    t.boolean "in_navigation"
    t.string  "navigation_title"
    t.string  "title"
    t.string  "custom_title_tag"
    t.text    "meta_description_tag"
  end

  create_table "skyline_page_fragment_data", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_ref_objects", :force => true do |t|
    t.integer  "referable_id"
    t.string   "referable_type"
    t.integer  "refering_id"
    t.string   "refering_type"
    t.string   "type"
    t.text     "options"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "refering_column_name"
  end

  create_table "skyline_referable_uris", :force => true do |t|
    t.string   "uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_rights", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_rights_skyline_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "skyline_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "system",     :default => false, :null => false
  end

  create_table "skyline_sections", :force => true do |t|
    t.integer  "article_version_id"
    t.integer  "sectionable_id"
    t.string   "sectionable_type"
    t.integer  "position",           :default => 1, :null => false
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skyline_sections", ["article_version_id", "position"], :name => "index_skyline_sections_on_page_version_id_and_position"

  create_table "skyline_sections_content_collection_sections", :force => true do |t|
    t.string   "content_type", :null => false
    t.integer  "number",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_content_item_sections", :force => true do |t|
    t.string   "content_item_type", :null => false
    t.integer  "content_item_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_heading_sections", :force => true do |t|
    t.string   "heading",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_iframe_sections", :force => true do |t|
    t.string   "url"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_link_sections", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_media_sections", :force => true do |t|
    t.integer "linked_id"
    t.string  "alignment"
    t.integer "width"
    t.integer "height"
    t.text    "caption"
  end

  create_table "skyline_sections_page_fragment_sections", :force => true do |t|
    t.integer  "page_fragment_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_raw_sections", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_redirect_sections", :force => true do |t|
    t.integer "linked_id"
    t.integer "delay",     :default => 0, :null => false
  end

  create_table "skyline_sections_rss_sections", :force => true do |t|
    t.string   "url"
    t.integer  "show_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_splitter_sections", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_sections_wysiwyg_sections", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_tags", :force => true do |t|
    t.string "tag"
    t.string "taggable_type", :default => "", :null => false
  end

  add_index "skyline_tags", ["taggable_type", "tag"], :name => "index_skyline_tags_on_taggable_type_and_tag"

  create_table "skyline_test_sections", :force => true do |t|
    t.text     "body_a"
    t.text     "body_b"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skyline_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "system",       :default => false
    t.boolean  "is_destroyed", :default => false
  end

  create_table "skyline_versions", :force => true do |t|
    t.integer "versionable_id"
    t.string  "versionable_type"
    t.integer "version"
    t.string  "author"
  end

  create_table "test_content_objects", :force => true do |t|
    t.integer  "image_id"
    t.string   "header"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
