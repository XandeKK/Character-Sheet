module InputHelper
  def normal_field
    "border border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 text-sm"
  end
  
  def peer_field(model=nil, name=nil)
    if model.nil? || model.errors.messages[name].empty?
      "block py-2.5 px-0 w-full bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
    else
      "block py-2.5 px-0 w-full bg-transparent border-0 border-b-2 border-red-300 appearance-none dark:border-red-600 dark:focus:border-red-500 focus:outline-none focus:ring-0 focus:border-red-600 peer"
    end
  end
end
