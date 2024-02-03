# Node class
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

# Tree class
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..-1])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return Node.new(value) unless node

    case value <=> node.data
    when -1
      node.left = insert(value, node.left)
    when 1
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return nil unless node

    case value <=> node.data
    when -1
      node.left = delete(value, node.left)
    when 1
      node.right = delete(value, node.right)
    else
      return node.right unless node.left
      return node.left unless node.right

      temp = find_min(node.right)
      node.data = temp.data
      node.right = delete(temp.data, node.right)
    end

    node
  end

  def find(value, node = @root)
    return nil unless node

    case value <=> node.data
    when -1
      find(value, node.left)
    when 0
      node
    when 1
      find(value, node.right)
    end
  end

  def level_order(&block)
    return [] unless @root

    queue = [@root]
    result = []
    while !queue.empty?
      current = queue.shift
      block_given? ? yield(current) : result.push(current.data)
      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
    end

    result
  end

  def inorder(node = @root, &block)
    return [] unless node

    result = []
    result += inorder(node.left, &block) if node.left
    block_given? ? yield(node) : result.push(node.data)
    result += inorder(node.right, &block) if node.right

    result
  end

  def preorder(node = @root, &block)
    return [] unless node

    result = []
    block_given? ? yield(node) : result.push(node.data)
    result += preorder(node.left, &block) if node.left
    result += preorder(node.right, &block) if node.right

    result
  end

  def postorder(node = @root, &block)
    return [] unless node

    result = []
    result += postorder(node.left, &block) if node.left
    result += postorder(node.right, &block) if node.right
    block_given? ? yield(node) : result.push(node.data)

    result
  end

  def height(node = @root)
    return -1 unless node

    [height(node.left), height(node.right)].max + 1
  end

  def depth(value, node = @root, depth = 0)
    return -1 unless node

    case value <=> node.data
    when -1
      depth(value, node.left, depth + 1)
    when 0
      depth
    when 1
      depth(value, node.right, depth + 1)
    end
  end

  def balanced?(node = @root)
    return true unless node

    (height(node.left) - height(node.right)).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    values = inorder
    @root = build_tree(values)
  end

  private

  def find_min(node)
    current = node
    current = current.left while current.left
    current
  end
end

# Driver script
random_numbers = Array.new(15) { rand(1..100) }
bst = Tree.new(random_numbers)

puts "Is the tree balanced? #{bst.balanced?}"
puts

puts "Level Order:"
bst.pretty_print { |node| print "#{node.data} " }
puts

puts "Pre Order:"
puts bst.preorder.join(', ')
puts

puts "Post Order:"
puts bst.postorder.join(', ')
puts

puts "In Order:"
puts bst.inorder.join(', ')
puts

# Unbalance the tree by adding several numbers > 100
unbalanced_values = [110, 120, 130, 140, 150]
unbalanced_values.each { |value| bst.insert(value) }

puts "Is the tree balanced after adding values > 100? #{bst.balanced?}"
puts

# Rebalance the tree
bst.rebalance

puts "Is the tree balanced after rebalancing? #{bst.balanced?}"
puts

puts "Level Order after rebalancing:"
bst.pretty_print { |node| print "#{node.data} " }
puts

puts "Pre Order after rebalancing:"
puts bst.preorder.join(', ')
puts

puts "Post Order after rebalancing:"
puts bst.postorder.join(', ')
puts

puts "In Order after rebalancing:"
puts bst.inorder.join(', ')
