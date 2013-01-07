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
  end

end
