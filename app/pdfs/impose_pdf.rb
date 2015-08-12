class ImposePdf < Prawn::Document
  def initialize(image, view)
    super()
    @view = view
    @image = image
    @image.each_with_index do |img, i|
      image = Tempfile.new("image_#{i}.png")
      image.close
      img.write image.path
      `convert #{image.path} -background white -flatten -define png:color-type=2 -define png:bit-depth=8 #{image.path}`
      image image.path
      move_down 20
    end
  end
end
