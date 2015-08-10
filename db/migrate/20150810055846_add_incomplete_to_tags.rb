class AddIncompleteToTags < ActiveRecord::Migration
  def change
    add_column :tags, :complete, :boolean, default: true
    add_column :colors, :complete, :boolean, default: true
  end
end
