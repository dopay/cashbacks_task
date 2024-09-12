# frozen_string_literal: true

Rails.application.routes.draw do
  get 'transactions/index'
  resources :users do
    resources :accounts, except: :index do
      resources :transactions, only: [:index]
    end
    resources :payments, only: %i[new create]
  end

  root 'users#index'
end
