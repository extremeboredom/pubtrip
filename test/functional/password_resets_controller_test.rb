require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  include ActionMailer::TestHelper

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

  test "should send mail when created a password reset" do
    unforgetful_user = users(:spencer)

    assert_emails 1 do
      post :create, email: unforgetful_user.email
    end

    assert_equal unforgetful_user, assigns(:user)
    assert_not_nil assigns(:user).reset_password_token

    assert_redirected_to root_path
  end

  test "should not send mail when created a password reset using invalid email" do
    assert_no_emails do
      post :create, email: 'definitelynotanemail@example.com'
    end

    assert_nil assigns(:user)

    assert_redirected_to root_path
  end

end
