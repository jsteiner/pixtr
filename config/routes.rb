Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"
  resources :galleries do
    resources :images, shallow: true
  end
end
