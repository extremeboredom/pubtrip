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
    assert_select 'table.table', 1
    assert_select 'table tbody tr', 1
  end

  test "should not show Add Member button when not group owner" do
    @user = users(:bob)
    login_user

    get :show, id: groups(:wft)
    assert_response :success

    assert_select 'a.btn', { count: 0, text: 'Add a Member' }
  end

  test "should now show table when there are no members of the group" do
    @user = users(:test_user)
    login_user

    get :show, id: groups(:wft_special)
    assert_response :success

    assert_select 'h1', groups(:wft_special).name
    assert_select 'p.lead', "There are no members of this group yet."
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

    assert_select 'h1.page-header', 'Groups you own'
    assert_select 'table.table'
    assert_select 'tbody tr', 2 do
      assert_select 'a'
    end
    assert_select 'h1.page-header', 'Groups you belong to'
  end

  test "should not display table when the user does not own a group" do
    @user = users(:bob)
    login_user

    get :index
    assert_response :success

    assert_select 'h1.page-header', 'Groups you own'
    assert_select 'table#owned', false
    assert_select 'p', "You don't own any groups right now."
  end

  test "should display message when the user does not belong to any groups" do
    @user = users(:test_user)
    login_user

    get :index
    assert_response :success

    assert_select 'table#belongs', false
    assert_select 'p.lead', "You don't belong to any groups right now."
  end

  test "should a table of groups that the user belongs to" do
    @user = users(:bob)
    login_user

    get :index
    assert_response :success

    assert_select 'table#belongs'
    assert_select 'table#belongs tbody tr', 1
  end
end
