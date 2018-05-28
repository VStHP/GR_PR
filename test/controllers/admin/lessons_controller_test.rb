require 'test_helper'

class Admin::LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_lessons_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_lessons_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_lessons_edit_url
    assert_response :success
  end

end
