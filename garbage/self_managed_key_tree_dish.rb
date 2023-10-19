require 'sqlite3'
require_relative 'dish.rb'

class SelfManagedKeyTreeDish
  # attr_accessor :dish
  def initialize
    @dish = Dish.new
    initialize_db
  end

  def initialize_db
    @db = SQLite3::Database.new ":memory:"
    @db.execute <<-SQL
      create table keys(
        id integer primary key autoincrement,
        key varchar,
        position integer,
        length integer
      );
    SQL
    @db.execute <<-SQL
      insert into keys values ( NULL, NULL, 0, 100000000 )
    SQL
  end

  def get(key)
    result = @db.execute( "select position, length from keys where key = ?", key )[0]
    @dish.get(result[0], result[1])
  end

  def clear(key)
    id = @db.execute( "select id from keys where key = ? limit 1", key )[0]

    sql = <<-SQL
      update keys set key = NULL where id = ?
    SQL
    @db.execute( sql, id)
  end

  def set(key, value)
    result = find_free_space(value.length)[0]
    id, position, size = result[0], result[1], result[2]
    length = value.length
    sql = <<-SQL
      update keys set key = ?, position = ?, length = ? where id = ?
    SQL
    @db.execute( sql, key, position, length, id)

    @dish.set(value, position)
    freespace = size - length
    if freespace > 0
      sql = <<-SQL
        insert into keys values ( NULL, NULL, ?, ? )
      SQL
      @db.execute sql, (position + length), freespace
    end
  end

  def find_free_space(length)
    sql = <<-SQL
      select id, position, length
      from keys
      where key is NULL and length >= ?
      order by position asc
      limit 1
    SQL

    @db.execute( sql, length )
  end

end

