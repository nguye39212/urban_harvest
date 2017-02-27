task :load_dummy_data => :environment do

  #1 create food donors + donations

  [
    ["Curra's Grill", "614 E Oltorf St", "Austin", "TX", "78704"],
    ["Chicon", "1914 E 6th St", "Austin", "TX", "78702"],
    ["Foreign and Domestic", "306 E 53rd St", "Austin", "TX", "78751"],
    ["Dai Due", "2406 Manor Rd", "Austin", "TX", "78722"]
  ].each do |r|

    u = User.create!(
      email: Faker::Internet.email,
      name: r[0],
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      address_1: r[1],
      address_2: '',
      city: r[2],
      state: r[3],
      zip_code: r[4],
      phone: Faker::PhoneNumber.cell_phone,
      password: 'testing',
      password_confirmation: 'testing',
      role:'donor'
    )

    (rand(1..4)).times do |i|
      food_bank_id = [nil, nil, 1, 2, 3].sample
      n = rand(-3..5)
      expires = DateTime.now.advance(days: n)
      d = Donation.create!(
        expires: expires,
        donor_id: u.id,
        food_bank_id: food_bank_id,
        picked_up: (true if food_bank_id.present?),
        description: Faker::Lorem.sentences.join(' ')
      )
      d.created_at = expires
      d.save
    end

  end


  #2 create food banks

  [
    ["Central Texas Food Bank", "6500 Metropolis Dr", "Austin", "TX", "78744"],
    ["Feeding Texas", "1524 South I H 35", "Austin", "TX", "78704"],
    ["Travis Heights Christian Outreach", "4403 Russell Dr", "Austin", "TX", "78745"]
  ].each do |r|

    u = User.create!(
      email: Faker::Internet.email,
      name: r[0],
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      address_1: r[1],
      address_2: '',
      city: r[2],
      state: r[3],
      zip_code: r[4],
      phone: Faker::PhoneNumber.cell_phone,
      password: 'testing',
      password_confirmation: 'testing',
      role:'food_bank'
    )
  end

end


