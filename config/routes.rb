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

  get "/review", to: "products#review"
  post "/review", to: "products#rate"

  get "/checkout", to: "checkout#index"
  get "/search", to: "search#result"
  get "/filter", to: "filter#index"
  get "/cart", to: "carts#index", as: :cart_index
  post "/cart", to: "carts#add_item"
  get "/cart/delete-all", to: "carts#delete_all", as: :empty_cart
  get "/cart/delete/:id", to: "carts#delete_item", as: :delete_order_item
  post "/cart/update/:id", to: "carts#update_item", as: :update_order_item
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
      get "/past_orders", to: "orders#past_orders", as: :past
      post "/:id", to: "orders#show"
    end
  end
  post "/paypal_hook", to: "orders#paypal_hook", as: :hook
end
