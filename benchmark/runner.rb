require_relative '../lib/key_tree_dish.rb'
require 'redis'

require 'benchmark'
require 'csv'

def benchmark_setting(backend, number_of_items_in_cache, testkeys, blob)
  bm = Benchmark.measure{
    number_of_items_in_cache.times{
      i = rand(number_of_items_in_cache)
      testkeys << i.to_s
      backend.set(i.to_s, (blob*rand(1..10))+rand.to_s)
    }
  }
  bm.to_a[5]/number_of_items_in_cache
end

def benchmark_getting(backend, number_of_items_in_cache, testkeys, blob)
  bm = Benchmark.measure{
    number_of_items_in_cache.times{
      backend.get(testkeys[rand(number_of_items_in_cache)])
    }
  }
  bm.to_a[5]/number_of_items_in_cache
end

set_csv = CSV.open("set_results.csv", "wb")
set_csv << ['number', 'Key Tree Dish', 'redis']

get_csv = CSV.open("get_results.csv", "wb")
get_csv << ['number', 'Key Tree Dish', 'redis']

f = File.open('blob.html')
blob = f.read
f.close

set_results = []
get_results = []

the_number = 5000
(250..the_number).step(250).each do |number_of_items_in_cache|
  puts number_of_items_in_cache
  ktd = KeyTreeDish.new
  r = Redis.new

  testkeys = []

  GC.start
  ktd_set_rate = benchmark_setting(ktd, number_of_items_in_cache, testkeys, blob)

  GC.start
  ktd_get_rate = benchmark_getting(ktd, number_of_items_in_cache, testkeys, blob)

  testkeys = []

  GC.start
  r_set_rate = benchmark_setting(r, number_of_items_in_cache, testkeys, blob)

  GC.start
  r_get_rate = benchmark_getting(r, number_of_items_in_cache, testkeys, blob)

  set_csv << [number_of_items_in_cache, ktd_set_rate, r_set_rate]
  get_csv << [number_of_items_in_cache, ktd_get_rate, r_get_rate]
end
set_csv.close
get_csv.close

#TODO explore this https://github.com/gettalong/kramdown/blob/master/benchmark/generate_data.rb


