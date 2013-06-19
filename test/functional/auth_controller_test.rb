require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get log_in" do
    get :log_in
    assert_response :success
  end

  test "should get log_out" do
    get :log_out
    assert_response :success
  end

  test "should get regist" do
    get :regist
    assert_response :success
  end

end
