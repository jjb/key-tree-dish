require_relative '../lib/key_tree.rb'
require 'redis'

require 'benchmark'
require 'csv'

def benchmark_setting(backend, n, testkeys, blob)
  bm = Benchmark.measure{
    n.times{
      i = rand(n)
      testkeys << i.to_s
      backend.set(i.to_s, blob)
    }
  }
  bm.to_a[5]/n
end

def benchmark_getting(backend, n, testkeys, blob)
  bm = Benchmark.measure{
    n.times{
      backend.get(testkeys[rand(n)])
    }
  }
  bm.to_a[5]/n
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
(250..the_number).step(250).each do |n|
  puts n
  ktd = KeyTreeDish.new
  r = Redis.new

  testkeys = []

  GC.start
  ktd_set_rate = benchmark_setting(ktd, n, testkeys, blob)

  GC.start
  r_set_rate = benchmark_setting(r, n, testkeys, blob)

  GC.start
  ktd_get_rate = benchmark_getting(ktd, n, testkeys, blob)

  GC.start
  r_get_rate = benchmark_getting(r, n, testkeys, blob)

  set_csv << [n, ktd_set_rate, r_set_rate]
  get_csv << [n, ktd_get_rate, r_get_rate]
end
set_csv.close
get_csv.close

#TODO explore this https://github.com/gettalong/kramdown/blob/master/benchmark/generate_data.rb


