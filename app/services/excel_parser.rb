require 'rubyXL'

class ExcelParser
  attr_reader :data

  def initialize(document)
    @document = document
    @data = []
  end

  def parse
    book = RubyXL::Parser.parse @document
    sheet = book.worksheets[0]
    sheet.sheet_data.rows.each do |row|
      unless row[0] && row[1] && row[2] && row[3] && row[4]
        next
      end
      if row[2].value.nil?
        next
      end
      @data << Tag.new(manufacturer: parse_value(row[0].value),
                           model: parse_model(row[1].value),
                           name: parse_value(row[2].value),
                           color: parse_color(row[3].value),
                           size: parse_size(row[4].value))
    end
    @data.reject! { |item| item.name == "" }
    @data.shift
    self
  end

  private

  def parse_model(model)
    model = parse_value(model)
    model.chomp.strip
  end

  def parse_value(value)
    if value && value != "N/A"
      value.strip
    end
  end

  def parse_color(color)
    color = parse_value(color)
    found = Color.where(name: color).first
    return found if found
    Color.new(name: "#{color}", hex: get_hex(color), complete: false)
  end

  def get_hex(name)
    return Colorable::Color.new(name).hex
  rescue
    "#fff"
  end

  def parse_size(size)
    if size
      size.scan(/\d/).join.to_i
    end
  end
end
