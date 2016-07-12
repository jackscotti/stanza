class Room < ApplicationRecord
  has_many :bookings

  def self.find_available_rooms(start_time, end_time)
    # SELECT ROOM FROM BOOKING.ROOM
    # WHERE NOT BOOKING.START_TIME >= ? AND BOOKING.end_time <= ?
    binding.pry
    Booking.includes(:room).where("? BETWEEN start_time AND end_time OR ? BETWEEN start_time AND end_time", start_time, end_time).map(&:room)
  end
end
