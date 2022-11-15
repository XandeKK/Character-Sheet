# frozen_string_literal: true

require "test_helper"

class PathfinderEdit::SkillsComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Context

  test "should create a PathfinderEdit::SkillsComponent" do
    character = characters(:one)

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        render_inline(PathfinderEdit::SkillsComponent.new(
          character: character,
          form: form
        ))
    end
  end

  test "should't create a PathfinderEdit::SkillsComponent without character" do
    character = characters(:one)

    form_with model: character,
      url: "/characters/#{character.character_category_id}/#{character.id}",
      method: :put do |form|

        exception = assert_raise ArgumentError do
          render_inline(PathfinderEdit::SkillsComponent.new(
            form: form
          ))
        end

        assert_equal("missing keyword: :character", exception.message)
    end

  end

  test "should't create a PathfinderEdit::SkillsComponent without form" do
    character = characters(:one)

    exception = assert_raise ArgumentError do
      render_inline(PathfinderEdit::SkillsComponent.new(
        character: character
      ))
    end

    assert_equal("missing keyword: :form", exception.message)
  end
end
