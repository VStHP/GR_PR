Rails.application.routes.draw do
  authenticated :user do
    root "test_templatee2#home"
  end
  root "introduce#index"
  devise_for :users, skip: %i(sessions registrations), controllers: {passwords: "devises/passwords"}
  as :user do
    get "/login", to: "devises/sessions#new", as: :new_user_session
    post "/login", to: "devises/sessions#create", as: :user_session
    delete "/logout", to: "devises/sessions#destroy", as: :destroy_user_session
    get "/users/edit", to: "devise/registrations#edit", as: :edit_user_registration
    put "/users", to: "devise/registrations#update", as: :user_registration

  end
  namespace :admin do
    as :user do
      get "profiles/:id", to: "users#show", as: :profiles_path
    end
    resources :users, except: %i(show)
  end

  get "/about", to: "test_templatee2#about", as: "about"
  get "/form/course", to: "test_templatee2#form_course", as: "form_course"
  get "/form/course/edit", to: "test_templatee2#form_course_edit", as: "form_course_edit"


end
