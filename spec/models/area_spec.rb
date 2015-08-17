require 'rails_helper'

RSpec.describe Area, type: :model do
  it "has a valid factory" do
    area = create(:area)
    expect(area).to be_valid
  end
end
