require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails
  
  test "should not get new when logged out" do
    get :new
    assert_redirected_to login_path
  end

  test "should get new when logged in" do
    @user = users(:test_user)
    login_user

    get :new
    assert_response :success
  end
end
