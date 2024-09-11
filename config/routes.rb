Rails.application.routes.draw do
    # devise_for :users, controllers: {
    #       sessions: "users/sessions"
    #     }
    devise_for :users, controllers: { registrations: "users/registrations" }
resources :projects do
    collection do
      get "search", to: "projects#search", as: "search"
    end
    resources :bugs do
    end
  end
    # associating controller name
    root to: "projects#index" # associating controller action
  end
