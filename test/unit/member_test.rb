require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "group is required" do
    member = Member.new
    assert member.invalid?
    assert_equal ["can't be blank"], member.errors[:group]
  end

  test "user is required" do
    member = Member.new
    assert member.invalid?
    assert_equal ["can't be blank"], member.errors[:user]
  end

  test "with group and user is valid" do
    member = Member.new
    member.group = groups(:wft_special)
    member.user = users(:bob)
    assert member.valid?
  end

  test "duplicate group and user combination is invalid" do
    member = Member.new
    member.group = groups(:wft)
    member.user = users(:bob)
    assert member.invalid?
    assert_equal ["has already been taken"], member.errors[:user_id]
  end
end
