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
      notes: "sadas",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @ranged.valid?, "Did not validate with ranged valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Ranged.count") do
      assert @ranged.save, "Did not save with ranged valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Ranged.count", -1) do
      assert pathfinder_rangeds(:one).destroy, "Did not destroy ranged"
    end
  end

  test "should be invalid without character" do
    @ranged.character = nil
    assert @ranged.invalid?, "Validated the ranged without character"
  end
end
