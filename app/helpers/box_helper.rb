module BoxHelper
	def box_body
		"scrollspy md:mb-10 md:rounded-lg drop-shadow-lg bg-gray-100 dark:bg-zinc-800"
	end

	def box_header
		"p-2 flex bg-rose-800 md:rounded-t-lg"
	end

	def box_header_svg
		"menu-item w-7 h-7 fill-gray-200"
	end

	def box_header_text
		"ml-3 text-lg text-gray-200"
	end

	def box_tabs_body
		"px-3 mb-4 border-b border-gray-200 dark:border-gray-700"
	end

	def box_tabs
		"flex overflow-auto -mb-px text-sm font-medium text-center"
	end

	def box_tab_button
		"inline-block p-4 rounded-t-lg border-b-2 border-transparent hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300 dark:border-transparent text-gray-500 dark:text-gray-400 border-gray-100 dark:border-gray-700"
	end
end