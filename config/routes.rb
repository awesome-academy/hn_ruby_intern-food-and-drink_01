Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root "static_pages#home"
  end
end
