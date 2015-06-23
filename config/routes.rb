Rails.application.routes.draw do
  get '/auth/github/callback', to: "statuses#authenticate"
  resources :statuses
  get "/:github_id", to: "statuses#show"
  get "/", to: "statuses#index"
  root "statuses#index"
end
