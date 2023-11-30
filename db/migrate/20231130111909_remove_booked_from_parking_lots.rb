class RemoveBookedFromParkingLots < ActiveRecord::Migration[7.0]
  def change
    remove_column :parking_lots, :booked, :string
  end
end
