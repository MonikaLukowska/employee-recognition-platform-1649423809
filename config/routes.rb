# frozen_string_literal: true

Rails.application.routes.draw do
  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[create index]

  root to: 'kudos#index'

  devise_for :employees, path: '', controllers: { sessions: 'employees/sessions' }

  devise_for :admin_users, path: 'admin', controllers: { sessions: 'admin_users/sessions', passwords: 'admin_users/passwords' }

  devise_scope :admin_user do
    get 'admin', to: 'admin_users/sessions#new'
  end

  namespace :admin_users, path: 'admin' do
    get '/dashboard', to: '/admin_users/pages#dashboard', as: :dashboard
    resources :kudos, only: %i[index destroy]
    resources :employees, except: [:show] do
      scope module: 'employees' do
        resources :orders, only: %i[index update]
      end
      collection do
        get 'add_kudos'
        patch 'increase_number_of_available_kudos'
      end
    end
    resources :company_values
    resources :rewards do
      collection do
        get 'upload_csv'
        post 'import_rewards'
      end
    end
    resources :categories, except: [:show]
    get 'orders/export', to: 'orders#export'
  end
end
