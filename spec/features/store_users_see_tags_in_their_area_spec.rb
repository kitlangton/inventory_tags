require 'rails_helper'

describe "Store users see tags in their area" do
  it "sees tags in their area" do
    northeast = create(:area, name: 'Northeast')
    tag = create(:tag, area: northeast)
    store_user = create(:user, area: northeast)

    visit root_path

    fill_in "Email", with: store_user.email
    fill_in "Password", with: store_user.password
    click_button "Sign In"

    expect(page).to have_content "iPhone"
    expect(page).to have_content "APPLE"
    expect(page).to have_content "16GB"
  end
end

