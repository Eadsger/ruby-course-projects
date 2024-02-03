class KnightMoves
  def initialize
    # Possible moves for a knight in terms of (row, column) offsets
    @moves = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  end

  def valid_move?(square)
    # Check if the square is within the 8x8 chessboard
    square[0].between?(0, 7) && square[1].between?(0, 7)
  end

  def find_shortest_path(start, goal)
    # Create a queue to perform BFS
    queue = [[start, [start]]]

    until queue.empty?
      current, path = queue.shift

      if current == goal
        # Print the full path
        puts "You made it in #{path.length - 1} moves! Here's your path:"
        path.each { |square| p square }
        return
      end

      @moves.each do |move|
        next_square = [current[0] + move[0], current[1] + move[1]]

        # Check if the next square is within the 8x8 chessboard
        if valid_move?(next_square)
          # Enqueue the next square and update the path
          queue.push([next_square, path + [next_square]])
        end
      end
    end
  end
end

# Example usage
knight_moves = KnightMoves.new
knight_moves.find_shortest_path([3, 3], [4, 3])
knight_moves.find_shortest_path([0, 0], [3, 3])
knight_moves.find_shortest_path([3, 3], [0, 0])
knight_moves.find_shortest_path([0, 0], [7, 7])
