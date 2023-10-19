require 'sqlite3'
require_relative 'file_system_dish.rb'

class KeyTreeDish
  def initialize
    @dish = Dish.new
  end

  def get(key)
    @dish.get(key)
  end

  # todo: support deleting individual keys, and directories when ending with *
  def clear(key)
    raise
  end

  # todo: support creating directory trees based on hyphen-separation
  def set(key, value)
    @dish.set(key, value)
  end

end
