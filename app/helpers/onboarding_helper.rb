require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

module OnboardingHelper
  def barby_svg(model)
    raw(Barby::Code128B.new(model).to_svg(height: 50))
  end
end
