require "sidekiq/web"
Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
  controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    devise_for :users, skip: :omniauth_callbacks

    resources :products, only: %i(index show)
    resources :carts, except: :show
    resources :orders, except: :destroy

    namespace :admin do
      root to: "products#index"
      resources :static_pages
      resources :users
      resources :orders, except: :destroy
      resources :products
      resources :categories
      resources :sizes
    end
    mount Sidekiq::Web => "/sidekiq"
  end
end
