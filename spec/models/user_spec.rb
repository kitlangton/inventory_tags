require 'rails_helper'

describe "user" do
  context "store_user" do
    it "has a valid factory" do
      user = create(:store_user)
      expect(user).to be_valid
    end
  end

  context "area user" do
    it "has a valid factory" do
      area_user = create(:area_user)
      expect(area_user).to be_valid
    end
  end
end
