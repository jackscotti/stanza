require 'rails_helper'

describe Booking do
  context "Creating a booking" do
    context "validates the presence of compulsory fields" do
      let(:booking) { Booking.new }

      it "cannot be created when compulsory parameters are not provided" do
        booking.save
        expect(booking.errors.messages).to eq(
          :room => ["can't be blank"],
          :start=>["can't be blank"],
          :end=>["can't be blank"]
        )
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
  end
end
