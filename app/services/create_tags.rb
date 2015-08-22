class CreateTags
  def call(params)
    tags = []
    params[:tags].each do |_, v|
      v[:color_id] = find_color(v[:color])
      tag = Tag.create(v.permit(:name, :manufacturer, :size, :color_id, :model))
      ImageWorker.perform_async(tag.id)
      tags << tag
    end
  rescue
    [false, tags]
  else
    [true, tags]
  end

  def get_hex(name)
    return Colorable::Color.new(name).hex
  rescue
    '#ffffff'
  end

  def find_color(color)
    return if color == ''
    found = Color.where(name: color).first
    if found
      found.id
    else
      Color.create(name: "#{color}", hex: "#{get_hex(color)}", complete: false).id
    end
  end
end
