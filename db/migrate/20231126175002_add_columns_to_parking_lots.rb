class AddColumnsToParkingLots < ActiveRecord::Migration[7.0]
  def change
    add_column :parking_lots, :booked, :string
    add_column :parking_lots, :total_capacity, :string
    add_column :parking_lots, :price, :string
  end
end
