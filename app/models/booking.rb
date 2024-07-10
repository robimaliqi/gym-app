class Booking < ApplicationRecord
  belongs_to :gym_class
  belongs_to :user
end
