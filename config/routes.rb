require 'sidekiq/web' # require the web UI
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, param: :uuid, only: %i[show]



  # routes for items

  resources :users, param: :id do
    resources :items, param: :uuid
  end


  # Defines the root path route ("/")
  # root "posts#index"
end
