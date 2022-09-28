require "test_helper"

class Pathfinder::AbilityTest < ActiveSupport::TestCase
  def setup
    @ability = Pathfinder::Ability.new(
      str_total: 10,
      str_free: 10,
      str_class: 10,
      str_ascentry: 10,
      str_background: 10,
      dex_total: 10,
      dex_free: 10,
      dex_class: 10,
      dex_ascentry: 10,
      dex_background: 10,
      con_total: 10,
      con_free: 10,
      con_class: 10,
      con_ascentry: 10,
      con_background: 10,
      int_total: 10,
      int_free: 10,
      int_class: 10,
      int_ascentry: 10,
      int_background: 10,
      wis_total: 10,
      wis_free: 10,
      wis_class: 10,
      wis_ascentry: 10,
      wis_background: 10,
      cha_total: 10,
      cha_free: 10,
      cha_class: 10,
      cha_ascentry: 10,
      cha_background: 10,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @ability.valid?, "Did not validate with ability valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Ability.count") do
      assert @ability.save, "Did not save with ability valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Ability.count", -1) do
      assert pathfinder_abilities(:one).destroy, "Did not destroy ability"
    end
  end

  test "should be invalid without character" do
    @ability.character = nil
    assert @ability.invalid?, "Validated the ability without character"
  end
end
