Rails.application.routes.draw do

  concern :voting do
    post :upvote, on: :member, to: 'votes#upvote'
    post :downvote, on: :member, to: 'votes#downvote'
  end

  namespace :api do
    namespace :v1 do
      resources :recipes, concerns: :voting do
        post :search, on: :collection
        resources :pictures, only: [:destroy]
        resources :comments, only: [:index, :create, :destroy], concerns: :voting
      end
    end
  end

  post '/auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
end
