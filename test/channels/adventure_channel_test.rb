require "test_helper"

class AdventureChannelTest < ActionCable::Channel::TestCase
  def setup
    @server_name = adventures(:one).server_name
  end

  test "subscribes with server name" do
    subscribe server_name: @server_name

    assert subscription.confirmed?

    assert_has_stream "adventure_#{@server_name}"
  end

  test "subscribes without server name" do
    subscribe

    assert subscription.confirmed?

    assert_has_stream "adventure_"
  end

  test "perform want players" do
    subscribe server_name: @server_name

    perform :want_players, {id: 1, name: "player"}
    
    assert_broadcasts "character_#{@server_name}", 1
  end

  test "perform roll" do
    subscribe server_name: @server_name

    perform :roll, {id: 1, roll: "1d8", name: "player"}
    
    assert_broadcasts "tv_#{@server_name}", 1
  end
end
