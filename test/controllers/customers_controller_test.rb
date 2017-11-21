require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get customers_register_url
    assert_response :success
  end

end
