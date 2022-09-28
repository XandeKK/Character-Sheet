require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  test "visit the sign in and should sign in" do
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:one).email
    fill_in "Password", with: "password"

    click_on "Sign in"

    assert_text "Home"
    assert_text "GM"
    assert_text "Player"
    assert_text "TV"
  end

  test "visit the sign in and should not sign in with non-existent email" do
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: "nonexistent@hey.com"
    fill_in "Password", with: "password"

    click_on "Sign in"

    assert_text "Sign in"
    assert_text "Bad email or password"
  end

  test "visit the sign in and should not sign in with wrong password" do
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:one).email
    fill_in "Password", with: "nah"

    click_on "Sign in"

    assert_text "Sign in"
    assert_text "Bad email or password"
  end
end