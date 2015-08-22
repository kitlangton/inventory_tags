class ImposePdf < Prawn::Document
  def initialize(tags, view)
    super()
    @view = view
    tags.each_with_index do |tag, i|
      pre_image_cursor = cursor

      image tag.prawn_image,
        width: 278,
        height: 131,
        position: :center

      stroke do
        if (i+5) % 5 == 0
          line [132, pre_image_cursor+10], [132, pre_image_cursor]
          line [410, pre_image_cursor+10], [410, pre_image_cursor]
        end
        line [122, pre_image_cursor], [132, pre_image_cursor]
        line [410, pre_image_cursor], [420, pre_image_cursor]
      end
      move_down 10
      stroke do
        line [122, cursor+10], [132, cursor+10]
        line [410, cursor+10], [420, cursor+10]
        if ((i+1) % 5 == 0) || (i+1) == tags.size
          line [132, cursor], [132, cursor+10]
          line [410, cursor], [410, cursor+10]
        end
      end
      if (i+1) % 5 == 0 && (i+1) != tags.size
        start_new_page
      end
    end
  end
end
