Rails.application.routes.draw do
  root to: 'home#index'

  resources :stories do
    resources :contributions, only: [:create]
  end

  # The following 2 routes aren't restful but stories/completed is perceived as stories/:id
  get '/nearby', to: "stories#nearby", as: :nearby
  get '/completed', to: "stories#completed", as: :completed

  get '/stories/:story_id/in_range', to: "stories#in_range", as: 'in_range'

  controller :stories, path: '/' do
    match 'stories', to: "stories#create", via: [ :post, :options]
  end

  controller :contributions, path: "/stories/:story_id/" do
    match 'contributions', to: "contributions#create", via: [ :post, :options]
  end

  controller :stories, path: '/' do
    match '/stories/:story_id/in_range', to: "stories#in_range", via: [ :post, :options]
  end

end
