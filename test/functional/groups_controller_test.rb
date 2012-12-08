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

    assert_select 'h1', 'New Group'
    assert_select 'form fieldset' do
      assert_select 'label', 1
      assert_select 'input', 1
    end
    assert_select 'input[type="submit"]', { value: 'Create Group' }

  end

  test "should not create group when logged out" do
    assert_no_difference('Group.count') do
      post :create, group: { name: groups(:wft).name }
    end

    assert_redirected_to login_path
  end

  test "should not create group with no name" do
    @user = users(:test_user)
    login_user

    assert_no_difference('Group.count') do
      post :create, group: { name: '' }
    end
  end

  test "should create group when logged in" do
    @user = users(:test_user)
    login_user

    assert_difference('Group.count') do
      post :create, group: { name: groups(:wft).name }
    end

    assert_equal @user, assigns(:group).owner
    assert_redirected_to group_path(assigns(:group))
  end

  test "should not show group when logged out" do
    get :show, id: groups(:wft)
    assert_redirected_to login_path
  end

  test "should show group when logged in" do
    @user = users(:test_user)
    login_user

    get :show, id: groups(:wft)
    assert_response :success

    assert_select 'h1', groups(:wft).name
  end

  test "should not get index when logged out" do
    get :index
    assert_redirected_to login_path
  end

  test "should get index when logged in" do
    @user = users(:test_user)
    login_user

    get :index
    assert_response :success

    assert_select 'h1.page-header', 'Your Groups'
    assert_select 'table.table'
    assert_select 'tbody tr', 2 do
      assert_select 'a'
    end
  end

  test "should not display table when the user does not own a group" do
    @user = users(:bob)
    login_user

    get :index
    assert_response :success

    assert_select 'h1.page-header', 'Your Groups'
    assert_select 'table', false
    assert_select 'p', "You don't own any groups right now."
  end
end
