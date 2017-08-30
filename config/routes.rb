Rails.application.routes.draw do
  root to: 'home#index', format: false
  resource :home, only: [:index]

  namespace :api do
    namespace :v1 do
      jsonapi_resources :products, only: [:index, :show]
    end
  end

  # Default route passes everything to vue
  get '/*path', to: 'home#index', format: false
end
