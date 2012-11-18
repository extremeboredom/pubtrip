require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails

  setup do
    @user = users(:test_user)
    @trip = trips(:first_trip)
  end

  test "should get index" do
    login_user
    get :index
    assert_response :success
    assert_not_nil assigns(:trips)
  end

  test "should get new" do
    login_user
    get :new
    assert_response :success
  end

  test "should create trip" do
    login_user
    assert_difference('Trip.count') do
      post :create, trip: { 
        date: @trip.date, 
        name: @trip.name, 
        pub_id: pubs(:generous_briton) 
      }
    end

    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should show trip" do
    get :show, id: @trip
    assert_response :success
  end

  test "should get edit" do
    login_user
    get :edit, id: @trip
    assert_response :success
  end

  test "should update trip" do
    login_user
    put :update, id: @trip, trip: { date: @trip.date, name: @trip.name }
    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should destroy trip" do
    login_user
    assert_difference('Trip.count', -1) do
      delete :destroy, id: @trip
    end

    assert_redirected_to trips_path
  end
end
