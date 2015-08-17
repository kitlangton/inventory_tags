class CartController < ApplicationController
  layout 'none', only: [:cart_tags]
  before_action :find_cart_tags, only: [:show, :cart_tags, :download_cart, :process_cart]
  def show
  end

  def cart_tags
  end

  def add_to_cart
    session[:cart] ||= []
    session[:cart] << params[:id]
    respond_to do |format|
      format.json { render json: "success" }
    end
  end

  def process_cart
    @cart_tags.select { |t| !t.image.exists? }.each do |tag|
      tag.get_image
      tag.save
    end
    send_data 'hi'
  end

  def download_cart
    imposed = ImposePdf.new(@cart_tags, view_context)
    send_data imposed.render, filename: "Test.pdf", type: "application/pdf"
  end

  def delete_from_cart
    session[:cart] ||= []
    session[:cart].delete(params[:id])
    respond_to do |format|
      format.json { render json: "success" }
    end
  end

  def clear_cart
    session[:cart] = []
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.json { render json: "success" }
    end
  end

  private

  def find_cart_tags
    @cart_tags = Tag.find(@cart)
  rescue
    @valid_tags = []
    @cart.each do |tag|
      if Tag.find_by_id(tag.to_i)
        @valid_tags << tag
      end
    end
    @valid_tags.compact
    session[:cart] = @valid_tags
    @cart = @valid_tags
    @cart_tags = Tag.where(id: @valid_tags)
  end

end
