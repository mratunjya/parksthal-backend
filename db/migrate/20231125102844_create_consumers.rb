class CreateConsumers < ActiveRecord::Migration[7.0]
  def change
    create_table :consumers do |t|
      t.string :email
      t.string :role
      t.string :phone

      t.timestamps
    end
  end
end
