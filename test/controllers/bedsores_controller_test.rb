require 'test_helper'

class BedsoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bedsores_index_url
    assert_response :success
  end

  test "should get show" do
    get bedsores_show_url
    assert_response :success
  end

  test "should get new" do
    get bedsores_new_url
    assert_response :success
  end

  test "should get edit" do
    get bedsores_edit_url
    assert_response :success
  end

end
