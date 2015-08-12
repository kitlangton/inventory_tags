class ImageWorker
  include Sidekiq::Worker
    def perform(tag_id)
      tag = Tag.find(tag_id)
      if tag.image.size == nil
        tag.get_image
        tag.save
      end
    end
end
