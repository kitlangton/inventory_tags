class ImposePdf < Prawn::Document
  def initialize(tags, view)
    super()
    @view = view
    tags.each do |tag|
      image tag.image.path
      move_down 20
    end
  end
end
