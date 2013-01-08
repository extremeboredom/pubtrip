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

end
