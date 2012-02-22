class CreateCreatures < ActiveRecord::Migration
  def self.up
    create_table :creatures do |t|
      t.column :name, :string
      t.column :number_of_teeth, :integer
      t.column :species_id, :integer
      t.column :position, :integer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :creatures
  end
end
