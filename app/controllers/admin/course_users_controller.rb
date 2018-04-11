class Admin::CourseUsersController < ApplicationController
  load_and_authorize_resource param_method: :params_subject
end
