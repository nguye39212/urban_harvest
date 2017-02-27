class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.text :description
      t.datetime :expires
      t.integer :donor_id
      t.integer :food_bank_id

      t.timestamps
    end
  end
end
