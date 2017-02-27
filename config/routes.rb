Rails.application.routes.draw do


  get 'why-donate-leftovers-to-food-banks', to:'static_pages#why_donate', as:'why_donate'

  get 'current-donations', to: 'donations#current_donations', as:'current_donations'

  devise_for :users

  resources :users do
    resources :donations do
      member do
        get 'confirmation', to: 'donations#confirmation'
        get 'claim', to: 'donations#claim'
        get 'picked_up', to: 'donations#picked_up'
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "dashboard/donor", to:"dashboard#donor_dashboard", as:"donor_dashboard"
  get "dashboard/food_bank", to:"dashboard#food_bank_dashboard", as:"food_bank_dashboard"

  get "about", to: "static_pages#about", as: "about"

  root to: "static_pages#home"

end
