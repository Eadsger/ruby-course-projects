class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)

    if @tail.nil?
      @head = new_node
      @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node

    @tail = new_node if @tail.nil?
  end

  def size
    count = 0
    current_node = @head

    until current_node.nil?
      count += 1
      current_node = current_node.next_node
    end

    count
  end

  def at(index)
    return nil if index < 0 || index >= size

    current_node = @head
    index.times { current_node = current_node.next_node }

    current_node
  end

  def pop
    return if @head.nil?

    if @head == @tail
      @head = nil
      @tail = nil
    else
      current_node = @head
      current_node = current_node.next_node until current_node.next_node == @tail
      current_node.next_node = nil
      @tail = current_node
    end
  end

  def contains?(value)
    current_node = @head

    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_node = @head
    index = 0

    until current_node.nil?
      return index if current_node.value == value

      current_node = current_node.next_node
      index += 1
    end

    nil
  end

  def to_s
    result = ''
    current_node = @head

    until current_node.nil?
      result += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    result += 'nil'
    result
  end

  def insert_at(value, index)
    return if index < 0 || index > size

    if index.zero?
      prepend(value)
    elsif index == size
      append(value)
    else
      new_node = Node.new(value)
      previous_node = at(index - 1)

      new_node.next_node = previous_node.next_node
      previous_node.next_node = new_node
    end
  end

  def remove_at(index)
    return if index < 0 || index >= size

    if index.zero?
      @head = @head.next_node
      @tail = nil if @head.nil?
    else
      previous_node = at(index - 1)
      previous_node.next_node = previous_node.next_node.next_node

      @tail = previous_node if previous_node.next_node.nil?
    end
  end
end

# Example usage:

linked_list = LinkedList.new
linked_list.append(1)
linked_list.append(2)
linked_list.prepend(0)
linked_list.insert_at(1.5, 2)

puts "Linked List: #{linked_list.to_s}"
puts "Size: #{linked_list.size}"
puts "Head: #{linked_list.head.value}"
puts "Tail: #{linked_list.tail.value}"

linked_list.pop
puts "After pop:"
puts "Linked List: #{linked_list.to_s}"

puts "Contains 2? #{linked_list.contains?(2)}"
puts "Find index of 1.5: #{linked_list.find(1.5)}"

linked_list.remove_at(1)
puts "After removing element at index 1:"
puts "Linked List: #{linked_list.to_s}"
