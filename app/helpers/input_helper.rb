module InputHelper
  def read_only
    "bg-gray-300 dark:bg-gray-700"
  end

  def write_only
    "bg-gray-50 dark:bg-transparent"
  end

  def normal_field
    "border border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
  end

  def normal_select
    "bg-gray-50 dark:bg-zinc-800"
  end

  def rounded_left
    "rounded-none rounded-l-lg"
  end

  def rounded_none
    "rounded-none"
  end

  def rounded_right
    "rounded-none rounded-r-lg"
  end

  def peer_field(model=nil, name=nil)
    if model.nil? || model.errors.messages[name].empty?
      "block py-2.5 px-0 w-full bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
    else
      "block py-2.5 px-0 w-full bg-transparent border-0 border-b-2 border-red-300 appearance-none dark:border-red-600 dark:focus:border-red-500 focus:outline-none focus:ring-0 focus:border-red-600 peer"
    end
  end
end
