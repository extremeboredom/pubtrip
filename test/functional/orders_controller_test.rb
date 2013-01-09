require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails

  test "placing an order after the cutoff time should fail" do
    @user = users(:bob)
    login_user

    trip = trips(:expiring_trip)

    assert_no_difference('Order.count') do
      post :create, {
          order: {
              notes: 'Sausage, egg and Chips'
          },
          trip_id: trip
      }
    end

    assert_redirected_to trip_path(trip)
  end

  test "editing an order after the cutoff time should fail" do
    @user = users(:spencer)
    login_user

    trip = trips(:expiring_trip)
    order = orders(:spencer_order)

    original_notes = order.notes

    put :update, trip_id: trip,
                 id: order,
                 order: { notes: "Sausage, mash and mushy peas" }

    assert_not_nil assigns(:order)
    assert_equal original_notes, assigns(:order).notes

    assert_redirected_to trip_path trip
  end

  test "placing an order before the cutoff time should succeed" do
    @user = users(:bob)
    login_user

    notes = 'Sausage, egg and Chips'
    trip = trips(:unexpired_trip)
    attendee = attendees(:unexpired_trip_attendee)

    assert_difference('Order.count') do
      post :create, {
          order: {
              notes: notes
          },
          trip_id: trip
      }
    end

    created_order = assigns(:order)
    assert_not_nil created_order
    assert_equal attendee, created_order.attendee
    assert_equal notes, created_order.notes

    assert_redirected_to trip_order_path trip, created_order
  end

  test "placing an order while logged out should fail" do
    notes = 'Sausage, egg and Chips'
    trip = trips(:unexpired_trip)

    assert_no_difference('Order.count') do
      post :create, {
          order: {
              notes: notes
          },
          trip_id: trip
      }
    end

    assert_redirected_to login_path
  end

  #test "placing an order when you are not attending the trip should fail" do
  #  @user = users(:spencer)
  #  login_user
  #
  #  notes = 'Sausage, egg and Chips'
  #  trip = trips(:unexpired_trip)
  #
  #  assert_no_difference('Order.count') do
  #    post :create, {
  #        order: {
  #            notes: notes
  #        },
  #        trip_id: trip
  #    }
  #  end
  #
  #  assert_redirected_to trip_path trip
  #end

end
