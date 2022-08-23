Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :users
    end
  end
end
