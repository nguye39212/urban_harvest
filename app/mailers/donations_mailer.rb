class DonationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.donations_mailer.confirmation_email.subject
  #
  def confirmation_email(donation)
    @donor = donation.donor
    @food_bank = donation.food_bank

    mail to: "#{@donor.email}, #{@food_bank.email}", subject: 'Donation Pickup Confirmed'
  end
end