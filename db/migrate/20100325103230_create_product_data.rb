class CreateProductData < ActiveRecord::Migration
  def self.up
     create_table :product_data do |t|
       t.text :title
       t.text :url_part
       t.text :teaser      
       t.references :image
       t.decimal :price
       t.timestamps
     end
   end

   def self.down
     drop_table :product_data
   end
end
