require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
require 'barby/outputter/svg_outputter'

class Tag < ActiveRecord::Base
  paginates_per 15
  after_save :expire_tag_all_cache
  before_save :prettify_data
  after_destroy :expire_tag_all_cache
  belongs_to :color
  validates :name, presence: true
  validates :model, presence: true
  validates :manufacturer, presence: true
  has_attached_file :image
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def set_image
    pdf = TagPdf.new(self, nil)
    t = Tempfile.new(["pdf#{id}", '.pdf'])
    t.close
    pdf.render_file(t.path)
    image = Magick::ImageList.new(t.path)
    img = Tempfile.new(["image#{id}", '.png'])
    img.close
    image.write(img.path) { self.quality = 100 }
    `convert #{img.path} -background white -flatten -quality 100 #{img.path}`
    png_file = File.open(img.path)
    self.image = png_file
  end

  def display_manufacturer
    if manufacturer
      manufacturer.upcase
    else
      'N/A'
    end
  end

  def display_color
    color.try(:name) || ''
  end

  def dark_color?
    color.try(:dark?)
  end

  def hex
    if color
      color.hex
    else
      '#ffffff'
    end
  rescue
    '#ffffff'
  end

  def display_size(gb: true)
    if size && size > 0
      if gb
        "#{size}GB"
      else
        "#{size}"
      end
    else
      ''
    end
  end

  def display_barcode(height:50)
    barcode = Barby::Code128B.new(model)
    barcode.to_svg(height: height)
  end

  def display_barcode_png(height:80)
    barcode = Barby::Code128B.new(model)
    barcode.to_png(height: height, xdim: 2)
  end

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end

  def prettify_data
    self.manufacturer = manufacturer.downcase.capitalize
  end

  def prawn_image
    if Rails.env.production?
      open(image.url)
    else
      image.path
    end
  end

  def self.all_cached
    Rails.cache.fetch('Tag.all') { all }
  end

  def expire_tag_all_cache
    Rails.cache.delete('Tag.all')
  end
end
