Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"
  resource :dashboard, only: [:show]

  resources :galleries do
    resources :images, only: [:new, :create]
  end

  resources :groups, only: [:index, :show, :new, :create] do
    member do
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
    end
  end

  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]
    member do
      post "like" => "likes#create"
      delete "unlike" => "likes#destroy"
    end
  end

  resources :users, only: [:show] do
    member do
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end
end
