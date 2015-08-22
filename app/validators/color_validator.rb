require 'colorable'

class ColorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if valid_color?(value)
    record.errors[attribute] << (options[:message] || "#{value} is not a valid color name.")
  end

  def valid_color?(color)
    Colorable::Color.new(color).hex
    return true
  rescue
    return false
  end
end
