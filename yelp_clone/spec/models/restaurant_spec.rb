require 'rails_helper'

describe Restaurant, type: :model do
  it "is not valid with a name which is less than three characters" do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    @user = User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
    Restaurant.create(name: "Moe's Tavern", description: "A pub", user_id: @user.id)
    restaurant = Restaurant.new(name: "Moe's Tavern", description: "A pub", user_id: @user.id)
    expect(restaurant).to have(1).error_on(:name)
  end

  context "associations" do
    it { belong_to(:user) }
  end
end
