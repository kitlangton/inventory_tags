require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

class Tag < ActiveRecord::Base
  belongs_to :manufacturer

  def display_manufacturer
    if manufacturer
      manufacturer.name.upcase
    else
      "NO MANUFACTURER"
    end
  end

  def display_barcode
    barcode = Barby::Code128B.new(self.model)
    barcode.to_svg(height: 50)
  end


  def self.search(search)
    if search
      wildcard_search = "%#{search}%"

      where("name ILIKE :search", search: wildcard_search)
    else
      all
    end
  end

end