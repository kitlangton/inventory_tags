class AddSizeAndColorToTags < ActiveRecord::Migration
  def change
    add_column :tags, :size, :int
    add_column :tags, :color, :string
  end
end
