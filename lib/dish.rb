require 'tmpdir'

class Dish

  def initialize
    @the_dir = Dir.mktmpdir
  end

  def set(key, body)
    @the_file = File.new("#{@the_dir}/#{key}", 'w+')
    @the_file.write(body)
    @the_file.close
  end

  def get(key)
    @the_file = File.open("#{@the_dir}/#{key}", 'r')
    b = @the_file.read
    @the_file.close
    b
  end

end
