require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails

  test "should not get new when logged out" do
    get :new, { group_id: groups(:wft) }
    assert_redirected_to login_path
  end

  test "should not get new when logged in as not the group owner" do
    @user = users(:bob)
    login_user

    get :new, { group_id: groups(:wft) }
    assert_redirected_to groups_path
  end

  test "should get new when logged in as the group owner" do
    group = groups(:wft)
    @user = group.owner
    login_user

    get :new, { group_id: group }
    assert_response :success

    assert_select 'h1.page-header', "Add member to #{group.name}"
    assert_select 'form fieldset' do
      assert_select 'label', 1
      assert_select 'input', 1
    end
    assert_select 'input[type="submit"]'
  end
end
