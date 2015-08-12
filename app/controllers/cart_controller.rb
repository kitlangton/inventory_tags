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
    images = []
    @tags.each_with_index do |tag, i|
      pdf = TagPdf.new(tag, view_context)
      t = Tempfile.new("pdf_#{i}.pdf")
      t.close
      pdf.render_file(t.path)
      t.path
      image = Magick::ImageList.new(t.path)
      `convert #{t.path} -background white -flatten -define png:color-type=2 -define png:bit-depth=8 #{t.path}`
      images << image
    end
    imposed = ImposePdf.new(images, view_context)
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
