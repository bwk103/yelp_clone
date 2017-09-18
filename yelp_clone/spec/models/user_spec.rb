require 'rails_helper'

  describe User, type: :model do
    context "associations" do
      it { should have_many(:restaurants) }
      it { is_expected.to have_many :reviewed_restaurants }
    end
  end
