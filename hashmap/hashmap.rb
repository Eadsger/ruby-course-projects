class HashMap
  attr_reader :buckets, :load_factor

  def initialize(initial_size = 16, load_factor = 0.75)
    @buckets = Array.new(initial_size)
    @load_factor = load_factor
    @size = 0
  end

  def hash(key)
    key.hash % @buckets.length
  end

  def set(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      @buckets[index] = [[key, value]]
      @size += 1
    else
      found = false
      @buckets[index].each do |entry|
        if entry[0] == key
          entry[1] = value
          found = true
          break
        end
      end

      unless found
        @buckets[index] << [key, value]
        @size += 1
      end
    end

    resize_buckets if load_factor_exceeded?
  end

  def get(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      nil
    else
      @buckets[index].each do |entry|
        return entry[1] if entry[0] == key
      end
      nil
    end
  end

  def key?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    !@buckets[index].nil? && @buckets[index].any? { |entry| entry[0] == key }
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if !@buckets[index].nil?
      @buckets[index].each_with_index do |entry, i|
        if entry[0] == key
          removed_entry = @buckets[index].delete_at(i)
          @size -= 1
          return removed_entry[1]
        end
      end
    end

    nil
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@buckets.length)
    @size = 0
  end

  def keys
    @buckets.flatten(1).map { |entry| entry[0] }
  end

  def values
    @buckets.flatten(1).map { |entry| entry[1] }
  end

  def entries
    @buckets.flatten(1)
  end

  private

  def resize_buckets
    new_size = @buckets.length * 2
    new_buckets = Array.new(new_size)

    @buckets.flatten(1).each do |entry|
      index = entry[0].hash % new_size
      new_buckets[index] ||= []
      new_buckets[index] << entry
    end

    @buckets = new_buckets
  end

  def load_factor_exceeded?
    @size > @load_factor * @buckets.length
  end
end

# Create an instance of the HashMap class and use its methods.
my_hash_map = HashMap.new
my_hash_map.set("key1", "value1")
my_hash_map.set("key2", "value2")

puts my_hash_map.get("key1")  # Output: value1
puts my_hash_map.key?("key2") # Output: true

my_hash_map.remove("key1")
puts my_hash_map.get("key1")  # Output: nil

puts my_hash_map.length       # Output: 1

my_hash_map.clear
puts my_hash_map.length       # Output: 0
