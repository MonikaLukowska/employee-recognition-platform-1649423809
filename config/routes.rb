# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin', controllers: {sessions: 'admin_users/sessions', passwords: 'admin_users/passwords'}

  devise_scope :admin_user do
    get 'admin', to: 'admin_users/sessions#new'
  end

  scope module: 'admin_users', path: 'admin' do
    get '/dashboard', to: '/admin_users/pages#dashboard', as: :dashboard
    resources :kudos
  end

  
  resources :kudos

  devise_for :employees, path: '', controllers: {sessions: 'employees/sessions',passwords: 'employees/passwords',
    registrations: 'employees/registrations'}

  root to: 'kudos#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
