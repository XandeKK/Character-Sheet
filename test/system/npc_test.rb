require "application_system_test_case"

class NpcTest < ApplicationSystemTestCase
  def setup
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:two).email
    fill_in "Password", with: "password"

    click_on "Sign in"

    click_on "GM"
    click_on "Npcs"
  end

  test "Create Npc" do
    click_on "New Npc"

    assert_difference("Character.count") do
      click_on "Create"
    end

    assert_text "Npc created successfully!"
    assert_text "Nameless"
  end

  test "Edit Npc" do
    character = characters(:two)
    find("#dropdownMenu#{character.id}").click

    click_on "Edit"

    fill_in "Name", with: "Trouxa", id: "character_pathfinder_basic_attributes_name"

    click_on "Update"

    assert_text "Npc successfully updated!"
    assert_text "Trouxa"
  end

  test "Delete Npc" do
    character = characters(:two)
    find("#dropdownMenu#{character.id}").click

    click_on "delete"

    assert_text "Npc successfully deleted!"
  end

  test "View Npc" do
    character = characters(:two)
    basic = pathfinder_basics(:two)
    defense = pathfinder_defenses(:two)

    assert_text "Npcs"
    assert_text basic.name

    find("[href='/gm/npcs/#{character.id}']").click

    assert_text basic.name
    assert_text "STR 8"
    assert_text "Incredible Initiative"
    assert_selector "#max_hp_character_#{character.id}", text: defense.max_hp
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp
    assert_selector "#temp_hp_character_#{character.id}", text: defense.temp_hp

    click_on "Damage"
    click_on "Damage"
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp
    assert_selector "#temp_hp_character_#{character.id}", text: defense.temp_hp - 2
  end
end