def bubble_sort(array)
  n =  array.length

  # Outer loop to iterate through all elements
  (0..n - 1).each do |i|
    # Inner loop to perform pairwise comparisons and swap if necessary
    (0..n - i - 2).each do |j|
      if array[j] > array[j + 1]
        # Swap elements if they are in the wrong order
        array[j], array[j + 1] = array[j + 1], array[j]
      end
    end
  end

  # Return the sorted array
  array
end

# Example usage
result = bubble_sort([4, 3, 78, 2, 0, 2])
puts result.inspect
