# frozen_string_literal: true

require "test_helper"

class PathfinderShow::StatisticsComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::StatisticsComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::StatisticsComponent.new(character: character))

    assert_text character.pathfinder_ability.str_total
    assert_text character.pathfinder_ability.dex_total
    assert_text character.pathfinder_ability.con_total
    assert_text character.pathfinder_ability.int_total
    assert_text character.pathfinder_ability.wis_total
    assert_text character.pathfinder_ability.cha_total

    # not work, because use javascript
    # character.pathfinder_feats.each do |feat|
    #   assert_text feat.name
    # end

    character.pathfinder_languages.each do |language|
      assert_text language.name
    end
  end

  test "should't create a PathfinderShow::StatisticsComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::StatisticsComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end
