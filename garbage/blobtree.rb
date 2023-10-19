#################################################################################

# def the_file_location(hash)
#   "data/#{hash}"
# end

# module Blobtree
#   def self.get(key)
#     path = the_file_location(key)
#     f = File.open(path, 'r')
#     v = f.read
#     f.close
#     return v
#   end
#   def self.set(key, value)
#     path = the_file_location(key)

#     # -> start transaction
#     $db.execute "insert into keys values ( ? )", key
#     File.open(path, 'w+') do |f|
#       f.write value
#     end
#     # -> close transaction
#   end
#   def self.clear(key)
#     # -> start transaction
#     # -> lock the tree that starts with key?
#     keys = $db.execute( "select * from keys where key like ?", "#{key}%" )
#     keys = keys.map{ |k| k[0]}
#     key_list = keys.map{|k| "'#{k}'" }.join(',')
#     file_list = keys.map{|k| the_file_location(k) }

#     $db.execute "delete from keys where key in (#{key_list})"
#     # name = rand
#     # Dir.mkdir("/tmp/#{name}")
#     # FileUtils.mv file_list, "/tmp/#{name}"
#     File.delete(*file_list)
#     # -> close transaction
#   end

# end

# # Blobtree.set('one', "asdfads")
# # Blobtree.set('one-two', "asdf")
# # Blobtree.set('one-two-three', "asdfads")
# # Blobtree.set('one-two-three-four', "asdfads")
# # Blobtree.set('banana', "asdfads")

# f = File.open('file.html', 'r')
# body = f.read
# f.close

# puts Benchmark.measure{
# 10_000.times do
#   Blobtree.set(rand.to_s, body) rescue nil
# end
# }



##################################################################################

# $the_index = {}

# # {one: two: :three}

# def find_or_create_tree_helper(index, tree_keys)
#   # puts args.inspect
#   if tree_keys.size == 1
#     index[tree_keys[0]]
#   else
#     find_or_create_tree_helper(tree_keys[0], tree_keys[1..keys.size])
#   end
# end

# def find_or_create_tree(key, hash)
#   keys = key.split('-').map{|x| x.to_sym}
#   element_key = keys.last
#   tree_keys   = keys[0...keys.size-1]

#   tree = find_or_create_tree_helper($index, tree_keys)

#   tree
# end
# def find_or_create_tree_helper(index, tree_keys)
  
# end
