# frozen_string_literal: true

require "test_helper"

class PathfinderShow::SpellsComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::SpellsComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::SpellsComponent.new(character: character))

    assert_text character.pathfinder_spell_caster.magic_tradition
    assert_text "Proficiency: #{character.pathfinder_spell_caster.attack_proficiency}"
    assert_text "Bonus: #{character.pathfinder_spell_caster.attack_bonus}"
    assert_text "Penalty: #{character.pathfinder_spell_caster.attack_penalty}"
    assert_text "Base: 10"
    assert_text "Proficiency: #{character.pathfinder_spell_caster.cd_proficiency}"
    assert_text "Bonus: #{character.pathfinder_spell_caster.cd_bonus}"
    assert_text "Penalty: #{character.pathfinder_spell_caster.cd_penalty}"
    assert_text character.pathfinder_spell_caster.notes
    
    11.times do |n|
      assert_text character.pathfinder_spell_caster["level_#{n}"]
    end

    character.pathfinder_spells.each do |spell|
      # assert_text spell.name
      assert_text spell.action
      assert_text spell.duration
      assert_text spell.range
    end

    character.pathfinder_innate_spells.each do |innate_spell|
      assert_text innate_spell.name
      assert_text innate_spell.action
      assert_text innate_spell.frequency
      assert_text innate_spell.duration
      assert_text innate_spell.range
    end

    assert_text character.pathfinder_spell_caster.max_focus_points
    assert_text character.pathfinder_spell_caster.current_focus_points

    character.pathfinder_focus_spells.each do |focus_spell|
      assert_text focus_spell.name
      assert_text focus_spell.action
      assert_text focus_spell.duration
      assert_text focus_spell.range
    end
  end

  test "should't create a PathfinderShow::SpellsComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::SpellsComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end
