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
      get "profiles/:id", to: "users#show", as: :profiles
      patch "user/status/:id", to: "users#change_status_user", as: :change_status_user
      patch  "user/avatar/:id", to: "users#change_avatar", as: :change_avatar
      get "users/export/:type", to: "users#export", as: :user_export
      post "users/import", to: "users#import", as: :user_import
    end
    resources :users, except: %i(show)
    resources :courses
    patch "course/status/:id", to: "courses#change_status", as: :change_status_course
    resources :subjects
    patch "subject/status/:id", to: "subjects#change_status", as: :change_status_subject
    resources :tasks
    get "course/:course_id/subject/:subject_id", to: "course_subjects#show", as: :show_subject_course
    get "course/:course_id/subject/:subject_id/:status", to: "course_subjects#update", as: :update_status_cs
    resources :course_users
  end

  get "/about", to: "test_templatee2#about", as: "about"
  get "/form/course", to: "test_templatee2#form_course", as: "form_course"
  get "/form/course/edit", to: "test_templatee2#form_course_edit", as: "form_course_edit"


end
