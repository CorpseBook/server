Rails.application.routes.draw do
  root to: 'home#index'

  get '/stories/nearby', to: "stories#nearby", as: :nearby
  get '/stories/completed', to: "stories#completed", as: :completed
  get '/stories/:story_id/in_range', to: "stories#in_range", as: 'in_range'

  resources :stories do
    resources :contributions, only: [:create]
  end

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
