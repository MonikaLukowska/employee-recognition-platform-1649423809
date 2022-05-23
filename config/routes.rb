# frozen_string_literal: true

Rails.application.routes.draw do
  resources :kudos

  root to: 'kudos#index'

  devise_for :employees, path: '', controllers: {sessions: 'employees/sessions'}

  devise_for :admin_users, path: 'admin', controllers: {sessions: 'admin_users/sessions', passwords: 'admin_users/passwords'}

  devise_scope :admin_user do
    get 'admin', to: 'admin_users/sessions#new'
  end

  namespace :admin_users, path: 'admin' do
    get '/dashboard', to: '/admin_users/pages#dashboard', as: :dashboard
    resources :kudos, only: [:index, :destroy]
    resources :employees, except: [:show]
    resources :company_values
    
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
