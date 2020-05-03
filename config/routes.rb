# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'dashboard/index'
  resources :gifs do
    member do
      put 'like', to: 'gifs#like'
      put 'unlike', to: 'gifs#unlike'
    end
  end
  namespace :admin do
    resources :users
    resources :services
    resources :notifications
    resources :announcements

    root to: 'users#index'
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'gifs#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
