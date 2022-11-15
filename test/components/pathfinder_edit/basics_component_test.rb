# frozen_string_literal: true

require "test_helper"

class PathfinderEdit::BasicsComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Context

  test "should create a PathfinderEdit::BasicsComponent" do
    character = characters(:one)
    pathfinder_basic = character.pathfinder_basic
    pathfinder_perception = character.pathfinder_perception
    dice = dices(:one)

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        render_inline(PathfinderEdit::BasicsComponent.new(
          character: character,
          form: form
        ))
    end

    assert_selector "#character_pathfinder_basic_attributes_name[value='#{pathfinder_basic.name}']"
    assert_selector "#character_pathfinder_basic_attributes_class_name[value='#{pathfinder_basic.class_name}']"
    assert_selector "#character_pathfinder_basic_attributes_key_ability"
    assert_selector "#character_pathfinder_basic_attributes_background[value='#{pathfinder_basic.background}']"
    assert_selector "#character_pathfinder_basic_attributes_alignment"
    assert_selector "#character_pathfinder_basic_attributes_age[value='#{pathfinder_basic.age}']"
    assert_selector "#character_pathfinder_basic_attributes_level[value='#{pathfinder_basic.level}']"
    assert_selector "#character_pathfinder_basic_attributes_hero_points[value='#{pathfinder_basic.hero_points}']"
    assert_selector "#character_pathfinder_basic_attributes_size[value='#{pathfinder_basic.size}']"
    assert_selector "#character_pathfinder_basic_attributes_speed[value='#{pathfinder_basic.speed}']"
    assert_selector "#character_pathfinder_basic_attributes_speed_note"
    assert_selector "#character_pathfinder_basic_attributes_description"
    assert_selector "#character_pathfinder_basic_attributes_ancestry[value='#{pathfinder_basic.ancestry}']"
    assert_selector "#character_pathfinder_basic_attributes_heritage[value='#{pathfinder_basic.heritage}']"
    assert_selector "#character_pathfinder_basic_attributes_heritage_note"

    assert_selector "#character_pathfinder_perception_attributes_senses[value='#{pathfinder_perception.senses}']"
    assert_selector "#character_pathfinder_perception_attributes_proficiency"
    assert_selector "#character_pathfinder_perception_attributes_item[value='#{pathfinder_perception.item}']"
  end

  test "should't create a PathfinderEdit::BasicsComponent without character" do
    character = characters(:one)

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        exception = assert_raise ArgumentError do
          render_inline(PathfinderEdit::BasicsComponent.new(
            form: form
          ))
        end

        assert_equal("missing keyword: :character", exception.message)
    end

  end

  test "should't create a PathfinderEdit::BasicsComponent without form" do
    character = characters(:one)

    exception = assert_raise ArgumentError do
      render_inline(PathfinderEdit::BasicsComponent.new(
        character: character
      ))
    end

    assert_equal("missing keyword: :form", exception.message)
  end
end
