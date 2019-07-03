require 'test_helper'

class NursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nurses_index_url
    assert_response :success
  end

  test "should get edit" do
    get nurses_edit_url
    assert_response :success
  end

  test "should get new" do
    get nurses_new_url
    assert_response :success
  end

  test "should get show" do
    get nurses_show_url
    assert_response :success
  end

end
