module ButtonHelper
	def button_submit
		"w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 mb-6"
	end

	def delete_item
		"rounded-none rounded-r-lg block flex-1 p-2 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700 text-sm"
	end

	def add_item
		"text-center font-bold cursor-pointer font-bold rounded bg-sky-500 border text-white hover:bg-blue-700 hover:bg-blue-500 block min-w-0 w-10 text-sm border-sky-300 p-2 dark:bg-sky-500 dark:border-sky-600 dark:text-white dark:hover:bg-sky-700"
	end
end