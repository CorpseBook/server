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

  controller :stories, path: '/' do
    match 'nearby', to: "stories#nearby", via: [ :post, :options]
  end

  # controller :stories, path: "/stories/:id/" do
  #   match 'in_range', to: "stories#in_range", via: [ :get], as: 'in_range'
  # end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
