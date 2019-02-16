Rails.application.routes.draw do
  resources :users, only: :index
  get '/u::username', to: 'users#show', as: 'user'

  resources :bookmarks, except: :index
  get '/preferences' => 'preferences#edit'
  patch '/preferences' => 'preferences#update'
  get '/tags/:name', to: 'tags#show', as: 'tag'
  get '/feed.rss', to: 'feeds#index', as: 'rss_feed'

  resources :password_reset, except: %i[index destroy]
  resources :sessions, only: %i[new create destroy]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :setup, only: %i[new create]
  root to: 'home#index'
end
