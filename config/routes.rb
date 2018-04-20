Rails.application.routes.draw do

  authenticated :user do
    root "main#index"
  end
  root "introduce#index"
  devise_for :users, skip: %i(sessions registrations), controllers: {passwords: "devises/passwords"}
  as :user do
    get "/login", to: "devises/sessions#new", as: :new_user_session
    post "/login", to: "devises/sessions#create", as: :user_session
    delete "/logout", to: "devises/sessions#destroy", as: :destroy_user_session
    get "/users/edit", to: "devise/registrations#edit", as: :edit_user_registration
    put "/users", to: "devise/registrations#update", as: :user_registration
    get "profiles/:id", to: "users#show", as: :profiles
    patch  "user/avatar/:id", to: "users#change_avatar", as: :change_avatar
  end
  namespace :admin do
    as :user do
      patch "user/status/:id", to: "users#change_status_user", as: :change_status_user
      get "users/export/:type", to: "users#export", as: :user_export
      post "users/import", to: "users#import", as: :user_import
    end
    resources :users, except: %i(show destroy)
    resources :courses
    patch "course/status/:id", to: "courses#change_status", as: :change_status_course
    get "courses/export/:type", to: "courses#export", as: :course_export
    get "courses/export/course/:id", to: "courses#export_course", as: :course_export_course
    post "courses/import", to: "courses#import", as: :course_import
    resources :subjects
    patch "subject/status/:id", to: "subjects#change_status", as: :change_status_subject
    get "subjects/export/file", to: "subjects#export", as: :subject_export
    get "subjects/export/subject/:id", to: "subjects#export_subject", as: :subject_export_subject
    post "subjects/import", to: "subjects#import", as: :subject_import
    post "subjects/import/lessons", to: "subjects#import_lesson", as: :subject_import_lesson
    post "subjects/import/links", to: "subjects#import_link", as: :subject_import_link
    resources :lessons
    get "course/:course_id/subject/:subject_id", to: "course_subjects#show", as: :show_subject_course
    get "course/:course_id/subject/:subject_id/:status", to: "course_subjects#update", as: :update_status_cs
    resources :course_users
    resources :lessons, except: %i(new create destroy)
    get "lessons/export/exam/:id", to: "lessons#export_lesson_exam", as: :export_lesson_exam
  end

  namespace :trainer do
    resources :users, only: :index
    resources :courses, only: :index
  end

  namespace :trainee do
    get "exam_lessons/new/:course_user_lesson_id", to: "exam_lessons#new", as: :new_exam_lesson
    resources :exam_lessons, except: :new
    get "exam_lessons/course_user_lesson/:course_user_lesson_id", to: "exam_lessons#show_test_of_lesson", as: :show_test_of_lesson
  end
  get "course/:id", to: "admin/courses#show", as: :course
  get "course/:course_id/subject/:subject_id", to: "admin/course_subjects#show", as: :trainer_course_subject

  get "mycourses", to: "trainee/courses#index", as: :mycourses
  get "mycourse/:id", to: "admin/courses#show", as: :mycourse
  get "mycourse/:course_id/subject/:subject_id", to: "admin/course_subjects#show", as: :course_subject
  get "report/progress/:id/:status", to: "trainee/course_user_lessons#update", as: :report_progress

  get "/about", to: "test_templatee2#about", as: "about"
  get "/form/course", to: "test_templatee2#form_course", as: "form_course"
  get "/form/course/edit", to: "test_templatee2#form_course_edit", as: "form_course_edit"


end
