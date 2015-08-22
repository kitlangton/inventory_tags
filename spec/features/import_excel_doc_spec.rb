require 'rails_helper'

feature "Area user imports tags from an excel doc" do
  scenario "is redirected away if if not an area user" do
    sign_in_as(create(:store_user))

    visit new_tags_excel_import_path
    expect(current_path).to eq root_path
  end

  scenario "successfully" do
    sign_in_as(create(:area_user))

    click_link "Import Excel"
    attach_valid_excel
    click_button "Import From Excel"

    expect(page).to have_content "iPhone 4S"
    expect(page).to have_content "APPLE"
    expect(page).to have_content "16GB"
  end

  scenario "and submits the excel" do
    sign_in_as(create(:area_user))

    click_link "Import Excel"
    attach_valid_excel
    click_button "Import From Excel"

    click_button "Create Tags"
    expect(page).to have_content "Assign Colors"
    expect(page).to have_content "White CPO"
    expect(current_path).to eq confirm_colors_path
  end

  def attach_valid_excel
    file = File.expand_path("../fixtures/test.xlsx", __dir__)
    attach_file('import_excel_doc', file)
  end
end

