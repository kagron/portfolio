Rails.application.routes.draw do
  root 'pages#index'
  resources :contacts, only: :create
  get 'contact', to: 'contacts#new', as: 'new_contact'
  
  patch "/blog/:year/:month/:slug", :to => "posts#update"
  put "/blog/:year/:month/:slug", :to => "posts#update"
  resources :blog, as: 'posts',  controller: 'posts', except: [:show, :edit, :update]
  
  # Get /posts/2012/07/slug-of-the-post
  get "/blog/:year/:month/:slug", :to => "posts#show",
  :as => :post_date, :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :slug => /[a-z0-9\-]+/ }
  
  get "/blog/:year/:month/:slug/edit", :to => "posts#edit",
  :as => :edit_post, :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :slug => /[a-z0-9\-]+/ }
  
  delete "/blog/:year/:month/:slug", :to => "posts#destroy", 
  :as => :delete_post, :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :slug => /[a-z0-9\-]+/ }
  

end
