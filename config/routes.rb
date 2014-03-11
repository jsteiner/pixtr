Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "galleries#index"
  resources :galleries do
    resources :images, shallow: true
  end
end
