require 'rails_helper'

feature "New users are redirected to an onboarding tutorial" do
  scenario "when they log in for the first time" do
    user = create(:store_user, onboarded: false)

    sign_in_as(user)

    expect(current_path).to eq onboarding_path
  end

  scenario "unless they have already completed the tutorial" do
    user = create(:store_user, onboarded: false)
    user.onboard!

    sign_in_as(user)

    expect(current_path).to_not eq onboarding_path
  end
end
