class Piece
  attr_reader :board, :color, :location

  def initialize(board, color, location)
    @board = board
    @color = color
    @location = location
  end

  def enemy?(location)
    !board[location].nil? && board[location].color != color
  end
end
