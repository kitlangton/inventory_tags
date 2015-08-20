# ExcelTagsParser parses a hash of tags from a properly formatted xlsx document

require 'rubyXL'
class ExcelTagsParser
  attr_accessor :tags

  def initialize(document)
    @document = document
    @tags = []
  end

  def parse
    excel_rows[row_after_headers..-1].each do |row|
      next unless row[manufacturer_column] && row[model_column] && row[name_column] && row[color_column] && row[size_column]
      next if no_name?(row) || no_manufacturer?(row)
      tags << {manufacturer: get_value(row, 'manufacturer'),
               model: get_value(row, 'model'),
               name: get_value(row, 'name'),
               color: get_value(row, 'color'),
               size: get_value(row, 'size', integer: true)}
    end
    self
  end

  private

  def get_value(row, title, integer: false)
    value = parse_value(row[send("#{title}_column")].value)
    return parse_size(value) if integer
    value
  end

  def cell_for(title)
    each_cell do |cell|
      return cell if cell.value.downcase =~ /#{title.to_s}/
    end
  end

  def row_after_headers
    cell_for(:name).row + 1
  end

  def no_name?(row)
    row[name_column].value.nil?
  end

  def no_manufacturer?(row)
    row[manufacturer_column].value.nil?
  end

  def column_for(title)
    cell_for(title).column
  end

  def each_cell
    excel_rows.each do |row|
      row.cells.each do |cell|
        yield(cell) if cell.value
      end
    end
  end

  def row_full?(row)
    row[0] && row[1] && row[2] && row[3] && row[4]
  end

  def excel_rows
    book = RubyXL::Parser.parse @document
    sheet = book.worksheets[0]
    sheet.sheet_data.rows
  end

  def parse_value(value)
    value.strip if value && value != 'N/A'
  end

  def parse_size(size)
    size.scan(/\d/).join.to_i if size
  end

  def method_missing(m)
    return false unless m =~ /(\w+)_column/

    col = instance_variable_get("@#{m}")
    unless col
      col = column_for($1.to_sym)
      instance_variable_set("@#{m}", col)
    end
    col
  end
end
