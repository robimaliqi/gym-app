class GymClass < ApplicationRecord
  has_many :bookings

  def duplicate?(user)
    bookings.exists?(user: user)
  end
end
