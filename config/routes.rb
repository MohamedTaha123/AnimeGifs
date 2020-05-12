# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'editor/create'
  resources :conversations, only: %i[create index] do
    resources :chats, only: %i[create new]
  end
  get 'dashboard/index'
  resources :gifs do
    member do
      put 'like', to: 'gifs#like'
      put 'unlike', to: 'gifs#unlike'
      put 'follow', to: 'gifs#follow'
      put 'unfollow', to: 'gifs#unfollow'
    end
  end

  namespace :admin do

    resources :gifs
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

  resources :notifications, only: [:index] do
    member do
      put 'markasread', to: 'notifications#mark_as_read'
    end
  end
  resources :announcements, only: [:index]
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'gifs#index'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
