class Node

  attr_accessor :value, :parent, :left, :right

  def initialize(value, parent=nil, left=nil, right=nil)
    @value = value
    @parent = parent
    @left = left
    @right = right
  end

end

class BinaryTree

  attr_accessor :root

  def initialize(arr)
    build_tree(arr)
  end

  def build_tree(arr)
    @root = Node.new(arr.shift)
    arr.each do |e|
      current = root
      add_branch(current, e)
    end
  end

  def add_branch(c, n)
    if c.value > n
      if c.left.nil?
        c.left = Node.new(n, c)
      else
        c = c.left
        add_branch(c, n)
      end
    else
      if c.right.nil?
        c.right = Node.new(n, c)
      else
        c = c.right
        add_branch(c, n)
      end
    end
  end

  def breadth_first_search(target)
    queue = []
    return if root.nil?
    queue.push(root)
    while(queue.any?)
      current = queue.shift
      return current if current.value == target
      queue.push(current.left) if !current.left.nil?
      queue.push(current.right) if !current.right.nil?
    end
  end

  def depth_first_search(target)
    stack = []
    return if root.nil?
    stack.push(root)
    while(stack.any?)
      current = stack.pop
      return current if current.value == target
      stack.push(current.left) if !current.left.nil?
      stack.push(current.right) if !current.right.nil?
    end
  end

  def dfs_rec(target, node = root)
    return if root.nil?
    p node if node.value == target
    return node if node.value == target
    dfs_rec(target, node.left) if !node.left.nil?
    dfs_rec(target, node.right) if !node.right.nil?
  end
end

arr = [4,7,2,3,5,6,1,9,8]

bt = BinaryTree.new(arr)

# puts bt.root.inspect
# p bt.breadth_first_search(1)
# p bt.depth_first_search(2)
bt.dfs_rec(3)