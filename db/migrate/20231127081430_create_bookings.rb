class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :razorpayOrderId
      t.string :razorpaySignature
      t.string :razorpayPaymentId
      t.string :parking_lot_id
      t.string :price
      t.string :phone
      t.string :email
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
