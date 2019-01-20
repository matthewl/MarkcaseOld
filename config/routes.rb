Rails.application.routes.draw do
  resources :bookmarks, except: :index
  resources :sessions

  get '/start' => 'start#new'
  post '/start' => 'start#create'

  get '/preferences' => 'preferences#edit'
  patch '/preferences' => 'preferences#update'

  get '/tags/:name', to: 'tags#show', as: 'tag'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get '/feed.rss', to: 'feeds#index', as: 'rss_feed'

  root to: 'home#index'
end
