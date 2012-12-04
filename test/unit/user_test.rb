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

  test "owner is required" do
    group = Group.new
    assert group.invalid?
    assert_equal ["can't be blank"], group.errors[:owner]
  end

  test "with name and owner is valid" do
    group = Group.new
    group.name = 'My First Group'
    group.owner = users(:test_user)
    assert group.valid?
  end

end
