require 'test_helper'

class CareToolsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get care_tools_index_url
    assert_response :success
  end
end
