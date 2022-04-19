# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin', controllers: {sessions: 'admin_users/sessions', passwords: 'admin_users/devise/passwords'}

  namespace :admin do
    get '/dashboard', to: '/admin_users/pages#dashboard', as: :dashboard
  end

  

  resources :kudos

  devise_for :employees, path: '', controllers: {sessions: 'employees/sessions',passwords: 'employees/devise/passwords',
    registrations: 'employees/devise/registrations'}
    root to: 'kudos#index', as: :employee_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
