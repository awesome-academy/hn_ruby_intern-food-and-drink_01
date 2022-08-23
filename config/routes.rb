Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users
    resources :products, only: %i(index show)
    resources :carts, except: :show
    resources :orders, except: :destroy

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :users
      resources :orders, except: :destroy
    end
  end
end
