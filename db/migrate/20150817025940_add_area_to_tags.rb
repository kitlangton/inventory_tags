class AddAreaToTags < ActiveRecord::Migration
  def change
    add_reference :tags, :area, index: true, foreign_key: true
  end
end
