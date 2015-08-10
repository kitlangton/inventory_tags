class ColorsController < ApplicationController
  def index
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

  end

  private

  def color_params
    params.require(:color).permit(:name,:hex)
  end
end
