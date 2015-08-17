class TagsController < ApplicationController
  before_action :find_tag, only: [:show, :destroy, :edit, :update]

  def index
    unless current_user.onboarded?
      redirect_to onboarding_url
      return
    end
    @cart = session[:cart]
    @tags = policy_scope(Tag).search(params[:search]).order(updated_at: :desc).page params[:page]
    authorize @tags
    respond_to do |format|
      format.html
      format.json { render json: Tag.all.pluck(:manufacturer).uniq.map(&:downcase).map(&:capitalize) }
    end
  end

  def new
    @tag = Tag.new
    authorize @tag
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.assign_attributes( color: find_color(params[:tag][:color]))
    if @tag.save
      ImageWorker.perform_async(@tag.id)
      if @tag.color.complete == false
        redirect_to confirm_colors_path
      else
        redirect_to tags_path
      end
    else
      render :new
    end
  end

  def new_tag_color
    @tag = Tag.new(tag_params)
  end

  def update
    @tag.assign_attributes( color: find_color(params[:tag][:color]))
    if @tag.update(tag_params)
      ImageWorker.perform_async(@tag.id)
      if @tag.color.complete == false
        redirect_to edit_color_path(@tag.color)
      else
        redirect_to tags_path
      end
    else
      render :edit
    end
  end

  def destroy
    session[:cart].delete(@tag.id.to_s)
    if @tag.destroy
      redirect_to tags_path
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TagPdf.new(@tag, view_context)
        send_data pdf.render, filename: "Tag##{@tag.model}", type: "application/pdf"
      end
    end
  end

  def new_excel_import
  end

  def import_excel
    uploaded_file = params[:import][:excel_doc]
    file_name = uploaded_file.tempfile.to_path.to_s
    data = ExcelParser.new(file_name).parse.data
    @tags = data
  end

  def submit_excel
    @tags = []
    @new_colors = []
    params[:tags].each do |k,v|
      tag = Tag.create(manufacturer: v[:manufacturer], name: v[:name], model: v[:model], color:find_color(v[:color]), size: v[:size], complete: false)
      ImageWorker.perform_async(tag.id)
      @tags << tag
    end

    if @tags.any? { |t| t.color.try(:complete) == false }
      redirect_to confirm_colors_url
    else
      redirect_to tags_url
    end
  end

  def confirm_colors
    @new_colors = Color.where(complete: false)
  end

  def save_excel
    params[:colors].each do |k,v|
      c = Color.find(v[:id])
      c.update(name: v[:name], hex: v[:hex], complete: true)
    end
    redirect_to tags_url
  end

  private

  def find_color(color)
    return nil if color == ""
    found = Color.where(name: color).first
    if found
      found
    else
      Color.create(name: "#{color}", hex: "#{get_hex(color)}", complete: false)
    end
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def get_hex(name)
    return Colorable::Color.new(name).hex
  rescue
    "#ffffff"
  end

  def excel_params
    params.require(:tags).permit(:name, :model, :manufacturer, :size, :color)
  end

  def tag_params
    params.require(:tag).permit(:name, :model, :manufacturer, :size)
  end

end
