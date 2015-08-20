class Tags::ExcelImportsController < ApplicationController
  def new
    authorize Tag, :create?
  end

  def confirm
    authorize Tag, :create?
    uploaded_file = params[:import][:excel_doc]
    file_name = uploaded_file.tempfile.to_path.to_s
    @tags = []
    tags = ExcelTagsParser.new(file_name).parse.tags
    tags.each do |tag|
      tag[:color] = Color.find_or_initialize_by(name: tag[:color])
      @tags << Tag.new(tag)
    end
  end

  def create
    authorize Tag, :create?
    @tags = []
    params[:tags].each do |_,v|
      tag = Tag.create(manufacturer: v[:manufacturer], name: v[:name], model: v[:model], color:find_color(v[:color]), size: v[:size], complete: false)
      ImageWorker.perform_async(tag.id)
      @tags << tag
    end

    if @tags.any? { |t| t.color.try(:complete) == false }
      redirect_to confirm_colors_url, flash: { success: "Your tags have been created successfully." }
    else
      redirect_to tags_url, flash: { success: "Your tags have been created successfully." }
    end
  end

  def save_excel
    params[:colors].each do |_,v|
      c = Color.find(v[:id])
      c.tags.each do |t|
        t.image.destroy
        ImageWorker.perform_async(t.id)
      end
      c.update(name: v[:name], hex: v[:hex], complete: true)
    end
    redirect_to tags_url
  end

  def get_hex(name)
    return Colorable::Color.new(name).hex
  rescue
    "#ffffff"
  end

  def find_color(color)
    return nil if color == ""
    found = Color.where(name: color).first
    if found
      found
    else
      Color.create(name: "#{color}", hex: "#{get_hex(color)}", complete: false)
    end
  end
end
