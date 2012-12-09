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

  test "owner of a group cannot also be a member" do
    member = Member.new
    group = groups(:wft)
    member.group = group;
    member.user = group.owner
    assert member.invalid?, "The owner of a group cannot also be a member of it"
    assert_equal ["is also the owner"], member.errors[:user]
  end

  test "user_email will set the user field" do
    member = Member.new
    member.user_email = users(:bob).email
    assert_equal users(:bob), member.user
  end

  test "user_email will return the email of the user" do
    member = Member.new
    member.user = users(:bob)
    assert_equal users(:bob).email, member.user_email
  end

  test "user_email will set user to nil if the email is incorrect" do
    member = Member.new
    user = users(:bob)
    member.user = user
    assert_equal user, member.user
    member.user_email = 'invalid@example.com'
    assert_nil member.user
  end

  test "user_email will return the last entered email even if the user is nil" do
    member = Member.new
    member.user_email = 'invalid@example.com'
    assert_nil member.user
    assert_equal 'invalid@example.com', member.user_email
  end
end
