require 'test_helper'

class RealmControllerTest < ActionController::TestCase
  test "should get token" do
    get :token
    assert_response :success
  end

  test "should get admin_token" do
    get :admin_token
    assert_response :success
  end

end
