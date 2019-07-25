require 'test_helper'

class BedsorePartsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get bedsore_parts_index_url
    assert_response :success
  end

  test 'should get show' do
    get bedsore_parts_show_url
    assert_response :success
  end

  test 'should get new' do
    get bedsore_parts_new_url
    assert_response :success
  end

  test 'should get edit' do
    get bedsore_parts_edit_url
    assert_response :success
  end

  test 'should get create' do
    get bedsore_parts_create_url
    assert_response :success
  end

  test 'should get update' do
    get bedsore_parts_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get bedsore_parts_destroy_url
    assert_response :success
  end
end
