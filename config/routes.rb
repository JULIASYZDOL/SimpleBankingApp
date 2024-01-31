Rails.application.routes.draw do
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :accounts
  resources :transactions
  
  resources :sessions, only: [:new, :create, :destroy] do
    get :password_combination, on: :collection
    post :verify_combination, on: :collection
    get 'validate_characters', on: :collection
    post 'validate_characters', on: :collection
    get :enter_characters, on: :collection
  end

  get '/logout', to: 'sessions#destroy', as: :logout

  get 'transactions/show', to: 'transactions#show', as: 'transactions_show'

  resources :password_combinations, only: [:show]

  post '/csp_report', to: 'csp_reports#report'
end
