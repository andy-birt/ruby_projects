module Enumerable
  
  def my_each
    i = 0
    while i < self.size
      yield(self[i]) if self.class == Array
      yield(self.keys[i], self.values[i]) if self.class == Hash
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.size
      yield(self[i], i) if self.class == Array
      yield(self.keys[i], self.values[i], i) if self.class == Hash
      i += 1
    end
    self
  end

  def my_select
    if self.class == Hash
      hash = {}
      my_each{|k,v| hash[k] = v if yield k,v }
      hash
    else
      arr = []
      my_each{|i| arr << i if yield i }
      arr
    end
  end

  def my_all?
    my_each{|k,v| return false if !yield k,v} if self.class == Hash
    my_each{|i| return false if !yield i} if self.class == Array
    true
  end

  def my_any?
    my_each{|k,v| return true if yield k,v} if self.class == Hash
    my_each{|i| return true if yield i} if self.class == Array
    false
  end

  def my_none?
    my_each{|k,v| return false if yield k,v } if self.class == Hash
    my_each{|i| return false if yield i } if self.class == Array
    true
  end

  def my_count
    counter = 0
    my_each{|k,v| counter += 1 } if self.class == Hash
    my_each{|i| counter += 1 } if self.class == Array
    counter
  end

  def my_map(&block)
    map = []
    my_each{|k,v| map << block.call(k,v)} if self.class == Hash
    my_each{|i| map << block.call(i)} if self.class == Array
    map
  end

  def my_inject(memo=self[0])
    self[1..-1].my_each{|i| memo = yield(memo, i)}
    memo
  end

end

#my_each

# [1, 2, 3].my_each do |i|
#   puts i
# end

# {one: 1, two: 2}.my_each do |k, v|
#   puts "#{k} => #{v}"
# end

# my_each_with_index

# [1, 2, 3].my_each_with_index do |v, i|
#   puts "Array[#{i}] = #{v}"
# end

# {one: 1, two: 2}.my_each_with_index do |k, v, i|
#   puts "#{k} => #{v} @ [#{i}]"
# end

#my_select

# [1,2,3].my_select {|i| i==2 }

# {one: 1, two: 2}.my_select {|k, v| v==2}

#my_all?

# all_test = [1,2,3].my_all? {|i| i>=2 }
# puts all_test

#my_any?

# any_test = [1,2,3].my_any? {|i| i>=2 }
# any_hash_test = {one: 1, two: 2}.my_any? {|k, v| v>2}
# puts any_test
# puts any_hash_test

#my_none

# none_test = [1,2,3].my_none? {|i| i>3 }
# none_hash_test = {one: 1, two: 2}.my_none? {|k, v| v>1}
# puts none_test
# puts none_hash_test

#my_count

# count_test = [1,2,3].my_count {|i| i }
# count_hash_test = {one: 1, two: 2}.count {|k, v| k}
# puts count_test
# puts count_hash_test

#my_map

map_test = [1,2,3].my_map {|i| i*i }
map_hash_test = {one: 1, two: 2}.my_map {|k, v| [k, v*3]}
puts map_test
puts map_hash_test

#my_inject

def multiply_elz arr
  arr.inject{|prod, e| prod * e}
end

def multiply_els arr
  arr.my_inject{|prod, e| prod * e}
end

puts multiply_elz([2,4,5])
puts multiply_els([2,4,5])