class Booking < ApplicationRecord
  belongs_to :room
  after_validation :validate_availability, :validate_date

private

  def validate_availability
    # should not check for past bookings, this can be vastly optimised with an appropriate query
    room.bookings.each do |b|
      next if self == b

      if b.start_time <= start_time && b.end_time >= end_time
        errors.add(:room_availability, "the room is already booked")
      end
    end
  end

  def validate_date
    if start_time >= end_time
      errors.add(:room_availability, "end time can't be earlier than start time")
    end
  end
end
