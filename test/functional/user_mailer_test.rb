require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "reset_password_email" do
    user = users(:anthony)
    mail = UserMailer.reset_password_email(user)
    assert_equal "Your password has been reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['notifications@pubtrip.bit-universe.com'], mail.from
    assert_match "Hello", mail.body.encoded
  end

end