class Booking < ApplicationRecord
  belongs_to :room
  validates :room, :start, :end, :presence => true
  validate :validate_availability

private

  def validate_availability
    # should not check for past bookings, this can be vastly optimised with an appropriate query
    if self.room
      self.room.bookings.each do |b|
        next if self == b

        if b.start <= self.start && b.end >= self.end
          errors.add(:room_availability, "the room is already booked")
        end
      end
    end
  end
end
