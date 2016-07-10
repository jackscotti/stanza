require 'rails_helper'

describe Booking do
  context "Creating a booking" do
    context "failing cases" do
      it "errors when not assigned to a room" do
        b = Booking.new
        b.save
        expect(b.errors.messages).to include(:room => ["can't be blank"])
      end
    end
  end
end
