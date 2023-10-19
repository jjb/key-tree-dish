class SelfManagedDish

  def initialize
    @the_file = File.new("/tmp/#{rand}", 'w+')
    # name = Time.now.to_i
    # @the_file = File.new("/Volumes/memorydisk/dish.txt", 'w+')
  end

  def set(body, position)
    @the_file.seek(position, IO::SEEK_SET)
    @the_file.write(body)
    @the_file.flush
  end

  def get(position, length)
    @the_file.seek(position, IO::SEEK_SET)
    @the_file.read(length)
  end

end
