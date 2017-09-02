Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :products, only: [:index, :show]
      jsonapi_resources :categories, only: [:index]
      jsonapi_resources :brands, only: [:index]
    end
  end
end
