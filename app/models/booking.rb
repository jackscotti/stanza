class Booking < ApplicationRecord
  belongs_to :room
  validates :room, :start, :end, :presence => true
end
