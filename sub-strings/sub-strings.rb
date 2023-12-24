def substrings(word, dictionary)
  # Convert the word to lowercase for case-insensitive matching
  word = word.downcase

  # Initialize an empty hash to store substring occurrences
  substring_count = Hash.new(0)

  # Iterate through each substring in the dictionary
  dictionary.each do |substring|
    # Count the occurrences of the substring in the word
    count = word.scan(/#{substring.downcase}/).length

    # Update the hash with the substring and its count
    substring_count[substring] += count if count > 0
  end

  # Return the final hash
  substring_count
end

# Example usage:
dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]

result1 = substrings("below", dictionary)
puts result1
# Output: { "below" => 1, "low" => 1 }

result2 = substrings("Howdy partner, sit down! How's it going?", dictionary)
puts result2
# Output: { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
