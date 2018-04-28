require 'test_helper'

class Admin::SubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_subjects_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_subjects_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_subjects_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_subjects_show_url
    assert_response :success
  end

end
