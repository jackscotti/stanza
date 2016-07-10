class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.datetime :start
      t.datetime :end
      t.belongs_to :room, foreign_key: true

      t.timestamps
    end
  end
end
