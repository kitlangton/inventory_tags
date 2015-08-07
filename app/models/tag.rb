require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

class Tag < ActiveRecord::Base
  belongs_to :manufacturer
  validates :name, presence: true
  validates :color, color: true
  validates :model, length: { in: 5..10}
  validates :size, presence: true, numericality: { only_integer: true }

  def display_manufacturer
    if manufacturer
      manufacturer.name.upcase
    else
      "N/A"
    end
  end

  def display_color
    color || "N/A"
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
