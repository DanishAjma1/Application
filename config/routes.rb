Rails.application.routes.draw do
    # devise_for :users, controllers: {
    #       sessions: "users/sessions"
    #     }
    devise_for :users, controllers: { registrations: "users/registrations" }
resources :projects do
  collection do
    get "search", to: "projects#search", as: "search"
  end
  resources :bugs, only: [ :index, :new, :create, :edit, :update, :destroy ]
end

resources :bugs, only: [ :index ]

    # associating controller name
    root to: "projects#index" # associating controller action
  end
