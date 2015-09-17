require 'rails_helper'

feature "Area user views a user activity feed" do
  scenario "successfully", js: true do
    store_user = create(:store_user)
    tag = create(:tag)
    sign_in_as(store_user)
    find('.cart-status').click

    click_link "Cart: 1"
    click_button "Download All"

    click_link store_user.email
    click_link "Sign Out"

    area_user = create(:area_user)
    sign_in_as(area_user)
    click_link area_user.email
    click_link "Users"
    click_link "Activity"
    expect(page).to have "#{store_user.email} downloaded 1 tag."
  end
end
