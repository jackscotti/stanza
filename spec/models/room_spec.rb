# TODO: find by capacity

require 'rails_helper'

describe Room do
  context "find available rooms" do
    before do
      @room_1 = Room.new
      @room_2 = Room.new

      booking_1 = Booking.new(
        start_time: DateTime.now + 1.day - 1.hour,
        end_time: DateTime.now + 1.day + 1.hour,
        room: @room_1,
      )
      booking_2 = Booking.new(
        start_time: DateTime.now + 1.day - 1.hour,
        end_time: DateTime.now + 1.day + 3.hour,
        room: @room_2,
      )

      @room_1.save
      @room_2.save
      booking_1.save
      booking_2.save
    end

    # reword
    it "returns all rooms" do
      booking_start = DateTime.now + 2.day
      booking_end = DateTime.now + 2.day + 30.minutes

      expect(Room.find_available_rooms(booking_start, booking_end)).to eq([
        @room_1,
        @room_2,
      ])

      # Booking.where("start_time >= ? AND end_time <= ?", start_time, end_time)
      # => []
    end

    # reword
    it "returns one room" do
      booking_start = DateTime.now + 1.day + 1.hour
      booking_end = DateTime.now + 2.day + 2.hour

      expect(Room.find_available_rooms(booking_start, booking_end)).to eq([
        @room_1,
      ])
    end

    # reword
    it "returns no rooms" do
      booking_start = DateTime.now + 1.day - 1.hour
      booking_end = DateTime.now + 1.day + 1.hour

      expect(Room.find_available_rooms(booking_start, booking_end)).to eq([])
    end
  end
end
