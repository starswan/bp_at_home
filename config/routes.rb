BpAtHome::Application.routes.draw do

  get 'signup', to: 'user#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :doctors do
    resources :patients
  end
  resource :sessions

  get "pages/home"
   root :to => 'pages#home'

end
