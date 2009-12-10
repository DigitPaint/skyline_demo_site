class CreateCalendarItems < ActiveRecord::Migration
  def self.up
    create_table :calendar_items do |t|
      t.string :title
      t.datetime :calendar_date
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :calendar_items
  end
end
