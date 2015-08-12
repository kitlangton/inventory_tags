require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
require 'barby/outputter/svg_outputter'

class Tag < ActiveRecord::Base
  paginates_per 15
  before_validation :prettify_data
  belongs_to :color
  validates :name, presence: true
  validates :model, presence: true
  validates :manufacturer, presence: true
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def get_image
    p self
    pdf = TagPdf.new(self, nil)
    t = Tempfile.new(["pdf", ".pdf"])
    t.close
    pdf.render_file(t.path)
    image = Magick::ImageList.new(t.path)
    img = Tempfile.new(["image",".png"])
    img.close
    image.write img.path
    p img
    p image
    `convert #{img.path} -background white -flatten #{img.path}`
    png_file = File.open(img.path)
    self.image = png_file
    save
    self.image
  end

  def display_manufacturer
    if manufacturer
      manufacturer.upcase
    else
      "N/A"
    end
  end

  def display_color
    self.color.try(:name) || ""
  end

  def dark_color?
    self.color.try(:dark?)
  end

  def hex
    self.color.hex || "#ffffff"
  rescue
    "#ffffff"
  end

  def display_size(gb: true)
    if size && size > 0
      if gb
        "#{size}GB"
      else
        "#{size}"
      end
    else
      ""
    end
  end

  def display_barcode(height:50)
    barcode = Barby::Code128B.new(self.model)
    barcode.to_svg(height: height)
  end

  def display_barcode_png(height:80)
    barcode = Barby::Code128B.new(self.model)
    barcode.to_png(height: height, xdim: 2)
  end


  def self.search(search)
    if search
      where("name ILIKE ?", "%#{search}%")
    else
      all
    end
  end

  def prettify_data
    self.manufacturer = manufacturer.downcase.capitalize
  end

  def prawn_image
    if Rails.env.production?
      open(self.image.url)
    else
      self.image.path
    end
  end

end
