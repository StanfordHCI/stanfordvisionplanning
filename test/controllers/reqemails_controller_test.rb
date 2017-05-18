require 'test_helper'

class ReqemailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get reqemail_new_url
    assert_response :success
  end

end
