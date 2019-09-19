def merge_sort(a)

  m = a.length / 2

  if a.length < 2
    a
  else
    merge(merge_sort(a[0..m-1]), merge_sort(a[m..a.length]))
  end

end

def merge(left, right)
  
  if right.empty?
    left
  elsif left.empty?
    right
  elsif left.first < right.first
    [left.first] + merge(left[1..left.length], right)
  else
    [right.first] + merge(left, right[1..right.length])
  end

end

p merge_sort([5,7,6,4,2,3,1])