Rails.application.routes.draw do
  resources :tracks
  resources :conferences do
    post '/organize', to: 'conferences#organize', on: :member
  end
  resources :lectures
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
