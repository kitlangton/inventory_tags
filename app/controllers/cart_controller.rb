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
    pdf = TagPdf.new(@tags.first, view_context)
    send_data pdf.render,  filename: "Test", type: "application/pdf"
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
