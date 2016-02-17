Rails.application.routes.draw do
  get "orders/create"

  # Example resource route
  # (maps HTTP verbs to controller actions automatically):

  resources :products

  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: "landing#index"

  get "/checkout", to: "checkout#index"
  get "/cart", to: "carts#index"
  post "/cart", to: "carts#add_to"
  get "/contact", to: "landing#contact"
  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy", as: :logout
  get "/wishlist", to: "wishlist#index", as: :wishlist_index
  post "/wishlist", to: "wishlist#update"
  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]
  resources :categories, only: [:show, :index]
  resources :users, only: [:new, :create] do
    collection do
      get "forgot-password", to: "users#forgot", as: :forgot
      get "password-reset/:id/:reset_code",
          to: "users#reset_password", as: :passwordreset
      post "password-reset/:id/:reset_code", to: "users#reset"
      post "forgot-password", to: "users#process_email"
      get(
        "/activate/:user_id/:activation_token",
        to: "users#activate",
        as: "activate"
      )
    end
  end

  resources :orders do
    collection do
      post "/address", to: "orders#address", as: :address
      post "/summary", to: "orders#summary", as: :summary
      post "/payment/", to: "orders#payment", as: :payment
      post "/payment/:type", to: "orders#post_payment", as: :post_payment
      get "/confirmation", to: "orders#confirmation", as: :confirmation
    end
    # get "/new", to: "orders#new"
    # get "/payment", to: "orders#payment"
  end
  # get "/users/new", to: "users#new", as: "user_new"
  # get "/users/signin", to: "users#signin", as: "user_signin"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

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
