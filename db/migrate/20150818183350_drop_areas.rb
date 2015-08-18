class DropAreas < ActiveRecord::Migration
  def up
    remove_column :tags, :area_id
    remove_column :users, :area_id
    drop_table :areas
  end

  def down
    create_table :areas do |t|
      t.string :name

      t.timestamps null: false
    end
    add_reference :tags, :area, index: true, foreign_key: true
    add_reference :users, :area, index: true, foreign_key: true
  end
end
