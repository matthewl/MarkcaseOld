Rails.application.routes.draw do
  resources :bookmarks, except: :index
  get '/tags/:name', to: 'tags#show', as: 'tag'

  root to: 'home#index'
end
