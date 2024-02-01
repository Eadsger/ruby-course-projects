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

  private

  def build_tree(array)
    return nil if array.empty?

    sorted_array = array.uniq.sort
    build_tree_recursive(sorted_array)
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
values = [8, 3, 10, 1, 6, 14, 4, 7, 13]
tree = Tree.new(values)

# Access the root of the tree
root_node = tree.root

# You can now perform operations on the tree, such as traversals, searching, etc.
