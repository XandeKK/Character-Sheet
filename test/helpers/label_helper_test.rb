require "test_helper"

class LabelHelperTest < ActionView::TestCase
	test "should return css peer_label without error" do
		user = User.new
		assert_equal("peer-focus:font-medium absolute text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6",
			peer_label(user, :email))
	end

	test "should return css peer_label with error" do
		user = User.new
		user.save

		assert_equal("peer-focus:font-medium absolute text-red-500 dark:text-red-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-red-600 peer-focus:dark:text-red-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6",
			peer_label(user, :email))
	end
end