require "application_system_test_case"

class PlayerTest < ApplicationSystemTestCase
  def setup
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:one).email
    fill_in "Password", with: "password"

    click_on "Sign in"

    click_on "Player"
  end

  test "Create Character" do
    click_on "New Character"

    assert_difference("Character.count") do
      click_on "Create"
    end

    assert_text "Character created successfully!"
    assert_text "Nameless"
  end

  test "Edit Character" do
    character = characters(:one)
    find("#dropdownMenu#{character.id}").click

    click_on "Edit"

    fill_in "Name", with: "Trouxa", id: "character_pathfinder_basic_attributes_name"

    click_on "Update"

    assert_text "Character successfully updated!"
    assert_text "Trouxa"
  end

  test "Delete Character" do
    character = characters(:one)
    find("#dropdownMenu#{character.id}").click

    click_on "delete"

    assert_text "Character successfully deleted!"
  end

  test "View character" do
    character = characters(:one)
    basic = pathfinder_basics(:one)
    defense = pathfinder_defenses(:one)

    assert_text "Characters"
    assert_text basic.name

    find("[href='/player/characters/#{character.id}']").click

    assert_text basic.name
    assert_text "STR 20"
    assert_text "Die Hard"
    assert_selector "#max_hp_character_#{character.id}", text: defense.max_hp
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp
    assert_selector "#temp_hp_character_#{character.id}", text: defense.temp_hp

    click_on "Damage"
    click_on "Damage"
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp - 2
  end
end