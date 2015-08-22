require 'rails_helper'

feature "Area user creates a tag" do
  scenario "successfully" do
    area_user = create(:area_user)
    sign_in_as(area_user)
    color = create(:color)
    tag = build_stubbed(:tag, color: color)

    click_link "New Tag"
    fill_in_tag_form_for tag

    click_button "Create Tag"
    expect(page).to have_content "Tag for #{tag.name} created successfully!"
  end

  scenario "is redirected away if not area user" do
    store_user = create(:store_user)
    sign_in_as(store_user)

    visit new_tag_path

    expect(current_path).to eq root_path
  end

  def fill_in_tag_form_for(tag)
    fill_in "Name", with: tag.name
    fill_in "Model", with: tag.model
    fill_in "Manufacturer", with: tag.manufacturer
    fill_in "Color", with: tag.color.name
    fill_in "Size", with: tag.size
  end
end
