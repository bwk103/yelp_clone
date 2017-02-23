class Restaurant < ApplicationRecord

  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :name, length: { minimum: 3 }, uniqueness: true


  def build_review(revparams = {}, user)
    p user
    # revparams[:user] ||= user
    p revparams
    review = Review.new(revparams)
    review
  end

end
