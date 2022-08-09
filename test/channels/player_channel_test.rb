require "test_helper"

class PlayerChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe unique_name: adventures(:one).unique_name

    assert subscription.confirmed?
    assert_has_stream "player_#{adventures(:one).unique_name}"
    assert_has_stream_for "player_#{adventures(:one).unique_name}"
  end

  test "test does not stream with incorrect adventure" do
    subscribe unique_name: -1

    assert_no_streams
  end

  test "test subscribed without adventure" do
    subscribe

    assert subscription.confirmed?

    assert_no_streams
  end

  test "test broadcasts" do
    adventure = adventures(:one).unique_name
    
    assert_broadcasts("player_#{adventure}", 2) do
      ActionCable.server.broadcast "player_#{adventure}", { text: 'hi' }
      ActionCable.server.broadcast "player_#{adventure}", { text: 'how are you?' }
    end

    assert_no_broadcasts "player_#{adventure}" do
    end
  end
end
