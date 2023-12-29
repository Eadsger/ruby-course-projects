class TicTacToe
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @current_player = 'X'
  end

  def display_board
    puts " 0 1 2"
    @board.each_with_index do |row, i|
      print "#{i}"
      puts row.join('|')
    end
    puts "\n"
  end

  def make_move(row, col)
    if @board[row][col] == ' '
      @board[row][col] = @current_player
      switch_player
    else
      puts "Invalid move! Cell already occupied. Try again."
    end
  end

  def switch_player
    @current_player = (@current_player == 'X') ? 'O' : 'X'
  end

  def winner?
    # Check rows, columns, and diagonals for a winner
    return true if check_lines(@board) || check_lines(@board.transpose) || check_diagonals

    false
  end

  def check_lines(lines)
    lines.any? { |line| line.uniq.length == 1 && line[0] != ' ' }
  end

  def check_diagonals
    left_diagonal = [@board[0][0], @board[1][1], @board[2][2]]
    right_diagonal = [@board[0][2], @board[1][1], @board[2][0]]

    left_diagonal.uniq.length == 1 && left_diagonal[0] != ' ' || right_diagonal.uniq.length == 1 && right_diagonal[0] != ' '
  end

  def board_full?
    @board.flatten.none?(' ')
  end

  def game_over?
    winner? || board_full?
  end

  def play
    until game_over?
      display_board
      puts "Player #{@current_player}'s turn"
      puts "Enter your move (row and column, e.g., '1 2'): "
      move = gets.chomp.split.map(&:to_i)
      make_move(move[0], move[1])
    end

    display_board

    if winner?
      puts "Player #{@current_player} wins!"
    else
      puts "It's a draw!"
    end
  end
end

# Start the game
game = TicTacToe.new
game.play
