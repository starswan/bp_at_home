BpAtHome::Application.routes.draw do

  root :to => 'pages#home'

  resource :sessions
  get 'signup', to: 'user#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :password_resets

  resources :doctors do
    resources :patients
  end

  resources :patients do
    resources :readings do
      collection { get 'export' }
    end
  end

end
