class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name, index: true

      t.timestamps null: false
    end
  end
end
