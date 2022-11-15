# frozen_string_literal: true

require "test_helper"

class PathfinderEdit::StatisticsComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Context

  test "should create a PathfinderEdit::StatisticsComponent" do
    character = characters(:one)
    pathfinder_ability = character.pathfinder_ability
    pathfinder_class_dc = character.pathfinder_class_dc

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        render_inline(PathfinderEdit::StatisticsComponent.new(
          character: character,
          form: form
        ))
    end

    assert_selector "#character_pathfinder_ability_attributes_str_total[value='#{pathfinder_ability.str_total}']"
    assert_selector "#character_pathfinder_ability_attributes_str_background[value='#{pathfinder_ability.str_background}']"
    assert_selector "#character_pathfinder_ability_attributes_str_class[value='#{pathfinder_ability.str_class}']"
    assert_selector "#character_pathfinder_ability_attributes_str_ascentry[value='#{pathfinder_ability.str_ascentry}']"
    assert_selector "#character_pathfinder_ability_attributes_str_free[value='#{pathfinder_ability.str_free}']"

    assert_selector "#character_pathfinder_ability_attributes_dex_total[value='#{pathfinder_ability.dex_total}']"
    assert_selector "#character_pathfinder_ability_attributes_dex_background[value='#{pathfinder_ability.dex_background}']"
    assert_selector "#character_pathfinder_ability_attributes_dex_class[value='#{pathfinder_ability.dex_class}']"
    assert_selector "#character_pathfinder_ability_attributes_dex_ascentry[value='#{pathfinder_ability.dex_ascentry}']"
    assert_selector "#character_pathfinder_ability_attributes_dex_free[value='#{pathfinder_ability.dex_free}']"

    assert_selector "#character_pathfinder_ability_attributes_con_total[value='#{pathfinder_ability.con_total}']"
    assert_selector "#character_pathfinder_ability_attributes_con_background[value='#{pathfinder_ability.con_background}']"
    assert_selector "#character_pathfinder_ability_attributes_con_class[value='#{pathfinder_ability.con_class}']"
    assert_selector "#character_pathfinder_ability_attributes_con_ascentry[value='#{pathfinder_ability.con_ascentry}']"
    assert_selector "#character_pathfinder_ability_attributes_con_free[value='#{pathfinder_ability.con_free}']"

    assert_selector "#character_pathfinder_ability_attributes_int_total[value='#{pathfinder_ability.int_total}']"
    assert_selector "#character_pathfinder_ability_attributes_int_background[value='#{pathfinder_ability.int_background}']"
    assert_selector "#character_pathfinder_ability_attributes_int_class[value='#{pathfinder_ability.int_class}']"
    assert_selector "#character_pathfinder_ability_attributes_int_ascentry[value='#{pathfinder_ability.int_ascentry}']"
    assert_selector "#character_pathfinder_ability_attributes_int_free[value='#{pathfinder_ability.int_free}']"

    assert_selector "#character_pathfinder_ability_attributes_wis_total[value='#{pathfinder_ability.wis_total}']"
    assert_selector "#character_pathfinder_ability_attributes_wis_background[value='#{pathfinder_ability.wis_background}']"
    assert_selector "#character_pathfinder_ability_attributes_wis_class[value='#{pathfinder_ability.wis_class}']"
    assert_selector "#character_pathfinder_ability_attributes_wis_ascentry[value='#{pathfinder_ability.wis_ascentry}']"
    assert_selector "#character_pathfinder_ability_attributes_wis_free[value='#{pathfinder_ability.wis_free}']"

    assert_selector "#character_pathfinder_ability_attributes_cha_total[value='#{pathfinder_ability.cha_total}']"
    assert_selector "#character_pathfinder_ability_attributes_cha_background[value='#{pathfinder_ability.cha_background}']"
    assert_selector "#character_pathfinder_ability_attributes_cha_class[value='#{pathfinder_ability.cha_class}']"
    assert_selector "#character_pathfinder_ability_attributes_cha_ascentry[value='#{pathfinder_ability.cha_ascentry}']"
    assert_selector "#character_pathfinder_ability_attributes_cha_free[value='#{pathfinder_ability.cha_free}']"

    assert_selector "#character_pathfinder_class_dc_attributes_item[value='#{pathfinder_class_dc.item}']"
    assert_selector "#character_pathfinder_class_dc_attributes_proficiency"
  end

  test "should't create a PathfinderEdit::StatisticsComponent without character" do
    character = characters(:one)

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        exception = assert_raise ArgumentError do
          render_inline(PathfinderEdit::StatisticsComponent.new(
            form: form
          ))
        end

        assert_equal("missing keyword: :character", exception.message)
    end

  end

  test "should't create a PathfinderEdit::StatisticsComponent without form" do
    character = characters(:one)

    exception = assert_raise ArgumentError do
      render_inline(PathfinderEdit::StatisticsComponent.new(
        character: character
      ))
    end

    assert_equal("missing keyword: :form", exception.message)
  end
end