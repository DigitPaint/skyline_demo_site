class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.column :page, :string
      t.column :data, :text
    end
  end

  def self.down
    drop_table :settings
  end
end
