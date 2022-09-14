require "test_helper"

class Pathfinder::BasicTest < ActiveSupport::TestCase
  def setup
    @basic = Pathfinder::Basic.new(
      name: "Paul",
      class_name: "Wizard",
      ancestry: "Elf",
      heritage: "Frouxo",
      heritage_note: "Lorem",
      background: "Mulato",
      alignment: "Neutro",
      deity: "Nenhum",
      key_ability: "str",
      age: "15",
      level: "1",
      hero_points: "0",
      size: "180",
      speed: "60ft",
      speed_note: "nao voa",
      description: "um cara trouxa",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @basic.valid?, "Did not validate with basic valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Basic.count") do
      assert @basic.save, "Did not save with basic valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Basic.count", -1) do
      assert pathfinder_basics(:one).destroy, "Did not destroy basic"
    end
  end

  test "should be invalid without name" do
    @basic.name = nil
    assert @basic.invalid?, "Validated the character without name"
  end

  test "should be invalid without character" do
    @basic.character = nil
    assert @basic.invalid?, "Validated the basic without character"
  end
end
