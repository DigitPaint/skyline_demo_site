class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :town
      t.string :country
      t.string :email
      t.string :status
      
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
