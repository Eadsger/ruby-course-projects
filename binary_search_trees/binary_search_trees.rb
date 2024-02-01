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
