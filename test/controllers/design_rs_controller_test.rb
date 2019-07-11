require 'test_helper'

class DesignRsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get design_rs_index_url
    assert_response :success
  end

  test "should get show" do
    get design_rs_show_url
    assert_response :success
  end

  test "should get new" do
    get design_rs_new_url
    assert_response :success
  end

  test "should get edit" do
    get design_rs_edit_url
    assert_response :success
  end

end
