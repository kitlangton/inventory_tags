class TagsController < ApplicationController
  def index
    @tags = Tag.search(params[:search])
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
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
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to tags_path
    end
  end

  def show
    @tag = Tag.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TagPdf.new(@tag, view_context)
        send_data pdf.render, filename: "Tag##{@tag.model}", type: "application/pdf"
      end
    end
  end


  private

  def tag_params
    params.require(:tag).permit(:name, :model, :manufacturer_id, :size, :color)
  end

end
