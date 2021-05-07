Rails.application.routes.draw do

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show', as: :item

  scope :customers do

 devise_for :customers, skip: :all
  devise_scope :customer do
    get 'sign_up' => 'public/registrations#new', as: :new_customer_registration
    post '/' => 'public/registrations#create', as: :customer_registration
    get 'sign_in' => 'public/sessions#new', as: :new_customer_session
    post 'sign_in' => 'public/sessions#create', as: :customer_session
    delete 'sign_out' => 'public/sessions#destroy', as: :destroy_customer_session
  end

  get 'my_page' => 'public/customers#show'
  get 'edit' => 'public/customers#edit'
  patch '/' => 'public/customers#update'
  get 'unsubscribe' => 'public/customers#unsubscribe'
  patch 'withdraw' => 'public/customers#withdraw'

 end

  get 'cart_items' => 'public/cart_items#index', as: :cart_items
  patch 'cart_items/:id' => 'public/cart_items#update', as: :cart_item_update
  delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all', as: :cart_item_destroy_all
  delete 'cart_items/:id' => 'public/cart_items#destroy', as: :cart_item_destroy
  post 'cart_items' => 'public/cart_items#create', as: :cart_item_create

  get 'orders/new' => 'public/orders#new', as: :orders_new
  post 'orders/confirm' => 'public/orders#confirm', as: :orders_confirm
  get 'orders/complete' => 'public/orders#complete', as: :orders_complete
  post 'orders' => 'public/orders#create', as: :orders_create
  get 'orders' => 'public/orders#index', as: :orders_index
  get 'orders/:id' => 'public/orders#show', as: :orders_show
  delete '/orders/destroy_all' => 'public/orders#destroy_all', as: :order_destroy_all

  get 'addresses' => 'public/addresses#index', as: :addresses
  get 'addresses/:id/edit' => 'public/addresses#edit', as: :edit_address
  post 'addresses' => 'public/addresses#create', as: :address_create
  patch 'addresses/:id' => 'public/addresses#update', as: :address_update
  delete 'addresses/:id' => 'public/addresses#destroy', as: :address

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admin/sessions#new', as: :new_admin_session
    post 'admin/sign_in' => 'admin/sessions#create', as: :admin_session
    delete 'admin/sign_out' => 'admin/sessions#destroy', as: :destroy_admin_session

  end

  namespace :admin do

  get '/' => 'homes#top'

  resources :items, only: [:index, :new, :show, :edit]
  post 'items' => 'items#create', as: 'item_create'
  patch 'items/:id' => 'items#update', as: 'item_update'

  get 'genres' => 'genres#index'
  post 'genres' => 'genres#create'
  get 'genres/:id/edit' => 'genres#edit', as: 'genre_show_edit'
  patch 'genres/:id' => 'genres#update', as: 'genre_update'

  resources :customers, only: [:index, :show, :edit]
  patch 'customers/:id' => 'customers#update', as: 'customer_update'

  get 'orders/:id' => 'orders#show', as: 'orders_show'
  patch 'orders/:id' => 'orders#update', as: 'orders_update'

  patch 'order_details/:id' => 'order_details#update', as: 'order_detail_update'

  end
end
