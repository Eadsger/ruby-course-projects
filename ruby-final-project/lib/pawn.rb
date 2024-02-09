class Pawn < Piece
  include Stepable

  def to_s
    color == :black ? "♙" : "♟"
  end

  def move_directions
    [[0, 1]]
  end
end
