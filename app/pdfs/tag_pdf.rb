require 'colorable'

class TagPdf < Prawn::Document
  def initialize(tag, view)
    super(page_size: [740,350], margin: [15,0,0,15])
    scale 2
    @tag = tag
    @view = view
    @color_hex = @tag.hex.chars
    @color_hex.shift
    @color_hex = @color_hex.join
    text_box @tag.display_manufacturer,
      at: [-10,160],
      height: 50,
      width: 175,
      size: 24,
      style: :bold,
      column: 0,
      align: :center
    move_down 10
    # stroke do
    #   stroke_color '000000'
    #   fill_color 'ffffff'
    #   fill_and_stroke_rectangle [0,-20], 175, 50
    #   stroke_color '000000'
    #   fill_color '000000'
    # end
    image = Tempfile.new('barcode.png')
    image.write @tag.display_barcode_png
    image.close
    image image.path,
      at: [-10,100],
      position: :center,
      width: 175,
      height: 70
    move_cursor_to(0)
    text_box @tag.name,
      at: [-10,135],
      height: 32,
      width: 175,
      size: 16,
      overflow: :shrink_to_fit,
      valign: :center,
      align: :center
    move_cursor_to(0)
    text_box @tag.model,
      at: [-10, 30],
      width: 175,
      size: 16,
      align: :center
    # old_cursor = cursor
    bounding_box([180,160], width: 160, height: 30) do
      stroke do
        stroke_color @color_hex
        fill_color @color_hex
        fill_and_stroke_rectangle [cursor-bounds.height,cursor], bounds.width, bounds.height
      end
      stroke_color '000000'
      fill_color '000000'
      if @tag.dark_color?
        fill_color 'ffffff'
      end
    end
    move_cursor_to(0)
    text_box @tag.display_color,
      at: [180,151],
      width: 160,
      height: 50,
      size: 16,
      align: :center
    fill_color '000000'
    if @tag.size
      text_box "#{@tag.display_size}",
        at: [180, 110],
        width: 160,
        height: 80,
        align: :center,
        size: 27
    end
  end
end
