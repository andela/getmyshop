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
  root "landing#index"

  get "/review"             => "products#review"
  post "/review"            => "products#rate"

  get "/checkout"           => "checkout#index"
  get "/search"             => "search#result"
  get "/filter"             => "filter#index"
  get "/cart"               => "carts#index", as: :cart_index
  post "/cart"              => "carts#add_item"
  get "/cart/delete-all"    => "carts#delete_all", as: :empty_cart
  get "/cart/delete/:id"    => "carts#delete_item", as: :delete_order_item
  post "/cart/update/:id"   => "carts#update_item", as: :update_order_item

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
    post "/shops"                  => :create
    get "/shops/:id/edit"          => :edit, as: :edit_shop
  end

  scope "/shopowners", controller: :shop_owners do
    get "/activate/:token"   => :shop_owner_activate,
        as: :activate_shop_owners
    get "/new"               => :new, as: :signup
    post "/create"           => :create, as: :shopowner_create
  end

  scope controller: :sessions do
    get "/login"  => :new,     as: :login
    post "/login" => :create
    get "/logout" => :destroy, as: :logout
  end

  scope "/shopowners", controller: :shop_owner_sessions do
    get "/login"  => :new,     as: :shop_owner_login
    post "/login" => :create
    delete "/logout" => :destroy, as: :shop_owner_logout
  end

  get "/wishlist" => "wishlist#index", as: :wishlist_index
  post "/wishlist" => "wishlist#update"
  match "auth/:provider/callback" => "sessions#create", via: [:get, :post]
  resources :categories, only: [:show, :index]
  get "/categories/:category_id/subcategory/:id" => "categories#show", as: :subcategory
  resources :addresses, except: [:show, :inde]
  resources :users, except: [:show] do
    collection do
      get "account"             => "users#account"
      get ":id/addresses"       => "users#addresses", as: :addresses
      get "forgot-password"     => "users#forgot", as: :forgot
      get "password-reset/:id/:reset_code" => "users#reset_password", as: :passwordreset
      post "password-reset/:id/:reset_code" => "users#reset"
      post "forgot-password"    => "users#process_email"
      get(
        "/activate/:user_id/:activation_token" => "users#activate",
        as: "activate"
      )
    end
  end

  resources :orders, only: [] do
    collection do
      post "/address"       => "orders#address", as: :address
      post "/summary"       => "orders#summary", as: :summary
      post "/payment/"      => "orders#payment", as: :payment
      post "/payment/:type" => "orders#post_payment", as: :post_payment
      get "/confirmation"   => "orders#confirmation", as: :confirmation
      get "/past_orders"    => "orders#past_orders", as: :past
      post "/:id"           => "orders#show"
      delete "/:id"         => "orders#destroy", as: :order_cancel
    end
  end
  post "/paypal_hook"       => "orders#paypal_hook", as: :hook
end
