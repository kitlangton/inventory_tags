class ImposePdf < Prawn::Document
  def initialize(tags, view)
    super()
    @view = view

    tags.each_with_index do |tag, i|
      if (i+5) % 5 == 0
        stroke do
          line [132, cursor+10], [132, cursor]
          line [122, 721], [132, 721]

          line [410, cursor+10], [410, cursor]
          line [410, 721], [420, 721]
        end
      end

      image tag.prawn_image,
        scale: 0.75,
        position: :center
      move_down 10
      stroke do
        line [122, cursor+10], [132, cursor+10]
        line [410, cursor+10], [420, cursor+10]
        if ((i+1) % 5 == 0) || (i+1) == tags.size
          line [132, cursor], [132, cursor+10]
          line [410, cursor], [410, cursor+10]
        else
          line [122, cursor], [132, cursor]
          line [410, cursor], [420, cursor]
        end
      end
      if (i+1) % 5 == 0
        start_new_page
      end
    end
  end
end
