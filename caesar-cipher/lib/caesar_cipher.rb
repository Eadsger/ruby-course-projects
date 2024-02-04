def caesar_cipher(input_string, shift_factor)
  result = ""

  input_string.each_char do |char|
    if char.match(/[a-zA-Z]/)
      base = char.downcase == char ? 'a'.ord : 'A'.ord
      result += (((char.ord - base + shift_factor) % 26) + base).chr
    else
      result += char
    end
  end

  result
end

# Example usage:
input_string = "What a string!"
shift_factor = 5
encrypted_string = caesar_cipher(input_string, shift_factor)
puts encrypted_string
