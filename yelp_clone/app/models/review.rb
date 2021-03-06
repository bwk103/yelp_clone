class Review < ApplicationRecord

  belongs_to :restaurant
  belongs_to :user


  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: {scope: :restaurant, message: "has reviewed this already" }

end
