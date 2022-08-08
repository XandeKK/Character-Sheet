require "test_helper"

class TvChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe unique_name: adventures(:one).unique_name

    assert subscription.confirmed?
    assert_has_stream adventures(:one).unique_name
    assert_has_stream_for adventures(:one).unique_name
  end

  test "test does not stream with incorrect unique name" do
    subscribe unique_name: -1

    assert_no_streams
  end

  test "test subscribed without unique name" do
    subscribe

    assert subscription.confirmed?

    assert_no_streams
  end

  test "test broadcasts" do
    unique_name = adventures(:one).unique_name
    
    assert_broadcasts(unique_name, 2) do
      ActionCable.server.broadcast unique_name, { text: 'hi' }
      ActionCable.server.broadcast unique_name, { text: 'how are you?' }
    end

    assert_no_broadcasts unique_name do
    end
  end
end
