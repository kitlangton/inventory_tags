require './app/services/excel_tags_parser'

describe ExcelTagsParser do

  it "parses an Excel doc and returns an array of hashes" do
    tags = ExcelTagsParser.new(excel_doc, 'model', 'manufacturer', 'name', 'size', 'color').parse.tags
    expect(tags.count).to eq 19
    expect(tags.first[:name]).to eq "iPhone 4S"
    expect(tags.first[:size]).to eq 16
    expect(tags.first[:manufacturer]).to eq "APPLE"
    expect(tags.first[:color]).to eq "CPO"
    expect(tags.last[:name]).to eq "Galaxy J1"
    expect(tags.last[:size]).to eq 32
    expect(tags.last[:manufacturer]).to eq "SAMSUNG"
    expect(tags.last[:color]).to eq "Blue"
  end

  it "parses a strangely formatted Excel doc" do
    tags = ExcelTagsParser.new(weird_excel_doc).parse.tags
    expect(tags.count).to eq 19
    expect(tags.first[:name]).to eq "iPhone 4S"
    expect(tags.first[:size]).to eq 16
    expect(tags.first[:manufacturer]).to eq "APPLE"
    expect(tags.first[:color]).to eq "CPO"
    expect(tags.last[:name]).to eq "Galaxy J1"
    expect(tags.last[:size]).to eq 32
    expect(tags.last[:manufacturer]).to eq "SAMSUNG"
    expect(tags.last[:color]).to eq "Blue"
  end

  def excel_doc
    File.expand_path("../fixtures/test.xlsx", __dir__)
  end

  def weird_excel_doc
    File.expand_path("../fixtures/weird_test.xlsx", __dir__)
  end
end
