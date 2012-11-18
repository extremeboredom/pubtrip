require 'test_helper'

class MenuControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, { id: pubs(:generous_briton) }
    assert_response :success
  end

end
