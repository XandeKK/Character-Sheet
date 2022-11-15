require "test_helper"

class InputHelperTest < ActionView::TestCase
	test "should return css normal_field" do
		assert_equal("border border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 text-sm",
			normal_field)
	end

	test "should return css peer_field without error" do
		user = User.new
		assert_equal("block py-2.5 px-0 w-full bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer",
			peer_field(user, :email))
	end

	test "should return css peer_field with error" do
		user = User.new
		user.save

		assert_equal("block py-2.5 px-0 w-full bg-transparent border-0 border-b-2 border-red-300 appearance-none dark:border-red-600 dark:focus:border-red-500 focus:outline-none focus:ring-0 focus:border-red-600 peer",
			peer_field(user, :email))
	end
end