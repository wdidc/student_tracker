Rails.application.routes.draw do
  resources :statuses
  get "/:github_id", to: "statuses#show"
  get "/", to: "statuses#index"
  root "statuses#index"
end
