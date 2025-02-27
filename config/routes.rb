Rails.application.routes.draw do
  constraints host: ENV.fetch("WEB_HOST", "localhost") do
    root "home#index"

    devise_for :users

    resources :books, only: [ :index ]

    get "up" => "rails/health#show", as: :web_rails_health_check
  end

  # Admin routes with constraints for separate domain
  constraints host: ENV.fetch("ADMIN_HOST", "admin.localhost") do
    devise_for :admin_users, ActiveAdmin::Devise.config.merge(path: "")
    ActiveAdmin.routes(self)

    get "up" => "rails/health#show", as: :admin_rails_health_check
  end
end
