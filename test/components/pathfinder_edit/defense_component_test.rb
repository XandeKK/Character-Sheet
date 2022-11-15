# frozen_string_literal: true

require "test_helper"

class PathfinderEdit::DefenseComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Context

  test "should create a PathfinderEdit::DefenseComponent" do
    character = characters(:one)
    pathfinder_defense = character.pathfinder_defense
    pathfinder_saving_throw = character.pathfinder_saving_throw

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        render_inline(PathfinderEdit::DefenseComponent.new(
          character: character,
          form: form
        ))
    end

    assert_selector "#character_pathfinder_defense_attributes_max_hp[value='#{pathfinder_defense.max_hp}']"
    assert_selector "#character_pathfinder_defense_attributes_current_hp[value='#{pathfinder_defense.current_hp}']"
    assert_selector "#character_pathfinder_defense_attributes_ancestry_hp[value='#{pathfinder_defense.ancestry_hp}']"
    assert_selector "#character_pathfinder_defense_attributes_class_hp[value='#{pathfinder_defense.class_hp}']"
    assert_selector "#character_pathfinder_defense_attributes_temp_hp[value='#{pathfinder_defense.temp_hp}']"
    
    assert_selector "#character_pathfinder_defense_attributes_dying[value='#{pathfinder_defense.dying}']"
    assert_selector "#character_pathfinder_defense_attributes_wounded[value='#{pathfinder_defense.wounded}']"
    assert_selector "#character_pathfinder_defense_attributes_resistances_and_immunities[value='#{pathfinder_defense.resistances_and_immunities}']"
    assert_selector "#character_pathfinder_defense_attributes_conditions[value='#{pathfinder_defense.conditions}']"

    assert_selector "#character_pathfinder_defense_attributes_armor_class_item[value='#{pathfinder_defense.armor_class_item}']"
    assert_selector "#character_pathfinder_defense_attributes_max_dex[value='#{pathfinder_defense.max_dex}']"

    assert_selector "#character_pathfinder_defense_attributes_unarmored_proficiency"
    assert_selector "#character_pathfinder_defense_attributes_light_proficiency"
    assert_selector "#character_pathfinder_defense_attributes_medium_proficiency"
    assert_selector "#character_pathfinder_defense_attributes_heavy_proficiency"

    assert_selector "#character_pathfinder_saving_throw_attributes_fortitude_total[value='#{pathfinder_saving_throw.fortitude_total}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_fortitude_item[value='#{pathfinder_saving_throw.fortitude_item}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_fortitude_misc[value='#{pathfinder_saving_throw.fortitude_misc}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_fortitude_penalty[value='#{pathfinder_saving_throw.fortitude_misc}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_fortitude_proficiency"

    assert_selector "#character_pathfinder_saving_throw_attributes_reflex_total[value='#{pathfinder_saving_throw.fortitude_total}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_reflex_item[value='#{pathfinder_saving_throw.reflex_item}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_reflex_misc[value='#{pathfinder_saving_throw.reflex_misc}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_reflex_penalty[value='#{pathfinder_saving_throw.reflex_misc}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_reflex_proficiency"

    assert_selector "#character_pathfinder_saving_throw_attributes_will_total[value='#{pathfinder_saving_throw.fortitude_total}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_will_item[value='#{pathfinder_saving_throw.will_item}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_will_misc[value='#{pathfinder_saving_throw.will_misc}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_will_penalty[value='#{pathfinder_saving_throw.will_misc}']"
    assert_selector "#character_pathfinder_saving_throw_attributes_will_proficiency"    

    assert_selector "#character_pathfinder_saving_throw_attributes_saving_throw_notes"
  end

  test "should't create a PathfinderEdit::DefenseComponent without character" do
    character = characters(:one)

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        exception = assert_raise ArgumentError do
          render_inline(PathfinderEdit::DefenseComponent.new(
            form: form
          ))
        end

        assert_equal("missing keyword: :character", exception.message)
    end

  end

  test "should't create a PathfinderEdit::DefenseComponent without form" do
    character = characters(:one)

    exception = assert_raise ArgumentError do
      render_inline(PathfinderEdit::DefenseComponent.new(
        character: character
      ))
    end

    assert_equal("missing keyword: :form", exception.message)
  end
end
