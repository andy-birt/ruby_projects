def bubble_sort arr
  loop do
    swap = false
    for i in 0..arr.size - 2
      if arr[i] > arr[i+1]
        arr[i], arr[i+1] = arr[i+1], arr[i]
        swap = true
      end
    end
    break unless swap
  end
  arr
end

puts bubble_sort([8,3,7,1,6,4,2,5,98,87,76,65,54,43,32])