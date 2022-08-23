Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/cart_order", to: "carts#show"

    resources :users
    resources :products, only: %i(index show)
    resources :carts, only: %i(index create)

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :users
    end
  end
end
