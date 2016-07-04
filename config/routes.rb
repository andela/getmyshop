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

  scope controller: :landing do
    get "/contact"  => :contact
    get "/about"    => :about
    get "/blog"     => :blog
    get "/blog/:id" => :single_post
    get "/faq"      => :frequently_asked_questions
  end

  scope "/shopowners", controller: :shops do
    get "/:shop_owner_id/shop/new" => :new,
    as: :shop_new
    get "/:shop_owner_id/admin/dashboard" => :show,
    as: :dashboard
    post "/shops" => :create
    get "/shops/:id/edit" => :edit, as: :edit_shop
  end

  scope "shopowners", controller: :shop_owners do
    get "/activate/:shop_owner_id/:activation_token" => :shop_owner_activate,
    as: :activate_shop_owners
    get "new" => :new, as: :signup
    post "/shop_owners" => :create
  end

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy", as: :logout
  get "/wishlist", to: "wishlist#index", as: :wishlist_index
  post "/wishlist", to: "wishlist#update"
  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]
  resources :categories, only: [:show, :index]
  get "/categories/:category_id/subcategory/:id",
      to: "categories#show", as: :subcategory
  resources :addresses, except: [:show, :inde]
  resources :users, except: [:show] do
    collection do
      get "account", to: "users#account"
      get ":id/addresses", to: "users#addresses", as: :addresses
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
  
  resources :orders, only: [] do
    collection do
      post "/address", to: "orders#address", as: :address
      post "/summary", to: "orders#summary", as: :summary
      post "/payment/", to: "orders#payment", as: :payment
      post "/payment/:type", to: "orders#post_payment", as: :post_payment
      get "/confirmation", to: "orders#confirmation", as: :confirmation
      get "/past_orders", to: "orders#past_orders", as: :past
      post "/:id", to: "orders#show"
      delete "/:id", to: "orders#destroy", as: :order_cancel
    end
  end
  post "/paypal_hook", to: "orders#paypal_hook", as: :hook
end
