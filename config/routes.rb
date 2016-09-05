Rails.application.routes.draw do
  get "orders/create"
  resources :products

  root "landing#index"

  get "/review"             => "products#review"
  post "/review"            => "products#rate"

  get "/checkout"           => "checkout#index"
  get "/search"             => "search#result"
  get "/filter"             => "filter#index"

  scope "/cart", controller: :carts do
    get "/"              => :index, as: :cart_index
    post "/"             => :add_item, as: :cart
    get "/delete"        => :delete_all, as: :empty_cart
    get "/delete/:id"    => :delete_item, as: :delete_order_item
    post "/update/:id"   => :update_item, as: :update_order_item
  end

  scope controller: :landing do
    get "/contact"  => :contact
    get "/about"    => :about
    get "/blog"     => :blog
    get "/blog/:id" => :single_post
    get "/faq"      => :frequently_asked_questions
  end

  scope "/shopowners", controller: :shops do
    get "/shop/new"            => :new, as: :shop_new
    get "/admin/shop/products" => :products, as: :shop_products
    get "/admin/dashboard"     => :show, as: :dashboard
    get "/admin/shop/orders" => :orders
    post "/shops"              => :create
    get "/shops/:id/edit"      => :edit, as: :edit_shop
    patch "shop/profile/update" => :update, as: :profile_update
  end

  scope "/shopowners", controller: :shop_owners do
    get "/activate/:token"   => :shop_owner_activate,
        as: :activate_shop_owners
    get "/new"               => :new, as: :signup
    post "/create"           => :create, as: :shopowner_create
  end

  scope controller: :sessions do
    get "/login"  => :new, as: :login
    post "/login" => :create
    get "/logout" => :destroy, as: :logout
  end

  scope "/shopowners", controller: :sessions do
    get "/login"     => :shop_owner_login, as: :shop_owner_login
    post "/login"    => :shop_owner_create
    delete "/logout" => :shop_owner_destroy, as: :shop_owner_logout
  end

  scope "/shopowners", controller: :products do
    get "/products/new" => :new
    post "/shop/products" => :create
    get "/:id/edit" => :edit, as: :edit_shop_product
    put "/:id/update" => :update, as: :update_shop_product
    post "/shop/product/validate" => :validate_product
    delete "/shop/products/:id" => :destroy
  end

  get "/wishlist" => "wishlist#index", as: :wishlist_index
  post "/wishlist" => "wishlist#update"
  match "auth/:provider/callback" => "sessions#create", via: [:get, :post]

  resources :categories, only: [:show, :index]
  get "/categories/:category_id/subcategory/:id" => "categories#show",
      as: :subcategory
  resources :addresses, except: [:show, :index]

  scope controller: :users do
    resources :users, except: [:show] do
      collection do
        get "account"             => :account
        get ":id/addresses"       => :addresses, as: :addresses
        get "forgot-password"     => :forgot, as: :forgot
        get "password-reset/:id/:reset_code" => :reset_password,
            as: :passwordreset
        post "password-reset/:id/:reset_code" => :reset
        post "forgot-password" => :process_email
        get(
          "/activate/:user_id/:activation_token" => :activate,
          as: "activate"
        )
      end
    end
  end

  scope controller: :orders do
    resources :orders, only: [] do
      collection do
        post "/address"       => :address, as: :address
        post "/summary"       => :summary, as: :summary
        post "/payment/"      => :payment, as: :payment
        post "/payment/:type" => :post_payment, as: :post_payment
        get "/confirmation"   => :confirmation, as: :confirmation
        get "/past_orders"    => :past_orders, as: :past
        post "/:id"           => :show
        delete "/:id"         => :destroy, as: :order_cancel
      end
    end
    post "/paypal_hook" => :paypal_hook, as: :hook
  end
end
