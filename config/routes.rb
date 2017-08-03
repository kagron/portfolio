Rails.application.routes.draw do
  root 'pages#index'
  resources :contacts, only: :create
  get 'contact', to: 'contacts#new', as: 'new_contact'
  
  patch "/blog/:year/:month/:slug", :to => "posts#update"
  put "/blog/:year/:month/:slug", :to => "posts#update"
  resources :blog, as: 'posts',  controller: 'posts', except: [:show, :edit, :update, :delete]
  
  # Get /posts/2012/07/slug-of-the-post
  get "/blog/:year/:month/:slug", :to => "posts#show",
  :as => :post_date, :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :slug => /[a-z0-9\-]+/ }
  
  get "/blog/:year/:month/:slug/edit", :to => "posts#edit",
  :as => :edit_post, :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :slug => /[a-z0-9\-]+/ }
  
  
  
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
