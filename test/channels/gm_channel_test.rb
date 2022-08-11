require "test_helper"

class GmChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe unique_name: adventures(:one).unique_name

    assert subscription.confirmed?
    assert_has_stream "gm_#{adventures(:one).unique_name}"
    assert_has_stream_for "gm_#{adventures(:one).unique_name}"
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
    
    assert_broadcasts("gm_#{adventure}", 2) do
      ActionCable.server.broadcast "gm_#{adventure}", { text: 'hi' }
      ActionCable.server.broadcast "gm_#{adventure}", { text: 'how are you?' }
    end

    assert_no_broadcasts "gm_#{adventure}" do
    end
  end
end
