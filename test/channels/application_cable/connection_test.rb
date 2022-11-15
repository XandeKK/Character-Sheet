require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "should connects with cookies" do
    user = users(:one)

    cookies.signed[:remember_token] = users(:one).remember_token
   
    connect
   
    assert_equal user.id, connection.current_user.id
  end

  test "should't connects without cookies" do
    assert_reject_connection { connect }
  end

  test "should't connects and disconnect" do
    user = users(:one)

    cookies.signed[:remember_token] = users(:one).remember_token
   
    connect
   
    assert_equal user.id, connection.current_user.id

    disconnect

    assert_nil connection
  end
end
