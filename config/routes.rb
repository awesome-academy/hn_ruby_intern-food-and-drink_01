Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/cart_order", to: "carts#index"

    resources :users
    resources :products, only: %i(index show)
    resources :carts, only: %i(index create update destroy)
    resources :orders, except: :destroy

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :users
      resources :orders, except: :destroy
      resources :products
      resources :categories
    end
  end
end
