require 'rails_helper'

describe Booking do
  before :each do
    @room = Room.new
    @room.save
  end

  context "Creating a booking" do
    context "validates the presence of compulsory fields" do
      it "creates the booking when assigned to an existing room" do
        booking = Booking.new(
          start_time: DateTime.now + 1.day - 1.hour,
          end_time: DateTime.now + 1.day + 1.hour,
          room: @room,
        )
        booking.save

        expect(booking.errors.messages).to be_empty
      end
    end

    context "validates the availability of a room" do
      before do
        @booking_1 = Booking.new(
          start_time: DateTime.now + 1.day - 1.hour,
          end_time: DateTime.now + 1.day + 1.hour,
          room: @room,
        )

        @booking_1.save
        @room.bookings << @booking_1
        @room.save
      end

      it "allows bookings when a room is available" do
        booking_2 = Booking.new(
          start_time: DateTime.now + 2.day - 1.hour,
          end_time: DateTime.now + 2.day + 1.hour,
          room: @room,
        )

        booking_2.save

        expect(booking_2.errors.messages).to be_empty
      end

      it "does not allow bookings when a room is not available" do
        booking_2 = Booking.new(
          start_time: DateTime.now + 1.day - 30.minutes,
          end_time: DateTime.now + 1.day + 30.minutes,
          room: @room,
        )

        booking_2.save

        expect(booking_2.errors.messages).to eq(
          :room_availability => ["the room is already booked"]
        )
      end
    end

    context "checks whether the date is valid" do
      it "does not allow an end date that is earlier than the start_time date" do
        booking = Booking.new

        booking.start_time = DateTime.now + 1.day + 1.hour
        booking.end_time = DateTime.now + 1.day - 1.hour
        booking.room = @room

        booking.save

        expect(booking.errors.messages).not_to be_empty
      end
    end
  end
end
