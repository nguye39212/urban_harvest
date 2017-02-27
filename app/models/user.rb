class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 geocoded_by :full_street_address
 after_validation :geocode

 has_many :donor_donations, :class_name => 'Donation', :foreign_key => "donor_id"
 has_many :food_bank_donations, :class_name => 'Donation', :foreign_key => "food_bank"

 def full_street_address
   location_array = Array.new
   location_array << address_1 if address_1.present?
   location_array << city if city.present?
   location_array << state if state.present?
   location_array << zip_code if zip_code.present?
   [location_array].join(', ')
 end

 def food_bank?
   true if role == "food_bank"
 end

 def donor?
   true if role == "donor"
 end

 def full_name
   "#{first_name} #{last_name}"
 end

end

