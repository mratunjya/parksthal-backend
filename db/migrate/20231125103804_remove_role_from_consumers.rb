class RemoveRoleFromConsumers < ActiveRecord::Migration[7.0]
  def change
    remove_column :consumers, :role, :string
  end
end
