require './app/services/excel_tags_parser'

describe ExcelTagsParser do

  it "parses an Excel doc and returns an array of hashes" do
    tags = ExcelTagsParser.new(excel_doc).parse.tags
    expect(tags.count).to eq 19
  end

  def excel_doc
    File.expand_path("../fixtures/test.xlsx", __dir__)
  end
end
