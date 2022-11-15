require "test_helper"

class TvChannelTest < ActionCable::Channel::TestCase
  def setup
    @server_name = adventures(:one).server_name
  end

  test "subscribes with server name and password" do
    subscribe server_name: @server_name, password: "password"

    assert subscription.confirmed?

    assert_has_stream "tv_#{@server_name}"
  end

  test "reject without server name" do
    subscribe password: "password"
    
    assert subscription.rejected?
  end

  test "reject with invalid password" do
    subscribe server_name: @server_name, password: "invalid"
    
    assert subscription.rejected?
  end

  test "reject with blank password" do
    subscribe server_name: @server_name, password: ""
    
    assert subscription.rejected?
  end

  test "perform message tv" do
    subscribe server_name: @server_name, password: "password"

    perform :message_tv, {id: 1, name: "player", message: "20"}
    
    assert_broadcasts "chat_#{@server_name}", 1
  end
end
