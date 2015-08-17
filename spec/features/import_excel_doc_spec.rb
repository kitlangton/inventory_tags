require 'rails_helper'

describe "Import from an excel document" do
  it "Imports from an excel doc" do
    northeast = create(:area, name: 'Northeast')
    area_user = create(:area_user, area: northeast)

    visit root_path

    fill_in "Email", with: area_user.email
    fill_in "Password", with: area_user.password
    click_button "Sign In"

    click_link "Import Excel"

    file = File.expand_path("../fixtures/test.xlsx", __dir__)

    attach_file('import_excel_doc', file)
    click_button "Import From Excel"

    expect(page).to have_content "iPhone 4S"
    expect(page).to have_content "APPLE"
    expect(page).to have_content "16GB"
  end

  it "allows the user to edit the parsed tags" do

  end
end

