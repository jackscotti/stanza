class Booking < ApplicationRecord
  belongs_to :room
  validates :room, :presence => true
end
