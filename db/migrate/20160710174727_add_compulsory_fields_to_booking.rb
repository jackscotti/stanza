class AddCompulsoryFieldsToBooking < ActiveRecord::Migration[5.0]
  def change
    change_column :bookings, :room_id, :string, :null => false
    change_column :bookings, :start, :string, :null => false
    change_column :bookings, :end, :string, :null => false
  end
end
