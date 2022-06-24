Rails.application.routes.draw do
  resources :genres
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: "movie_filter"

  resources :movies do
    resource :favorites, only: [:create, :destroy]
    resources :reviews
  end
  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
  resources :users
  get "signup" => "users#new"


end
