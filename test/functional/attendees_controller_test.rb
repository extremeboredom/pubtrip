require 'test_helper'

class AttendeesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails

  test "should get create" do
    @user = users(:test_user)
    login_user
    get :create, {trip_id: trips(:first_trip)}
    assert_redirected_to trip_path(trips(:first_trip))
  end

end
