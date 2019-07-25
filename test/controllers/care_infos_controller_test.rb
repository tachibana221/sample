require 'test_helper'

class CareInfosControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get care_infos_index_url
    assert_response :success
  end

  test 'should get show' do
    get care_infos_show_url
    assert_response :success
  end

  test 'should get new' do
    get care_infos_new_url
    assert_response :success
  end

  test 'should get edit' do
    get care_infos_edit_url
    assert_response :success
  end
end
