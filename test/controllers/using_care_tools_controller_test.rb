require 'test_helper'

class UsingCareToolsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get using_care_tools_index_url
    assert_response :success
  end

  test 'should get show' do
    get using_care_tools_show_url
    assert_response :success
  end

  test 'should get edit' do
    get using_care_tools_edit_url
    assert_response :success
  end
end
