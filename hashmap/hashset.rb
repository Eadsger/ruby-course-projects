class HashSet
  attr_reader :buckets, :load_factor

  def initialize(initial_size = 16, load_factor = 0.75)
    @buckets = Array.new(initial_size)
    @load_factor = load_factor
    @size = 0
  end

  def hash(key)
    key.hash % @buckets.length
  end

  def add(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      @buckets[index] = [key]
      @size += 1
    else
      unless @buckets[index].include?(key)
        @buckets[index] << key
        @size += 1
      end
    end

    resize_buckets if load_factor_exceeded?
  end

  def include?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    !@buckets[index].nil? && @buckets[index].include?(key)
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if !@buckets[index].nil?
      removed = @buckets[index].delete(key)
      @size -= 1 if removed
      return removed
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
    @buckets.flatten(1)
  end

  private

  def resize_buckets
    new_size = @buckets.length * 2
    new_buckets = Array.new(new_size)

    @buckets.flatten(1).each do |key|
      index = key.hash % new_size
      new_buckets[index] ||= []
      new_buckets[index] << key
    end

    @buckets = new_buckets
  end

  def load_factor_exceeded?
    @size > @load_factor * @buckets.length
  end
end

# This HashSet class only stores keys and doesn't allow duplicate keys.
my_hash_set = HashSet.new
my_hash_set.add("key1")
my_hash_set.add("key2")

puts my_hash_set.include?("key1") # Output: true
puts my_hash_set.include?("key3") # Output: false

my_hash_set.remove("key1")
puts my_hash_set.include?("key1") # Output: false

puts my_hash_set.length            # Output: 1

my_hash_set.clear
puts my_hash_set.length            # Output: 0
