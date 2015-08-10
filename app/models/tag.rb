require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

class Tag < ActiveRecord::Base
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
    self.color.try(:name)
  end

  def dark_color?
    self.color.try(:dark?)
  end

  def hex
    self.color.hex
  rescue
    ""
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
