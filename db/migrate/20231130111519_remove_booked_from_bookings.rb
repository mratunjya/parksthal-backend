class RemoveBookedFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :booked, :string
  end
end
