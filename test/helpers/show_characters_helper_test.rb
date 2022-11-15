require "test_helper"

class ShowCharactersHelperTest < ActionView::TestCase
	def setup
		@character = characters(:one)
	end

	test "should return 1 get_score_level" do
		assert_equal(
			1,
			get_score_level(@character, 5)
		)
	end

	test "should return 0 get_score_level" do
		assert_equal(
			0,
			get_score_level(@character, 0)
		)
	end

	test "should return 4 get_perception" do
		assert_equal(
			4,
			get_perception(@character)
		)
	end

	test "should return 5 get_modifier of str" do
		assert_equal(
			5,
			get_modifier(@character, "str")
		)
	end

	test "should return -1 get_modifier of dex" do
		assert_equal(
			-1,
			get_modifier(@character, "dex")
		)
	end

	test "should return 5 get_modifier of con" do
		assert_equal(
			5,
			get_modifier(@character, "con")
		)
	end

	test "should return 0 get_modifier of int" do
		assert_equal(
			0,
			get_modifier(@character, "int")
		)
	end

	test "should return 1 get_modifier of wis" do
		assert_equal(
			1,
			get_modifier(@character, "wis")
		)
	end

	test "should return 2 get_modifier of cha" do
		assert_equal(
			2,
			get_modifier(@character, "cha")
		)
	end

	test "should return 14 get_armor_class" do
		assert_equal(
			14,
			get_armor_class(@character)
		)
	end

	test "should return class css key_ability? of str" do
		assert_equal(
			"bg-rose-300/50 dark:bg-rose-700/30",
			key_ability?(@character, "str"))
	end

	test "should return nil key_ability? of dex" do
		assert_nil(key_ability?(@character, "dex"))
	end

	test "should return nil key_ability? of con" do
		assert_nil(key_ability?(@character, "con"))
	end

	test "should return nil key_ability? of int" do
		assert_nil(key_ability?(@character, "int"))
	end

	test "should return nil key_ability? of wis" do
		assert_nil(key_ability?(@character, "wis"))
	end

	test "should return nil key_ability? of cha" do
		assert_nil(key_ability?(@character, "cha"))
	end

	test "should return 1 get_volume" do
		assert_equal(
			1,
			get_volume(@character))
	end

	test "should return 11 get_total_gold" do
		assert_equal(
			11,
			get_total_gold(@character))
	end

	test "should return 1d8 + 5 format_macro_notation" do
		assert_equal(
			"1d8 + 5",
			format_macro_notation(@character, "1d8 + 5")
		)
		
	end
end