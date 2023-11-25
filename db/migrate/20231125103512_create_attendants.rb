class CreateAttendants < ActiveRecord::Migration[7.0]
  def change
    create_table :attendants do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :parking_lot_id

      t.timestamps
    end
  end
end
