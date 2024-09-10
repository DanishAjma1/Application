Rails.application.routes.draw do
    # devise_for :users, controllers: {
    #       sessions: "users/sessions"
    #     }
    devise_for :users, controllers: { registrations: "users/registrations" }
    resources :projects do
  collection do
    get "search"
  end
end

resources :bugs do
  collection do
    get "search"
  end
end

    # associating controller name
    root to: "projects#index" # associating controller action
  end
