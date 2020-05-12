require 'test_helper'

class EditorControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get editor_create_url
    assert_response :success
  end

end
