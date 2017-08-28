Rails.application.routes.draw do
  root to: 'products#index'

  namespace :api do
    namespace :v1 do
      jsonapi_resources :products, only: [:index, :show]
    end
  end
end
