require 'test_helper'

class RegcodesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get regcodes_new_url
    assert_response :success
  end

end
