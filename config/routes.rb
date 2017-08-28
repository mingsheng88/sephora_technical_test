Rails.application.routes.draw do
  root to: 'home#index'
  resource :home, only: [:index]

  namespace :api do
    namespace :v1 do
      jsonapi_resources :products, only: [:index, :show]
    end
  end
end
