require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
require 'barby/outputter/svg_outputter'

class Tag < ActiveRecord::Base
  paginates_per 30
  before_validation :prettify_data
  belongs_to :color
  validates :name, presence: true
  validates :model, presence: true
  validates :manufacturer, presence: true

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

end
