class CartController < ApplicationController
  layout 'none', only: [:cart_tags]

  def show
    session[:cart] ||= []
    @cart = session[:cart]
    @cart_tags = Tag.find(session[:cart])
  end

  def cart_tags
    session[:cart] ||= []
    @cart = session[:cart]
    @cart_tags = Tag.find(session[:cart])
  end

  def add_to_cart
    session[:cart] ||= []
    session[:cart] << params[:id]
    respond_to do |format|
      format.json { render json: "success" }
    end
  end

  def download_cart
    @tags = Tag.find(@cart)
    @tags.select { |t| t.image.size.nil? }.each do |tag|
      tag.get_image
      tag.save
    end
    imposed = ImposePdf.new(@tags, view_context)
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

end
