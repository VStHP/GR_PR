require 'test_helper'

class Trainee::CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trainee_courses_index_url
    assert_response :success
  end

end
