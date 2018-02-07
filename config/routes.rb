Rails.application.routes.draw do
  get "introduce/home", to: "test_template#home"
  get "/about", to: "test_templatee2#about", as: "about"
  root "test_templatee2#home"
end
