class AddColorsToTags < ActiveRecord::Migration
  def change
    remove_column :tags, :color
    add_reference :tags, :color, index: true, foreign_key: true
  end
end
