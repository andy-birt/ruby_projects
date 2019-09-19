class Node

  attr_accessor :next_node, :value

  def initialize(value=nil, next_node=nil)
    @next_node = next_node
    @value = value
  end

end

class LinkedList

  attr_accessor :head, :tail, :size

  def initialize

    # Return the head (first node)

    @head = nil

    # Return the tail (last node)

    @tail = nil

    # Return the size of the list

    @size = 0
  end

  # Append to the end of the list

  def append(val)
    node = Node.new(val)
    if head
      current = head
      while(current.next_node)
        current = current.next_node
      end
      current.next_node = node
      @tail = node
    else
      @head = node
    end
    @size += 1
  end

  # Prepend to the beginning of the list

  def prepend(val)
    next_node = @head
    @tail = next_node if self.size == 1
    @head = Node.new(val, next_node)
    @size += 1
  end

  # Return node at the given index

  def at(index)
    count = 0
    current = head
    while(count < index)
      current = current.next_node
      count += 1
    end
    current.nil? ? "nil" : current
  end

  # Remove the last element in the list

  def pop
    count = 0
    current = head
    while(count < size - 2)
      current = current.next_node
      count += 1
    end
    current.next_node = nil
    @tail = current
    @size -= 1
  end

  # Return true if the element passed in value is in the list, otherwise return false

  def contains?(data)
    count = 0
    current = head
    while(count < size - 1)
      unless current.value == data
        current = current.next_node
        count += 1
      else
        return true
      end
    end
    false
  end

  # Return the index of the node containing data or nil if not found

  def find(data)
    index = 0
    current = head
    while(index < size)
      return "nil" if current.nil?
      unless current.value == data
        current = current.next_node
        index += 1
      else
        return index
      end
    end
    "nil"
  end

  # Represent LinkedList objects as strings, print them out and preview them in the console. 
  # The format should be: ( data ) -> ( data ) -> ( data ) -> nil

  def to_s
    current = head
    while(current)
      print "( #{current.value} ) -> "
      current = current.next_node
      print "nil" if current == nil
    end
  end

  ##################################################################

  # Extra Credit:

  # Insert node at given index

  def insert_at(index, value)
    # return puts "Cannot insert at #{index} while size of list is #{size}" if index > size || index < 0
    unless index == 0
      return self.append(value) if index > size
      previous_node = self.at(index-1)
      next_node = previous_node.next_node
      new_node = Node.new(value, next_node)
      previous_node.next_node = new_node
      @size += 1
    else
      self.prepend(value)
    end
  end

  # Remove node at given index

  def remove_at(index)
    puts "Size: #{self.size}, Remove: #{index}"
    puts self.to_s
    return self.pop if index >= size
    unless index == 0
      previous_node = self.at(index-1)
      puts previous_node.value
      new_next_node = previous_node.next_node.next_node
      previous_node.next_node = new_next_node
    else
      @head = @head.next_node
    end
    @size -= 1
  end

end

ll = LinkedList.new

ll.append('sue')
ll.append('lana')
ll.append('stacey')
ll.prepend('bobby')
ll.prepend('boy')
ll.append('jim-bob')

ll.insert_at(3, 'peg')
ll.remove_at(3)

ll.pop

ll.insert_at(6, "jojo")
ll.remove_at(6)

puts ll.to_s
puts ll.contains?("jojo")
puts ll.contains?("jim-bob")
puts ll.contains?("lana")
puts ll.find("bosafd")
puts ll.find("stacey")