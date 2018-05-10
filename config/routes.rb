Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes do
        post :search, on: :collection
      end
      resources :pictures, only: [:destroy]
    end
  end

  post '/auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
end
