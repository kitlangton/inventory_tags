class ImageWorker
  include Sidekiq::Worker
  sidekiq_options unique: true

  def perform(tag_id)
    tag = Tag.find(tag_id)
    tag.set_image
    tag.save
  end
end
