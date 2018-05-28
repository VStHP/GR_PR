require 'test_helper'

class Trainee::ExamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trainee_exams_index_url
    assert_response :success
  end

end
