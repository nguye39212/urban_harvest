class Donation < ApplicationRecord
  belongs_to :donor, :class_name => "User", :inverse_of => :donor_donations
  belongs_to :food_bank, :class_name => "User", :inverse_of => :food_bank_donations, required: false

  scope :fresh, -> {where("expires > ?", Time.now)}
  scope :unclaimed, -> {where("food_bank_id IS NULL")}
  scope :expired, -> {where("expires < ?", Time.now)}
  scope :pending, -> {where("food_bank_id IS NOT NULL").where(picked_up:false)}
  scope :picked_up, -> {where("food_bank_id IS NOT NULL").where(picked_up:true)}

  def latitude
    donor.latitude
  end

  def longitude
    donor.longitude
  end

  def claim!(food_bank)
    update_columns(food_bank_id:food_bank.id)
  end

  def picked_up!
    update_columns(picked_up:true)
  end

  def claimed?
    true if food_bank_id.present?
  end

end
