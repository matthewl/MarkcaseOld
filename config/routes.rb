Rails.application.routes.draw do
  resources :bookmarks, except: :index
  resources :sessions

  get '/preferences' => 'preferences#edit'
  patch '/preferences' => 'preferences#update'

  get '/tags/:name', to: 'tags#show', as: 'tag'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  root to: 'home#index'
end
