require 'test_helper'

class PubsControllerTest < ActionController::TestCase
  setup do
    @pub = pubs(:generous_briton)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pubs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pub" do
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
    get :edit, id: @pub
    assert_response :success
  end

  test "should update pub" do
    put :update, id: @pub, pub: { name: @pub.name }
    assert_redirected_to pub_path(assigns(:pub))
  end

  test "should destroy pub" do
    assert_difference('Pub.count', -1) do
      delete :destroy, id: @pub
    end

    assert_redirected_to pubs_path
  end
end
