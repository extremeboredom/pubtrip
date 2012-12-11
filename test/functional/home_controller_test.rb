require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should be a trips link on the navbar" do
    get :index

    assert_select 'div.navbar li', 'Trips'
  end

  test "should be a pubs link on the navbar" do
    get :index

    assert_select 'div.navbar li', 'Pubs'
  end

  test "should be a groups link on the navbar" do
    get :index

    assert_select 'div.navbar li', 'Groups'
  end

end
