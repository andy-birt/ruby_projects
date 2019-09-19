def bubble_sort_by arr
  loop do
    swap = false
    for i in 0..arr.size - 2
      if yield(arr[i], arr[i+1]) > 0
        arr[i], arr[i+1] = arr[i+1], arr[i]
        swap = true
      end
    end
    break unless swap
  end
  arr
end

sorted = bubble_sort_by(["hi", "hello", "hey"]) do |left, right|
  left.length - right.length
end

puts sorted