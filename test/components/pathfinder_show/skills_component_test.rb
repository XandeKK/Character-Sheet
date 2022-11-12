# frozen_string_literal: true

require "test_helper"

class PathfinderShow::SkillsComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::SkillsComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::SkillsComponent.new(character: character))

    character.pathfinder_skills.each do |skill|
      assert_text skill.name
      assert_text "Item: #{skill.item}"
      assert_text "Proficiency: #{skill.proficiency}"
      assert_text "Armor: -#{skill.armor}"
    end
  end

  test "should't create a PathfinderShow::SkillsComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::SkillsComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end
