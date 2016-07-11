class Room < ApplicationRecord
  has_many :bookings

  def self.find_available_rooms(start_time, end_time)
    true
  end
end
