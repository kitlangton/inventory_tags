class AddManufacturerNameToTags < ActiveRecord::Migration
  def change
    add_column :tags, :manufacturer, :string
    remove_column :tags, :manufacturer_id
  end
end
