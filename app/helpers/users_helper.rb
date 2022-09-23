module UsersHelper
  def form_field(model, name)
    if model.errors.messages[name].empty?
      "block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
    else
      "block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-red-300 appearance-none dark:text-white dark:border-red-600 dark:focus:border-red-500 focus:outline-none focus:ring-0 focus:border-red-600 peer"
    end
  end

  def form_label(model, name)
    if model.errors.messages[name].empty?
      "peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6"
    else
      "peer-focus:font-medium absolute text-sm text-red-500 dark:text-red-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-red-600 peer-focus:dark:text-red-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6"
    end
  end
end
