class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      t.text :teaser      
      t.string :title
      t.string :url_part
      t.column :body, :mediumtext
      t.integer :image_id, :integer
      t.date :publication_date      
      t.boolean :published, :null => false, :default => false
      t.integer :position, :null => false      
      t.timestamps
    end
  end

  def self.down
    drop_table :news_items
  end
end
