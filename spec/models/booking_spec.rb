require 'rails_helper'

describe Booking do
  context "Creating a booking" do
    context "validates the presence of compulsory fields" do
      let(:booking) { Booking.new }

      it "cannot be created when compulsory parameters are not provided" do
        expect { booking.save }.to raise_error(ActiveRecord::StatementInvalid)
      end

      it "creates the booking when assigned to an existing room" do
        booking.start = DateTime.now + 1.day - 1.hour
        booking.end = DateTime.now + 1.day + 1.hour
        room = Room.new
        booking.room = room
        booking.save

        expect(booking.errors.messages).to be_empty
      end
    end

    context "validates the availability of a room" do
      let(:room) { Room.new }
      let(:booking_1) { Booking.new(
        start: DateTime.now + 1.day - 1.hour,
        end: DateTime.now + 1.day + 1.hour,
        room: room,
      )}

      before do
        room.bookings << booking_1
        room.save
        booking_1.save
      end

      it "allows bookings when a room is available" do
        booking_2 = Booking.new(
          start: DateTime.now + 2.day - 1.hour,
          end: DateTime.now + 2.day + 1.hour,
          room: room,
        )

        booking_2.save

        expect(booking_2.errors.messages).to be_empty
      end

      it "does not allow bookings when a room is not available" do
        booking_2 = Booking.new(
          start: DateTime.now + 1.day - 30.minutes,
          end: DateTime.now + 1.day + 30.minutes,
          room: room,
        )

        booking_2.save

        expect(booking_2.errors.messages).to eq(
          :room_availability => ["the room is already booked"]
        )
      end
    end
  end
end
