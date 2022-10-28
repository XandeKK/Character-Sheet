require "application_system_test_case"

class EnemyTest < ApplicationSystemTestCase
  def setup
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:two).email
    fill_in "Password", with: "password"

    click_on "Sign in"
  end

  test "should go Adventures" do
    find(:xpath, "/html/body/header/nav/div/button").click
    find(:xpath, '//*[@id="drawer-navigation"]/div/ul/li[2]/button').click
    click_on "Adventures"
    assert_text "Adventures"
  end

  test "should go Npcs" do
    find(:xpath, "/html/body/header/nav/div/button").click
    find(:xpath, '//*[@id="drawer-navigation"]/div/ul/li[2]/button').click
    click_on "Npcs"
    assert_text "Npcs"
  end

  test "should go Enemies" do
    find(:xpath, "/html/body/header/nav/div/button").click
    find(:xpath, '//*[@id="drawer-navigation"]/div/ul/li[2]/button').click
    click_on "Enemies"
    assert_text "Enemies"
  end

  test "should go Characters" do
    find(:xpath, "/html/body/header/nav/div/button").click
    find(:xpath, '//*[@id="drawer-navigation"]/div/ul/li[3]/button').click
    click_on "Characters"
    assert_text "Characters"
  end

  test "should go TV" do
    find(:xpath, "/html/body/header/nav/div/button").click
    find(:xpath, '//*[@id="drawer-navigation"]/div/ul/li[4]/a').click
    assert_text "Server name"
    assert_text "Password"
  end

  test "should log out" do
    find(:xpath, "/html/body/header/nav/div/button").click
    find(:xpath, '//*[@id="drawer-navigation"]/div/ul/li[5]/form/button').click
    assert_text "Sign in"
  end

  test "should active dark mode" do
    find(:xpath, "/html/body/header/nav/div/button").click
    find(:xpath, '//*[@id="theme-toggle"]').click
    assert_text "Day mode"

    find(:xpath, '//*[@id="theme-toggle"]').click
    assert_text "Night mode"
  end
end