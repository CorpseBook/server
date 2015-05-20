Rails.application.routes.draw do
  root to: 'home#index'

  resources :stories do
    # nice work only producing the routes you are going to use
    resources :contributions, only: [:create]
  end

  # You can put this in the nested route so you don't have to manually specify
  # the story part of this URL. Helps keep common route togther, in this case
  # all the story routes.
  #
  # Also something to keep in mind. If you are not using RESTful routes then
  # you may be missing a controller. One or two might be ok but they tend to grow
  # as soon as you have non RESTful routes. Maybe there is a NearbyController
  # that could do this job?
  get '/stories/nearby' => "stories#nearby"

  # See notes above. Until we ran rake routes we didn't realise there were
  # more story routes as they are not nested in the first block. Once again
  # keeping in mind RESTful controllers/routes as well. Likely missing
  # controller/objects.
  controller :stories, path: '/' do
    match 'stories', to: "stories#create", via: [ :post, :options]
  end

  controller :contributions, path: "/stories/:story_id/" do
    match 'contributions', to: "contributions#create", via: [ :post, :options]
  end

  # Good to have these around for reference at first but I like to delete the
  # examples pretty soon after so you don't have it cluttering your code base.

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
