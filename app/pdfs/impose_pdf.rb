class ImposePdf < Prawn::Document
  def initialize(image, view)
    super()
    @view = view
    @image = image
    @image.each_with_index do |img, i|
      image = Tempfile.new("image_#{i}.jpg")
      image.close
      img.write image.path
      p img
      p image
      `convert #{image.path} -background white -flatten #{image.path}`
      p image
      image image.path
      move_down 20
    end
  end
end
