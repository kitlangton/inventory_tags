class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :model
      t.string :name

      t.timestamps null: false
    end
  end
end
