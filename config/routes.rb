Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes do
    post 'message'
  end  
  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  get 'search', to: "recipes#search"
  resources :lists
  get 'profile', to: "users#show"
end
