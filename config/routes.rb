Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resources :users, only: [:create, :show, :update, :destroy] do
      post 'get_user_role', on: :collection
    end

    resources :consumers, only: [:create, :show, :update, :destroy] do
      post 'is_any_missing_details', on: :collection
      post 'consumer_details', on: :collection
    end

    resources :attendants, only: [:create, :show, :update, :destroy] do
      post 'is_any_missing_details', on: :collection
      post 'attendant_details', on: :collection
    end

    resources :owners, only: [:create, :show, :update, :destroy] do
      post 'is_any_missing_details', on: :collection
      post 'owner_details', on: :collection
    end
  end
end
