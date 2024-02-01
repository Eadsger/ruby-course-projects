class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other_node)
    # Compare nodes based on their data attribute
    @data <=> other_node.data
  end
end

# Example usage
node1 = Node.new(5)
node2 = Node.new(3)
node3 = Node.new(7)

puts node1 > node2  # Output: true
puts node1 < node3  # Output: true
puts node2 == node3 # Output: false

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def build_tree(array)
    return nil if array.empty?

    sorted_array = array.uniq.sort
    @root = build_tree_recursive(sorted_array)
  end

  def build_tree_recursive(array)
    return nil if array.empty?

    mid_index = array.length / 2
    root = Node.new(array[mid_index])

    root.left = build_tree_recursive(array[0...mid_index])
    root.right = build_tree_recursive(array[(mid_index + 1)..-1])

    root
  end
end

# Example usage
values = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(values)

# Access the root of the tree
root_node = tree.root

# You now have a balanced binary search tree based on the provided array

# Print the visual representation of the tree
tree.pretty_print
