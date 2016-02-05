BpAtHome::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'pages#home'

  get 'doctors', to: 'pages#doctor'

  resource :sessions
  get 'signup', to: 'user#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :password_resets

  resources :doctors do
    resources :patients
  end

  resources :feedbacks

  resources :patients do
    resources :readings do
      collection { get 'export' }
    end
    resources :feedbacks
  end

  scope '/api' do
    scope '/v1' do
      scope 'readings' do
        post '/' => 'api_readings#create'
      end
    end
  end

end
