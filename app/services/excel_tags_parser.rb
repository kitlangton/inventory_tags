require 'rubyXL'
class ExcelTagsParser
  attr_accessor :tags

  def initialize(document)
    @document = document
    @tags = []
  end

  def parse
    parser = ExcelParser::Parser.new(@document)
    parser.config do |p|
      p.heading 'Name', type: :string, required: true
      p.heading 'Manufacturer', type: :string, required: true
      p.heading 'Model #', type: :string, required: false, model_attribute: 'model'
      p.heading 'Color', type: :string, required: false
      p.heading 'Size', type: :integer, required: false
    end
    @tags = parser.parse.tags
    self
  end

  def create_tags
    output_tags = []
    @tags.each do |tag|
      tag[:color] = Color.find_or_initialize_by(name: tag[:color])
      output_tags << Tag.new(tag)
    end
    output_tags
  end
end

module ExcelParser
  class Heading
    attr_reader :name, :type
    attr_accessor :cell
    def initialize(name, type: :string, required: false, model_attribute: nil)
      @requried = required
      @name = name.downcase
      @type = type
      @cell = nil
      @model_attribute = model_attribute
    end

    def required?
      @requried
    end

    def column
      @cell.column
    end

    def row
      @cell.row
    end

    def attribute
      @model_attribute || @name
    end

    def process(value)
      return unless value
      case type
      when :string
        return '' if value =~ /N\/A/
        value.strip.chomp
      when :integer
        value.scan(/\d/).join.to_i
      else
        value
      end
    end
  end

  class Parser
    attr_accessor :tags, :headings

    def initialize(document)
      @document = document
      @headings = []
      @current_row = 0
      @tags = []
    end

    def config
      yield(self)
      set_headers
    end

    def heading(name, type: :string, required: false, model_attribute: nil)
      @headings << Heading.new(name, type: type, required: required, model_attribute: model_attribute)
    end

    def parse
      @tags = []
      each_valid_excel_row do |row|
        tags << hash_for_headings(row)
      end
      self
    end

    def hash_for_headings(row)
      hash = {}
      @headings.each do |heading|
        hash[heading.attribute.to_sym] = get_value(row, heading)
      end
      hash
    end

    private

    def each_valid_excel_row
      excel_rows[row_after_headers..-1].each do |row|
        yield(row) if valid_row?(row)
      end
    end

    def get_value(row, heading)
      value = row[heading.column].value
      heading.process(value)
    end

    def set_headers
      headings.each do |heading|
        each_cell do |cell|
          heading.cell = cell if cell.value.downcase =~ /#{heading.name}/
        end
      end
    end

    def row_after_headers
      headings[0].row + 1
    end

    def valid_row?(row)
      headings.each do |heading|
        return false if row[heading.column].nil?
        return false if heading.required? && row[heading.column].value.nil?
      end
      true
    end

    def each_cell
      excel_rows.each do |row|
        row.cells.each do |cell|
          yield(cell) if cell && cell.value
        end
      end
    end

    def excel_rows
      book = RubyXL::Parser.parse @document
      sheet = book.worksheets[0]
      sheet.sheet_data.rows
    end
  end
end
