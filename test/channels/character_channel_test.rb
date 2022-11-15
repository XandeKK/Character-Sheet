require "test_helper"

class CharacterChannelTest < ActionCable::Channel::TestCase
  def setup
    @server_name = adventures(:one).server_name
  end

  test "subscribes with server name and password" do
    subscribe server_name: @server_name, password: "password"

    assert subscription.confirmed?

    assert_has_stream "character_#{@server_name}"
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

  test "perform put me on adventure" do
    subscribe server_name: @server_name, password: "password"

    perform :put_me_on_adventure, {id: 1, name: "player"}
    
    assert_broadcasts "adventure_#{@server_name}", 1
  end

  test "perform character exit" do
    subscribe server_name: @server_name, password: "password"

    perform :character_exit, {id: 1, name: "player"}
    
    assert_broadcasts "adventure_#{@server_name}", 1
    assert_broadcasts "character_#{@server_name}", 1
  end

  test "perform update hp" do
    subscribe server_name: @server_name, password: "password"

    perform :update_hp, {id: 1, name: "player", max_hp: 10, current_hp: 5}
    
    assert_broadcasts "adventure_#{@server_name}", 1
  end

  test "perform roll" do
    subscribe server_name: @server_name, password: "password"

    perform :roll, {id: 1, roll: "1d8", name: "player"}
    
    assert_broadcasts "tv_#{@server_name}", 1
  end
end
