# frozen_string_literal: true

require "test_helper"

class PathfinderEdit::EquipamentComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Context

  test "should create a PathfinderEdit::EquipamentComponent" do
    character = characters(:one)
    pathfinder_money = character.pathfinder_money

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        render_inline(PathfinderEdit::EquipamentComponent.new(
          character: character,
          form: form
        ))
    end

    assert_selector "#character_pathfinder_money_attributes_copper[value='#{pathfinder_money.copper}']"
    assert_selector "#character_pathfinder_money_attributes_silver[value='#{pathfinder_money.silver}']"
    assert_selector "#character_pathfinder_money_attributes_gold[value='#{pathfinder_money.gold}']"
    assert_selector "#character_pathfinder_money_attributes_platinum[value='#{pathfinder_money.platinum}']"
  end

  test "should't create a PathfinderEdit::EquipamentComponent without character" do
    character = characters(:one)

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        exception = assert_raise ArgumentError do
          render_inline(PathfinderEdit::EquipamentComponent.new(
            form: form
          ))
        end

        assert_equal("missing keyword: :character", exception.message)
    end

  end

  test "should't create a PathfinderEdit::EquipamentComponent without form" do
    character = characters(:one)

    exception = assert_raise ArgumentError do
      render_inline(PathfinderEdit::EquipamentComponent.new(
        character: character
      ))
    end

    assert_equal("missing keyword: :form", exception.message)
  end
end
