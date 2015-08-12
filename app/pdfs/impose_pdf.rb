class ImposePdf < Prawn::Document
  def initialize(tags, view)
    super()
    @view = view
    tags.each do |tag|
      image tag.prawn_image,
        scale: 0.75,
        position: :center
      move_down 20
    end
  end
end
