Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index, :show]
      resources :backgrounds, only: [:index]
      resources :antipode, only: [:index]
    end
  end
end
