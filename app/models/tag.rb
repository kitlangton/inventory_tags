require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :color, color: true
  validates :model, presence: true
  validates :size, presence: true, numericality: { only_integer: true }

  def display_manufacturer
    if manufacturer
      manufacturer.upcase
    else
      "N/A"
    end
  end

  def display_color
    color
  end

  def display_size
    if size && size > 0
      "#{size}GB"
    else
      ""
    end
  end

  def display_barcode
    barcode = Barby::Code128B.new(self.model)
    barcode.to_svg(height: 50)
  end


  def self.search(search)
    if search
      where("name ILIKE ?", "%#{search}%")
    else
      all
    end
  end

end
