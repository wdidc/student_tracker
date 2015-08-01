Rails.application.routes.draw do
  get '/auth/github/callback', to: "statuses#authenticate"
  get '/stats', to: "statuses#stats"
  get "/recent", to: "statuses#recent"
  resources :statuses
  resources :users, only: [:index]
  resources :notifications
  get "/:github_id", to: "statuses#show"
  get "/:github_id/projects", to: "statuses#projects"
  get "/", to: "statuses#index"
  root "statuses#index"
end
