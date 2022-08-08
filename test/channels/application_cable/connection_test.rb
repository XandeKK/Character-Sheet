require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "connects with cookies" do
    cookies.signed[:remember_token] = users(:one).remember_token

    connect
  
    assert_equal connection.current_user.id, users(:one).id
  end

  test "rejects connection without params" do
    # Use `assert_reject_connection` matcher to verify that
    # connection is rejected
    assert_reject_connection { connect }
  end

end
