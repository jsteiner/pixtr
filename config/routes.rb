Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"
  resources :galleries do
    resources :images, only: [:new, :create]
  end

  resources :groups, only: [:index, :show, :new, :create]

  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]
  end

  resources :users, only: [:show] do
    member do
      post "follow" => "following_relationships#create"
    end
  end
end
