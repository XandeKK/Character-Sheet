require "application_system_test_case"

class AdventureTest < ApplicationSystemTestCase
  def setup
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:two).email
    fill_in "Password", with: "password"

    click_on "Sign in"

    click_on "GM"
    click_on "Adventures"
  end

  test "Create Adventure" do
    click_on "New Adventure"

    fill_in "Name", with: "Identity"
    fill_in "Password", with: "why"

    assert_difference("Adventure.count") do
      click_on "Create"
    end

    assert_text "Adventure created successfully!"
    assert_text "Identity"
  end

  test "Edit Adventure" do
    adventure = adventures(:two)
    find("#dropdownMenu#{adventure.id}").click

    click_on "Edit"

    fill_in "Name", with: "Up"
    fill_in "Password", with: "123"

    click_on "Update"

    assert_text "Adventure successfully updated!"
    assert_text "Up"
  end

  test "Delete Adventure" do
    adventure = adventures(:two)
    find("#dropdownMenu#{adventure.id}").click

    click_on "delete"

    assert_text "Adventure successfully deleted!"
  end

  test "View Adventure" do
    adventure = adventures(:two)
    character = characters(:two)
    defense = pathfinder_defenses(:two)

    assert_text "Adventures"
    assert_text adventure.name

    find("[href='/gm/adventures/#{adventure.id}']").click
    
    assert_text adventure.name

    assert_selector "#max_hp_character_#{character.id}", text: defense.max_hp
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp
    assert_selector "#temp_hp_character_#{character.id}", text: defense.temp_hp

    click_on "Damage"
    click_on "Damage"
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp
    assert_selector "#temp_hp_character_#{character.id}", text: defense.temp_hp - 2

    click_on "Add Npc"

    assert_text "Npcs"

    assert_difference("AdventureParticipation.count", -1) do
      click_on "Remove"
    end

    assert_difference("AdventureParticipation.count") do
      click_on "Add"
    end
  end
end