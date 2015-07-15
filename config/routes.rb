Rails.application.routes.draw do
  get '/auth/github/callback', to: "statuses#authenticate"
  get '/stats', to: "statuses#stats"
  get "/recent", to: "statuses#recent"
  resources :statuses
  get "/:github_id", to: "statuses#show"
  get "/", to: "statuses#index"
  root "statuses#index"
end
