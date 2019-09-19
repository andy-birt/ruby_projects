def fib n
  return [0] if n == 1
  n -= 2
  res = [0, 1]
  n.times{|i| res << res[i] + res[i+1]}
  res
end

def fib_rec(n, arr = [0,1])
  return arr if n < 2
  arr << arr[-1] + arr[-2]
  fib_rec(n - 1, arr)
end

# puts fib 14

puts fib_rec 14