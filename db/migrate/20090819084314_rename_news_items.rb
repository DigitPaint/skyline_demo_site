class RenameNewsItems < ActiveRecord::Migration
  def self.up
  	rename_table :news_items, :news_item_data
  	remove_column :news_item_data, :position
  	execute "UPDATE skyline_sections_content_collection_sections SET content_type='NewsItem::Data' WHERE content_type='NewsItem'"
  end

  def self.down
    execute "UPDATE skyline_sections_content_collection_sections SET content_type='NewsItem' WHERE content_type='NewsItem::Data'"
    add_column :news_item_data, :position, :integer
  	rename_table :news_item_data, :news_items  	
  	
  end
end
