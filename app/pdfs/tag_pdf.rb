require 'colorable'

class TagPdf < Prawn::Document
  def initialize(tag, view)
    super(page_size: [370,175], margin: [15,0,0,15])
    @tag = tag
    @view = view
    @color_hex = @tag.hex
    define_grid(columns: 2)
    column_box([0,cursor], columns: 2, width: bounds.width) do
      text @tag.display_manufacturer,
        size: 24,
        style: :bold,
        column: 0,
        align: :center
      move_down 10
      text @tag.name,
        size: 16,
        align: :center
      svg @tag.display_barcode,
        position: :center
      text @tag.model,
        size: 16,
        align: :center
      move_down 80
      old_cursor = cursor
      bounding_box([180,226], width: 160, height: 30) do
        stroke do
          stroke_color @color_hex.to_s.chars[-6..-1].join
          fill_color @color_hex.to_s.chars[-6..-1].join
          fill_and_stroke_rectangle [cursor-bounds.height,cursor], bounds.width, bounds.height
        end
      stroke_color '000000'
      fill_color '000000'
      move_down 8
      if @tag.dark_color?
        fill_color 'ffffff'
      end
      text @tag.display_color,
        size: 16,
        align: :center
      end
      fill_color '000000'
      text_box "#{@tag.size}GB",
        at: [180, 180],
        width: 160,
        height: 80,
        align: :center,
        size: 27
    end
  end
end
