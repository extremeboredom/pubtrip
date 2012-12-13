require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get edit with valid token" do 
    forgetful_user = users(:anthony)

    get :edit, id: forgetful_user.reset_password_token
    assert_response :success

    assert_equal forgetful_user, assigns(:user)
  end

  test "should not get edit with invalid token" do 
    get :edit, id: 'invalid_token'
    assert_redirected_to login_path

    assert_equal nil, assigns(:user)
  end


end
