class AddPickedUpToDonations < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :picked_up, :boolean, default: false
  end
end
