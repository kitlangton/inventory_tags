class ColorsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: Color.all.pluck(:name) }
    end
  end

  def new
    @color = Color.new
  end

  def create
    @color = Color.new(color_params)
    if @color.save
      redirect_to tags_url
    else
      render :new
    end
  end

  def edit
    @color = Color.find(params[:id])
  end

  def update
    @color = Color.find(params[:id])
    if @color.update(color_params)
      @color.tags.each do |t|
        t.image.destroy
        ImageWorker.perform_async(t.id)
      end
      redirect_to tags_url
    else
      render :edit
    end
  end

  private

  def color_params
    params.require(:color).permit(:name,:hex)
  end
end
