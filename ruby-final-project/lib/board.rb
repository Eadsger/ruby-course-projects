require_relative 'slidable.rb'
require_relative 'stepable.rb'
require_relative 'piece.rb'
require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'king.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'board_renderer_text.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def self.start_chess
    board = self.new
    8.times do |column|
      board[[1, column]] = Pawn.new(:black)
      board[[6, column]] = Pawn.new(:white)
    end

    [[0, :black], [7, :white]].each do |(row, color)|
      board[[row, 0]] = Rook.new(color)
      board[[row, 7]] = Rook.new(color)
      board[[row, 1]] = Knight.new(color)
      board[[row, 6]] = Knight.new(color)
      board[[row, 2]] = Bishop.new(color)
      board[[row, 5]] = Bishop.new(color)
    end
    board[[0, 3]] = King.new(:black)
    board[[0, 4]] = Queen.new(:black)
    board[[7, 3]] = King.new(:white)
    board[[7, 4]] = Queen.new(:white)

    board
  end

  def []=(location, piece)
    row, column = location
    grid[row][column] = piece
  end

  def [](location)
    row, column = location
    grid[row][column]
  end

  def in_bounds?(location)
    row, column = location

    row < grid.length &&
    column < grid.first.length &&
    row >= 0 &&
    column >= 0
  end

  def empty?(location)
    row, column = location
    grid[row][column].nil?
  end
end


board = Board.new

board[[0, 0]] = Rook.new(board, :black, [0, 0])
p board[[0, 0]].available_moves

# renderer = BoardRendererText.new(board)

# puts renderer.render
