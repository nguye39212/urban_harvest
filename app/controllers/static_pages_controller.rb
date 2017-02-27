class StaticPagesController < ApplicationController
  before_action :check_signed_in, only:[:home]

  def home
  end

  def about
  end

  def why_donate
  end

  private

  def check_signed_in
    if current_user.present?
      if current_user.food_bank?
        redirect_to food_bank_dashboard_path
      else
        redirect_to donor_dashboard_path
      end
    end
  end

end
