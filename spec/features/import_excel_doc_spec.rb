require 'rails_helper'

describe "Import from an excel document" do
  it "Imports from an excel doc" do
    visit root_path

    click_link "Import Excel"

    file = File.expand_path("../fixtures/test.xlsx", __dir__)

    attach_file('import_excel_doc', file)
    click_button "Import From Excel"

    expect(page).to have_content "iPhone 4S"
  end
end
