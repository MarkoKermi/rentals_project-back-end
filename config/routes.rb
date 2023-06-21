# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do  
      resources :users, only: %i[index create destroy]
      resources :vespas, only: %i[index create show update destroy]
      resources :reservations, only: %i[index create show update destroy]
      post 'login', to: 'authentication#create'
      post 'register', to: 'users#create'
    end
  end
end
