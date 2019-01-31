Rails.application.routes.draw do
  resources :bookmarks, except: :index
  resources :password_reset, except: %i[index destroy]
  resources :sessions
  resources :setup, only: %i[new create]

  get '/preferences' => 'preferences#edit'
  patch '/preferences' => 'preferences#update'

  get '/tags/:name', to: 'tags#show', as: 'tag'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get '/feed.rss', to: 'feeds#index', as: 'rss_feed'

  root to: 'home#index'
end
