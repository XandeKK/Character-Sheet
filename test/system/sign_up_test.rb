require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "visit the sign up and create a account" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Gray"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: "Hummm"

    click_on "Sign up"

    assert_text "Home"
    assert_text "GM"
    assert_text "Player"
    assert_text "TV"
  end

  test "visit the sign up and don't create an account without name" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: ""
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: "Hummm"

    click_on "Sign up"

    assert_text "Sign up"
    assert_text "Name can't be blank"
  end

  test "visit the sign up and don't create an account without email" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Gray"
    fill_in "Email", with: ""
    fill_in "Password", with: "Hummm"

    click_on "Sign up"

    assert_text "Sign up"
    assert_text "Email is invalid"
    assert_text "Email can't be blank"
  end

  test "visit the sign up and don't create an account with email invalid" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Gray"
    fill_in "Email", with: "examples.com"
    fill_in "Password", with: "Hummm"

    click_on "Sign up"

    assert_text "Sign up"
    assert_text "Email is invalid"
  end

  test "visit the sign up and don't create an account without password" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Gray"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: ""

    click_on "Sign up"

    assert_text "Sign up"
    assert_text "Password can't be blank"
  end
end
