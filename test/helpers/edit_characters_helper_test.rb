require "test_helper"

class EditCharactersHelperTest < ActionView::TestCase
	test "should return array proficiencies" do
		assert_equal(
			[
	      ["Untrained", 0],
	      ["Trained", 2],
	      ["Expert", 4],
	      ["Master", 6],
	      ["Legendary", 8]
    	],
			proficiencies
		)
	end

	test "should return array abilities" do
		assert_equal(
			[
	      ["Strength", "str"],
	      ["Dexterity", "dex"],
	      ["Constitution", "con"],
	      ["Intelligence", "int"],
	      ["Wisdom", "wis"],
	      ["Charisma", "cha"]
    	],
			abilities
		)
	end

	test "should return array alignment" do
		assert_equal(
			[
	      "Lawful Good",
	      "Lawful Neutral",
	      "Lawful Evil",
	      "Neutral Good",
	      "True Neutral",
	      "Neutral Evil",
	      "Chaotic Good",
	      "Chaotic Neutral",
	      "Chaotic Evil"
    	],
			alignment
		)
	end

	test "should return array types_feats" do
		assert_equal(
			[
	      "Ancestry",
	      "Class",
	      "Skill",
	      "General",
	      "Bonus"
	    ],
			types_feats
		)
	end

	test "should return array types_weapon" do
		assert_equal(
			[
	      "Bludgeoning",
	      "Piercing",
	      "Slashing"
    	],
			types_weapon
		)
	end

	test "should return array dice" do
		assert_equal(
			[
	      "d4",
	      "d6",
	      "d8",
	      "d10",
	      "d12",
	      "d20",
	      "d100"
    	],
			dice
		)
	end

	test "should return array magic_tradition" do
		assert_equal(
			[
	      "Arcane",
	      "Prismal",
	      "Occult",
	      "Divine"
    	],
			magic_tradition
		)
	end

	test "should return array spellcasting_type" do
		assert_equal(
			[
	      "Prepared",
      	"Spontaneous"
    	],
			spellcasting_type
		)
	end

	test "should return array spell_component" do
		assert_equal(
			[
		    "Material",
	      "Somatic",
	      "Verbal"
    	],
			spell_component
		)
	end

	test "should return array actions" do
		assert_equal(
			[
	      "1",
	      "2",
	      "3",
	      "4",
	      "5"
    	],
			actions
		)
	end
end