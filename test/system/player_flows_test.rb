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

  test "clicking all" do
    character = characters(:one)
    basic = pathfinder_basics(:one)

    assert_text "Characters"
    assert_text basic.name

    find("[href='/player/characters/#{character.id}']").click

    assert_text basic.name
    click_on "Dice"
    assert_text "Macros"
    assert_text "Attack"

    defense = pathfinder_defenses(:one)

    assert_selector "#max_hp_character_#{character.id}", text: defense.max_hp
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp
    assert_selector "#temp_hp_character_#{character.id}", text: defense.temp_hp

    click_on "Damage"
    click_on "Damage"
    assert_selector "#current_hp_character_#{character.id}", text: defense.current_hp - 2

    language = pathfinder_languages(:one)

    assert_text language.name
    find(:xpath, '//*[@id="statistics"]/div[8]/div[2]/div').click
    assert_equal language.name, find(:xpath,'//*[@id="drawer-character"]/h5').text
    assert_equal language.notes, find(:xpath, '//*[@id="drawer-character"]/p').text

    find(:xpath, '/html/body/div[2]').click # close side bar

    item = pathfinder_items(:one)

    assert_text item.name
    find(:xpath, '//*[@id="equipament"]/div[2]/div[2]/div[1]/div').click
    assert_equal item.name, find(:xpath,'//*[@id="drawer-character"]/h5').text
    assert_equal "Volume: #{item.volume} Quatity: #{item.quatity}\n\n#{item.notes}", find(:xpath, '//*[@id="drawer-character"]/p').text

    find(:xpath, '/html/body/div[2]').click # close side bar

    melee = pathfinder_melees(:one)

    assert_text melee.name
    assert_text melee.die
    find(:xpath, '//*[@id="offense"]/div[2]/ul/li').click
    assert_equal melee.name, find(:xpath,'//*[@id="drawer-character"]/h5').text
    assert_equal "Color Dice", find(:xpath, '//*[@id="drawer-character"]/div/div[1]/label').text
    assert_equal "Dice theme", find(:xpath, '//*[@id="drawer-character"]/div/div[2]/label').text

    find(:xpath, '/html/body/div[2]').click # close side bar

    skill = pathfinder_skills(:one)

    find(:xpath, '//*[@id="skills"]/div[2]/div/div[1]').click
    assert_equal skill.name, find(:xpath,'//*[@id="drawer-character"]/h5').text
    assert_equal skill.note, find(:xpath,'//*[@id="drawer-character"]/p').text

    find(:xpath, '/html/body/div[2]').click # close side bar

    spell = pathfinder_spells(:one)

    find(:xpath, '//*[@id="spell-tab"]').click
    assert_text "Level 0"
    assert spell.name

    find(:xpath, '//*[@id="level_1"]/div').click
    assert_equal spell.name, find(:xpath,'//*[@id="drawer-character"]/h5').text

    find(:xpath, '/html/body/div[2]').click # close side bar

    innate_spell = pathfinder_innate_spells(:one)

    click_on "Innate Spells"
    assert_text innate_spell.name
    find(:xpath, '//*[@id="innate-spells"]/div/div[2]/div/div').click
    assert_equal innate_spell.name, find(:xpath, '//*[@id="drawer-character"]/h5').text
    assert_equal innate_spell.notes, find(:xpath,'//*[@id="drawer-character"]/p').text

    find(:xpath, '/html/body/div[2]').click # close side bar

    focus_spell = pathfinder_focus_spells(:one)

    click_on "Focus Spells"
    assert_text focus_spell.name
    find(:xpath, '//*[@id="focus-spells"]/div/div[2]/div[2]/div').click
    assert_equal focus_spell.name, find(:xpath, '//*[@id="drawer-character"]/h5').text
    assert_equal focus_spell.notes, find(:xpath,'//*[@id="drawer-character"]/p').text

    find(:xpath, '/html/body/div[2]').click # close side bar

    note = pathfinder_notes(:one)

    assert_text note.name
    assert_text note.note
  end
end