Rails.application.routes.draw do
  resources :users, only: :index
  get '/u::username', to: 'users#show', as: 'user'
  get '/u::username/tag/:name', to: 'tags#show', as: 'tag'
  get '/feeds/u::username/feed.rss', to: 'feeds#show', as: 'feed', constraints: { format: /rss/ }

  resources :bookmarks, except: :index
  get '/preferences' => 'preferences#edit'
  patch '/preferences' => 'preferences#update'
  get '/search' => 'search#show'
  resources :accounts, only: %i[new create destroy]
  
  resources :password_reset, except: %i[index destroy]
  resources :sessions, only: %i[new create destroy]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :setup, only: %i[new create]
  resources :home, only: :create
  root to: 'home#index'
end
