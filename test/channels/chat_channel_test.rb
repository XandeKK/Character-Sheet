require "test_helper"

class ChatChannelTest < ActionCable::Channel::TestCase
  def setup
    @server_name = adventures(:one).server_name
  end

  test "subscribes with server name" do
    subscribe server_name: @server_name

    assert subscription.confirmed?

    assert_has_stream "chat_#{@server_name}"
  end

  test "reject without server name" do
    subscribe

    assert subscription.rejected?
  end

  test "perform message" do
    subscribe server_name: @server_name

    perform :message, {id: 1, name: "player", message: "opa"}
    
    assert_broadcasts "chat_#{@server_name}", 1
  end

  test "perform private message" do
    subscribe server_name: @server_name

    perform :private_message, {id: 1, name: "player", message: "opa", to: "anyone"}
    
    assert_broadcasts "chat_#{@server_name}", 1
  end

  test "perform put me on chat" do
    subscribe server_name: @server_name

    perform :put_me_on_chat, {id: 1, name: "player"}
    
    assert_broadcasts "chat_#{@server_name}", 1
  end

  test "perform character exit" do
    subscribe server_name: @server_name

    perform :character_exit, {id: 1, name: "player"}
    
    assert_broadcasts "chat_#{@server_name}", 1
  end

  test "perform want characters" do
    subscribe server_name: @server_name

    perform :want_characters, {}
    
    assert_broadcasts "chat_#{@server_name}", 1
  end
end
