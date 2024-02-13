# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users do
    resources :accounts, except: :index
    resources :payments, only: %i[new create]
  end

  root 'users#index'
end
