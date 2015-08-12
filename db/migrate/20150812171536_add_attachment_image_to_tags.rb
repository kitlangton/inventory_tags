class AddAttachmentImageToTags < ActiveRecord::Migration
  def self.up
    change_table :tags do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :tags, :image
  end
end
