require 'test_helper'

class Trainer::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trainer_users_index_url
    assert_response :success
  end

end
