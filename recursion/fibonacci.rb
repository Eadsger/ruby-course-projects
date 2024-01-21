def fibs(n)
  fibonacci_sequence = [0, 1]

  (2..n-1).each do |i|
    fibonacci_sequence << fibonacci_sequence[i-1] + fibonacci_sequence[i-2]
  end

  return fibonacci_sequence.take(n)
end

# Example usage
result = fibs(8)
puts result.inspect

def fibs_rec(n, sequence = [0, 1])
  return sequence.take(n) if n <= sequence.length

  fibs_rec(n, sequence << sequence[-1] + sequence[-2])
end

# Example usage
result_rec = fibs_rec(8)
puts result_rec.inspect
