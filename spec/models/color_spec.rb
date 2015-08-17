require 'rails_helper'

RSpec.describe Color, type: :model do
  it "has a valid factory" do
    color = create(:color)
    expect(color).to be_valid
  end
end
