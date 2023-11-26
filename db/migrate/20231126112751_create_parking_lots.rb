class CreateParkingLots < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_lots do |t|
      t.string :email
      t.string :name
      t.string :country
      t.string :state
      t.string :city
      t.string :address
      t.integer :parking_lot_id

      t.timestamps
    end
  end
end
