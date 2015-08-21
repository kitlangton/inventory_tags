class TagsController < ApplicationController
  before_action :find_tag, only: [:show, :destroy, :edit, :update]

  def index
    unless current_user.onboarded?
      redirect_to onboarding_url
      return
    end
    @cart = session[:cart]
    @tags = Tag.search(params[:search]).includes(:color).order(updated_at: :desc).page params[:page]
    authorize @tags
    respond_to do |format|
      format.html
      format.json { render json: @tags }
      format.js
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
      if @tag.color && @tag.color.complete == false
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

  def confirm_colors
    @new_colors = Color.where(complete: false)
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :model, :manufacturer, :size)
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
