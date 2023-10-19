require 'sinatra'
require_relative '../lib/key_tree.rb'
ktd = KeyTreeDish.new

# ktd.set(i.to_s, blob)
# ktd.get(testkeys[rand(n)])

get '/' do
  'hello world'
end
