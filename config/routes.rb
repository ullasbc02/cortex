Rails.application.routes.draw do
  root "workspaces#index"

  get "/workspace", to: "workspaces#index"
  get "/home", to: "workspaces#home"
  resources :documents, only: [ :index, :new, :create ]
  get "/search", to: "search#index"
  get  "/leave_requests",     to: "leave_requests#index"
  get  "/leave_requests/new", to: "leave_requests#new"
  post "/leave_requests",     to: "leave_requests#create"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
