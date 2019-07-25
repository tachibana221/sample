require 'test_helper'

class DepressureToolsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get depressure_tools_index_url
    assert_response :success
  end

  test 'should get new' do
    get depressure_tools_new_url
    assert_response :success
  end

  test 'should get show' do
    get depressure_tools_show_url
    assert_response :success
  end

  test 'should get edit' do
    get depressure_tools_edit_url
    assert_response :success
  end

  test 'should get create' do
    get depressure_tools_create_url
    assert_response :success
  end

  test 'should get update' do
    get depressure_tools_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get depressure_tools_destroy_url
    assert_response :success
  end
end
