Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'user_root', to: redirect('/boardgames'), as: :user_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :boardgames, only: %i[index show new create destroy] do
    resources :bookings, only: %i[create destroy]
  end

  resources :users, only: %i[show]
end
