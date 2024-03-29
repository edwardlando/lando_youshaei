LandoYoushaei::Application.routes.draw do
  
  resources :confirmations

  resources :orders

  resources :line_items

  resources :carts

  devise_for :users, :controllers => { :registrations => "registrations",
  :omniauth_callbacks => "omniauth_callbacks", :sessions => "sessions" } 

  # match '/users/sign_out' => 'sessions#destroy', :via => :get

  devise_scope :user do
    get "/users/sign_out" => "sessions#destroy"
  end

  match "/application/create_guest_user" =>
  "application#create_guest_user", :via => :post

  resources :users

  get "users/index"
  get "users/show"
  get "users/add_to_wishlist"
  get "users/add_to_cart"
  post "users/add_to_cart"

  resources :channels
 
  match '/channels' => 'channels#create', :via => :post
  match '/channels' => 'channels#index', :via => :get
  match '/threads/:id' => 'store#index'

  get "channels/show"

  get "store/index"
  post "store/index"

  root :to => 'store#index'

  resources :items do
    member do
      post :vote
    end
  end

  
  resources :wishlists

  resources :confirmations do
    member do
      get :accept_to_pay
    end
  end

  get "wishlists/show"

  get "orders/show"

  get "confirmations/show"

  get "static_pages/about"
  get "static_pages/tastemakers"
  get "static_pages/contact"
  get "static_pages/terms"
  get "static_pages/privacy"
  get "static_pages/jobs"

 
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
