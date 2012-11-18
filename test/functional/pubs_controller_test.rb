require 'test_helper'

class PubsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails

  setup do
    @user = users(:test_user)
    @pub = pubs(:generous_briton)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pubs)
  end

  test "should get new" do
    login_user
    get :new
    assert_response :success
  end

  test "should create pub" do
    login_user
    assert_difference('Pub.count') do
      post :create, pub: { name: @pub.name }
    end

    assert_redirected_to pub_path(assigns(:pub))
  end

  test "should show pub" do
    get :show, id: @pub
    assert_response :success
  end

  test "should get edit" do
    login_user
    get :edit, id: @pub
    assert_response :success
  end

  test "should update pub" do
    login_user
    put :update, id: @pub, pub: { name: @pub.name }
    assert_redirected_to pub_path(assigns(:pub))
  end

  test "should destroy pub" do
    login_user
    assert_difference('Pub.count', -1) do
      delete :destroy, id: @pub
    end

    assert_redirected_to pubs_path
  end
end
