Rails.application.routes.draw do
  resources :widgets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/posts", to: "posts#create"
  get "/posts", to: "posts#index"
  post "/ratings", to: "ratings#create"
end
