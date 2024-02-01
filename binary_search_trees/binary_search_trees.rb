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

  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def delete(value)
    @root = delete_recursive(@root, value)
  end

  def insert_recursive(node, value)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert_recursive(node.left, value)
    elsif value > node.data
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def delete_recursive(node, value)
    return node if node.nil?

    if value < node.data
      node.left = delete_recursive(node.left, value)
    elsif value > node.data
      node.right = delete_recursive(node.right, value)
    else
      # Node to be deleted found

      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      # Node has two children, find the in-order successor (smallest node in the right subtree)
      node.data = find_min_value(node.right)
      node.right = delete_recursive(node.right, node.data)
    end

    node
  end

  def find_min_value(node)
    current = node
    current = current.left until current.left.nil?
    current.data
  end

  def find(value)
    find_recursive(@root, value)
  end

  private

  def find_recursive(node, value)
    return nil if node.nil?

    if value == node.data
      return node
    elsif value < node.data
      return find_recursive(node.left, value)
    else
      return find_recursive(node.right, value)
    end
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
tree = Tree.new([8, 3, 10, 1, 6, 14, 4, 7, 13])

puts "Original tree:"
tree.pretty_print

puts "\nInserting 9:"
tree.insert(9)
tree.pretty_print

puts "\nDeleting 6:"
tree.delete(6)
tree.pretty_print

found_node = tree.find(10)

if found_node
  puts "Node with value 6 found: #{found_node.data}"
else
  puts "Node with value 6 not found."
end

# Access the root of the tree
root_node = tree.root

# Print the visual representation of the tree
tree.pretty_print
