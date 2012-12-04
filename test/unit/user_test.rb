require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "name is required" do
    group = Group.new
    assert group.invalid?
    assert_equal ["can't be blank"], group.errors[:name]
  end
end
