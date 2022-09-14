class Pathfinder::RangedTest < ActiveSupport::TestCase
  def setup
    @ranged = Pathfinder::Ranged.new(
      name: "Paul",
      qty: "Wizard",
      types: "Elf",
      range: "Frouxo",
      proficiency: "Lorem",
      other: "Mulato",
      traits: "Neutro",
      weapon_specialization: "Nenhum",
      special: 3,
      die: "d6",
      item: 1,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @ranged.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Ranged.count") do
      assert @ranged.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Ranged.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @ranged.character = nil
    assert @ranged.invalid?, "Validated the character without character"
  end
end
