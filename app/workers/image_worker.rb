class ImageWorker
  include Sidekiq::Worker
  sidekiq_options unique: true

  def perform(tag_id, force: false)
    tag = Tag.find(tag_id)
    if force == true || tag.image.size == nil
      tag.get_image
      tag.save
    end
  end
end
