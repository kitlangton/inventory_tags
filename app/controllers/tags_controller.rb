class TagsController < ApplicationController
  before_action :find_tag, only: [:show, :destroy, :edit, :update]

  def index
    @tags = Tag.search(params[:search])
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
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


    data = ExcelParser.new(file_name).parse
    # m = Manufacturer.first
    # tag = Tag.new(name: "He", model: "EUTHOEUTD", size: 15, color: "Blue", manufacturer: m)
    @tags = data.data
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :model, :manufacturer, :size, :color)
  end

end
