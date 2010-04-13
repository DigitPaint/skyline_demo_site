class CreateOrderProducts < ActiveRecord::Migration
  def self.up
    create_table :order_products do |t|
      t.references :order
      t.references :product
      t.string :title
      t.decimal :price
      t.integer :amount
    end
  end

  def self.down
    drop_table :order_products
  end
end
