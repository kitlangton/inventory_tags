class ImageWorker
  include Sidekiq::Worker
  sidekiq_options unique: true

  def perform(tag_id, force: false)
    tag = Tag.find(tag_id)
    return unless force == true || tag.image.size.nil?
    tag.set_image
    tag.save
  end
end
