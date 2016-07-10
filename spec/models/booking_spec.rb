require 'rails_helper'

describe Booking do
  context "Creating a booking" do
    context "validates the presence of a room" do
      let(:booking) { Booking.new }
      let(:room) { Room.new }

      it "errors when not assigned to a room" do
        booking.save
        expect(booking.errors.messages).to include(:room => ["can't be blank"])
      end
      it "creates the booking when assigned to an existing room" do
        booking.room = room
        booking.save
        expect(booking.errors.messages).not_to include(:room => ["can't be blank"])
      end
    end
  end
end
